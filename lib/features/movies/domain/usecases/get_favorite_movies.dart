import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class GetFavoriteMovies
    implements UseCase<List<Movie>, GetFavoriteMoviesParams> {
  GetFavoriteMovies(this.repository);

  final MovieRepository repository;

  @override
  Future<Either<Failure, List<Movie>>> call(
      GetFavoriteMoviesParams params) async {
    return await repository.getFavoriteMovies(params.userId);
  }
}

class GetFavoriteMoviesParams extends Equatable {
  const GetFavoriteMoviesParams({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}
