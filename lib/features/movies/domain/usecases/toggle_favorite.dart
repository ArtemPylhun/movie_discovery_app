import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class ToggleFavorite implements UseCase<void, ToggleFavoriteParams> {
  final MovieRepository repository;

  ToggleFavorite(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleFavoriteParams params) async {
    final isFavoriteResult = await repository.isFavorite(params.movieId);

    return isFavoriteResult.fold(
      (failure) => Left(failure),
      (isFavorite) async {
        if (isFavorite) {
          return await repository.removeFromFavorites(params.movieId);
        } else {
          return await repository.addToFavorites(params.movieId);
        }
      },
    );
  }
}

class ToggleFavoriteParams extends Equatable {
  final int movieId;

  const ToggleFavoriteParams({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
