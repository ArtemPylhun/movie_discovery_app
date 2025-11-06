import 'package:movie_discovery_app/features/movies/data/datasources/local/movie_database.dart';
import 'package:movie_discovery_app/features/movies/data/models/movie_model.dart';
import 'package:drift/drift.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getCachedMovies();
  Future<List<MovieModel>> getCachedMoviesByIds(List<int> ids);
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<void> cacheMovie(MovieModel movie);
  Future<void> clearCache();
  Future<List<int>> getFavoriteMovieIds(String userId);
  Future<void> addToFavorites(String userId, int movieId);
  Future<void> removeFromFavorites(String userId, int movieId);
  Future<bool> isFavorite(String userId, int movieId);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  MovieLocalDataSourceImpl(this.database);

  final MovieDatabase database;

  @override
  Future<List<MovieModel>> getCachedMovies() async {
    final dbMovies = await database.getAllMovies();
    return dbMovies.map((movie) => _movieModelFromDatabase(movie)).toList();
  }

  @override
  Future<List<MovieModel>> getCachedMoviesByIds(List<int> ids) async {
    final dbMovies = await database.getMoviesByIds(ids);
    return dbMovies.map((movie) => _movieModelFromDatabase(movie)).toList();
  }

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    final companions =
        movies.map((movie) => _movieCompanionFromModel(movie)).toList();
    await database.insertMovies(companions);
  }

  @override
  Future<void> cacheMovie(MovieModel movie) async {
    final companion = _movieCompanionFromModel(movie);
    await database.insertMovie(companion);
  }

  @override
  Future<void> clearCache() async {
    await database.clearMovies();
  }

  @override
  Future<List<int>> getFavoriteMovieIds(String userId) async {
    return await database.getFavoriteMovieIds(userId);
  }

  @override
  Future<void> addToFavorites(String userId, int movieId) async {
    await database.addToFavorites(userId, movieId);
  }

  @override
  Future<void> removeFromFavorites(String userId, int movieId) async {
    await database.removeFromFavorites(userId, movieId);
  }

  @override
  Future<bool> isFavorite(String userId, int movieId) async {
    return await database.isFavorite(userId, movieId);
  }

  // Helper methods for conversion
  MovieModel _movieModelFromDatabase(Movie dbMovie) {
    return MovieModel(
      id: dbMovie.id,
      title: dbMovie.title,
      overview: dbMovie.overview,
      posterPath: dbMovie.posterPath,
      backdropPath: dbMovie.backdropPath,
      voteAverage: dbMovie.voteAverage,
      voteCount: dbMovie.voteCount,
      releaseDate: dbMovie.releaseDate,
      genreIds: dbMovie.genreIds.isNotEmpty
          ? dbMovie.genreIds.split(',').map((e) => int.parse(e)).toList()
          : [],
      popularity: dbMovie.popularity,
      adult: dbMovie.adult,
      originalLanguage: dbMovie.originalLanguage,
      originalTitle: dbMovie.originalTitle,
    );
  }

  MoviesCompanion _movieCompanionFromModel(MovieModel movie) {
    return MoviesCompanion(
      id: Value(movie.id),
      title: Value(movie.title),
      overview: Value(movie.overview),
      posterPath: Value(movie.posterPath),
      backdropPath: Value(movie.backdropPath),
      voteAverage: Value(movie.voteAverage),
      voteCount: Value(movie.voteCount),
      releaseDate: Value(movie.releaseDate),
      genreIds: Value(movie.genreIds?.join(',') ?? ''),
      popularity: Value(movie.popularity),
      adult: Value(movie.adult),
      originalLanguage: Value(movie.originalLanguage),
      originalTitle: Value(movie.originalTitle),
      updatedAt: Value(DateTime.now()),
    );
  }
}
