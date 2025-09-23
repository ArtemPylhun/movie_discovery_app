import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/exceptions.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/local/movie_local_data_source.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page) async {
    try {
      final remoteMovies = await remoteDataSource.getPopularMovies(page);

      // Cache movies in local database
      await localDataSource.cacheMovies(remoteMovies.results);

      return Right(
          remoteMovies.results.map((movie) => movie.toEntity()).toList());
    } on ServerException catch (e) {
      // Try to get cached data on server error
      try {
        final cachedMovies = await localDataSource.getCachedMovies();
        if (cachedMovies.isNotEmpty) {
          return Right(cachedMovies.map((movie) => movie.toEntity()).toList());
        }
        return Left(ServerFailure(e.message));
      } catch (_) {
        return Left(ServerFailure(e.message));
      }
    } on NetworkException catch (e) {
      // Return cached data on network error
      try {
        final cachedMovies = await localDataSource.getCachedMovies();
        if (cachedMovies.isNotEmpty) {
          return Right(cachedMovies.map((movie) => movie.toEntity()).toList());
        }
        return Left(NetworkFailure(e.message));
      } catch (_) {
        return Left(NetworkFailure(e.message));
      }
    } catch (e) {
      return Left(
          CacheFailure('Failed to get popular movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page) async {
    try {
      final remoteMovies = await remoteDataSource.getTopRatedMovies(page);

      // Cache movies in local database
      await localDataSource.cacheMovies(remoteMovies.results);

      return Right(
          remoteMovies.results.map((movie) => movie.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
          CacheFailure('Failed to get top rated movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(int page) async {
    try {
      final remoteMovies = await remoteDataSource.getUpcomingMovies(page);

      // Cache movies in local database
      await localDataSource.cacheMovies(remoteMovies.results);

      return Right(
          remoteMovies.results.map((movie) => movie.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
          CacheFailure('Failed to get upcoming movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
      String query, int page) async {
    try {
      final remoteMovies = await remoteDataSource.searchMovies(query, page);

      // Cache search results
      await localDataSource.cacheMovies(remoteMovies.results);

      return Right(
          remoteMovies.results.map((movie) => movie.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to search movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(int movieId) async {
    try {
      final remoteMovie = await remoteDataSource.getMovieDetails(movieId);

      // Cache movie details
      await localDataSource.cacheMovie(remoteMovie);

      return Right(remoteMovie.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to get movie details: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavoriteMovies() async {
    try {
      final favoriteIds = await localDataSource.getFavoriteMovieIds();
      if (favoriteIds.isEmpty) {
        return const Right([]);
      }

      final favoriteMovies =
          await localDataSource.getCachedMoviesByIds(favoriteIds);
      return Right(favoriteMovies.map((movie) => movie.toEntity()).toList());
    } catch (e) {
      return Left(
          CacheFailure('Failed to get favorite movies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(int movieId) async {
    try {
      await localDataSource.addToFavorites(movieId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to add to favorites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(int movieId) async {
    try {
      await localDataSource.removeFromFavorites(movieId);
      return const Right(null);
    } catch (e) {
      return Left(
          CacheFailure('Failed to remove from favorites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int movieId) async {
    try {
      final isFav = await localDataSource.isFavorite(movieId);
      return Right(isFav);
    } catch (e) {
      return Left(
          CacheFailure('Failed to check favorite status: ${e.toString()}'));
    }
  }
}
