import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class CheckFavoriteStatus implements UseCase<bool, CheckFavoriteStatusParams> {
  final MovieRepository repository;

  CheckFavoriteStatus(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckFavoriteStatusParams params) async {
    return await repository.isFavorite(params.movieId);
  }
}

class CheckFavoriteStatusParams extends Equatable {
  final int movieId;

  const CheckFavoriteStatusParams({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
