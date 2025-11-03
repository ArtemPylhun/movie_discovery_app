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
    return await repository.isFavorite(params.userId, params.movieId);
  }
}

class CheckFavoriteStatusParams extends Equatable {
  const CheckFavoriteStatusParams({
    required this.userId,
    required this.movieId,
  });

  final String userId;
  final int movieId;

  @override
  List<Object> get props => [userId, movieId];
}
