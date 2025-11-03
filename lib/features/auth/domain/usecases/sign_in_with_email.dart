import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/auth/domain/entities/user.dart';
import 'package:movie_discovery_app/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmail extends UseCase<User, SignInWithEmailParams> {
  SignInWithEmail(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, User>> call(SignInWithEmailParams params) async {
    return await repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithEmailParams {
  const SignInWithEmailParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
