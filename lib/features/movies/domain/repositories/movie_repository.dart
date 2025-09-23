import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page);
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page);
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page);
  Future<Either<Failure, List<Movie>>> searchMovies(String query, int page);
  Future<Either<Failure, Movie>> getMovieDetails(int movieId);
}