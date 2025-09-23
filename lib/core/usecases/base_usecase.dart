import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}

class PaginationParams {
  final int page;
  final int? limit;

  const PaginationParams({
    required this.page,
    this.limit,
  });
}