import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'movie_database.g.dart';

// Tables
@DataClassName('Movie')
class Movies extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get overview => text()();
  TextColumn get posterPath => text().nullable()();
  TextColumn get backdropPath => text().nullable()();
  RealColumn get voteAverage => real()();
  IntColumn get voteCount => integer()();
  TextColumn get releaseDate => text()();
  TextColumn get genreIds => text()(); // JSON encoded list
  RealColumn get popularity => real()();
  BoolColumn get adult => boolean()();
  TextColumn get originalLanguage => text()();
  TextColumn get originalTitle => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Favorites extends Table {
  IntColumn get movieId => integer().references(Movies, #id)();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {movieId};
}

class Genres extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class SearchCache extends Table {
  TextColumn get query => text()();
  TextColumn get results => text()(); // JSON encoded movie IDs
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {query};
}

@DriftDatabase(tables: [Movies, Favorites, Genres, SearchCache])
class MovieDatabase extends _$MovieDatabase {
  MovieDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
      },
    );
  }

  // Movie operations
  Future<List<Movie>> getAllMovies() => select(movies).get();

  Future<List<Movie>> getMoviesByIds(List<int> ids) =>
      (select(movies)..where((m) => m.id.isIn(ids))).get();

  Future<void> insertMovie(MoviesCompanion movie) =>
      into(movies).insertOnConflictUpdate(movie);

  Future<void> insertMovies(List<MoviesCompanion> movieList) =>
      batch((batch) {
        batch.insertAllOnConflictUpdate(movies, movieList);
      });

  Future<void> deleteMovie(int movieId) =>
      (delete(movies)..where((m) => m.id.equals(movieId))).go();

  Future<void> clearMovies() => delete(movies).go();

  // Favorites operations
  Future<List<int>> getFavoriteMovieIds() async {
    final favorites = await select(this.favorites).get();
    return favorites.map((f) => f.movieId).toList();
  }

  Future<void> addToFavorites(int movieId) =>
      into(favorites).insert(FavoritesCompanion(movieId: Value(movieId)));

  Future<void> removeFromFavorites(int movieId) =>
      (delete(favorites)..where((f) => f.movieId.equals(movieId))).go();

  Future<bool> isFavorite(int movieId) async {
    final count = await (selectOnly(favorites)
          ..addColumns([favorites.movieId.count()])
          ..where(favorites.movieId.equals(movieId)))
        .getSingle();
    return count.read(favorites.movieId.count())! > 0;
  }

  // Cache operations
  Future<void> clearOldCache() async {
    final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    await (delete(movies)..where((m) => m.updatedAt.isSmallerThanValue(oneWeekAgo))).go();
    await (delete(searchCache)..where((s) => s.cachedAt.isSmallerThanValue(oneWeekAgo))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'movie_database.db'));
    return NativeDatabase(file);
  });
}