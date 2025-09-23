import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {
  const NoParams();
}

class PaginationParams {
  const PaginationParams({
    required this.page,
    this.limit,
  });

  final int page;
  final int? limit;
}
