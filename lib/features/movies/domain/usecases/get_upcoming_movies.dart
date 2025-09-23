import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class GetUpcomingMovies implements UseCase<List<Movie>, PaginationParams> {
  GetUpcomingMovies(this.repository);

  final MovieRepository repository;

  @override
  Future<Either<Failure, List<Movie>>> call(PaginationParams params) async {
    return await repository.getUpcomingMovies(params.page);
  }
}
