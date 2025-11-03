import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/video.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page);
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page);
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page);
  Future<Either<Failure, List<Movie>>> searchMovies(String query, int page);
  Future<Either<Failure, Movie>> getMovieDetails(int movieId);
  Future<Either<Failure, List<Video>>> getMovieVideos(int movieId);

  // Favorites management (user-specific)
  Future<Either<Failure, List<Movie>>> getFavoriteMovies(String userId);
  Future<Either<Failure, void>> addToFavorites(String userId, int movieId);
  Future<Either<Failure, void>> removeFromFavorites(String userId, int movieId);
  Future<Either<Failure, bool>> isFavorite(String userId, int movieId);
}
