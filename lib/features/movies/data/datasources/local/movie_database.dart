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
  TextColumn get userId => text()(); // User ID from Firebase Auth
  IntColumn get movieId => integer().references(Movies, #id)();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, movieId}; // Composite key
}

@DriftDatabase(tables: [Movies, Favorites])
class MovieDatabase extends _$MovieDatabase {
  MovieDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Migration from v1 to v2: Remove Genres and SearchCache tables
          // These tables are no longer used, so we recreate the entire database
          await m.deleteTable('genres');
          await m.deleteTable('search_cache');
        }
        if (from < 3) {
          // Migration from v2 to v3: Add userId to Favorites table
          // Drop old favorites table and recreate with userId column
          await m.deleteTable('favorites');
          await m.createTable(favorites);
        }
      },
    );
  }

  // Movie operations
  Future<List<Movie>> getAllMovies() => select(movies).get();

  Future<List<Movie>> getMoviesByIds(List<int> ids) =>
      (select(movies)..where((m) => m.id.isIn(ids))).get();

  Future<void> insertMovie(MoviesCompanion movie) =>
      into(movies).insertOnConflictUpdate(movie);

  Future<void> insertMovies(List<MoviesCompanion> movieList) => batch((batch) {
        batch.insertAllOnConflictUpdate(movies, movieList);
      });

  Future<void> deleteMovie(int movieId) =>
      (delete(movies)..where((m) => m.id.equals(movieId))).go();

  Future<void> clearMovies() => delete(movies).go();

  // Favorites operations (user-specific)
  Future<List<int>> getFavoriteMovieIds(String userId) async {
    final userFavorites =
        await (select(favorites)..where((f) => f.userId.equals(userId))).get();
    return userFavorites.map((f) => f.movieId).toList();
  }

  Future<void> addToFavorites(String userId, int movieId) =>
      into(favorites).insert(
          FavoritesCompanion(userId: Value(userId), movieId: Value(movieId)));

  Future<void> removeFromFavorites(String userId, int movieId) =>
      (delete(favorites)
            ..where((f) => f.userId.equals(userId) & f.movieId.equals(movieId)))
          .go();

  Future<bool> isFavorite(String userId, int movieId) async {
    final count = await (selectOnly(favorites)
          ..addColumns([favorites.movieId.count()])
          ..where(favorites.userId.equals(userId) &
              favorites.movieId.equals(movieId)))
        .getSingle();
    return count.read(favorites.movieId.count())! > 0;
  }

  // Cache operations
  Future<void> clearOldCache() async {
    final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    await (delete(movies)
          ..where((m) => m.updatedAt.isSmallerThanValue(oneWeekAgo)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'movie_database.db'));
    return NativeDatabase(file);
  });
}
