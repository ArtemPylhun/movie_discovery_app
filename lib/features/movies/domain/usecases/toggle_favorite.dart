import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class ToggleFavorite implements UseCase<void, ToggleFavoriteParams> {
  ToggleFavorite(this.repository);

  final MovieRepository repository;

  @override
  Future<Either<Failure, void>> call(ToggleFavoriteParams params) async {
    final isFavoriteResult =
        await repository.isFavorite(params.userId, params.movieId);

    return isFavoriteResult.fold(
      (failure) => Left(failure),
      (isFavorite) async {
        if (isFavorite) {
          return await repository.removeFromFavorites(
              params.userId, params.movieId);
        } else {
          return await repository.addToFavorites(params.userId, params.movieId);
        }
      },
    );
  }
}

class ToggleFavoriteParams extends Equatable {
  const ToggleFavoriteParams({
    required this.userId,
    required this.movieId,
  });

  final String userId;
  final int movieId;

  @override
  List<Object> get props => [userId, movieId];
}
