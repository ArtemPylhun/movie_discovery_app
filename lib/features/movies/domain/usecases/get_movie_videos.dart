import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/video.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class GetMovieVideos implements UseCase<List<Video>, GetMovieVideosParams> {
  GetMovieVideos(this.repository);

  final MovieRepository repository;

  @override
  Future<Either<Failure, List<Video>>> call(GetMovieVideosParams params) async {
    return await repository.getMovieVideos(params.movieId);
  }
}

class GetMovieVideosParams extends Equatable {
  const GetMovieVideosParams({required this.movieId});

  final int movieId;

  @override
  List<Object> get props => [movieId];
}
