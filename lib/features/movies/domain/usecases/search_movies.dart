import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';

class SearchMovies extends BaseUseCase<List<Movie>, SearchParams> {
  final MovieRepository repository;

  SearchMovies(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(SearchParams params) async {
    return await repository.searchMovies(params.query, params.page);
  }
}

class SearchParams {
  final String query;
  final int page;

  const SearchParams({
    required this.query,
    required this.page,
  });
}