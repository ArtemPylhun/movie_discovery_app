import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class CheckFavoriteStatus implements UseCase<bool, CheckFavoriteStatusParams> {
  CheckFavoriteStatus(this.repository);

  final MovieRepository repository;

  @override
  Future<Either<Failure, bool>> call(CheckFavoriteStatusParams params) async {
    return await repository.isFavorite(params.movieId);
  }
}

class CheckFavoriteStatusParams extends Equatable {
  const CheckFavoriteStatusParams({required this.movieId});

  final int movieId;

  @override
  List<Object> get props => [movieId];
}
