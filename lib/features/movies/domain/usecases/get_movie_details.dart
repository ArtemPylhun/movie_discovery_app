import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class GetMovieDetails implements UseCase<Movie, GetMovieDetailsParams> {
  GetMovieDetails(this.repository);

  final MovieRepository repository;

  @override
  Future<Either<Failure, Movie>> call(GetMovieDetailsParams params) async {
    return await repository.getMovieDetails(params.movieId);
  }
}

class GetMovieDetailsParams extends Equatable {
  const GetMovieDetailsParams({required this.movieId});

  final int movieId;

  @override
  List<Object> get props => [movieId];
}
