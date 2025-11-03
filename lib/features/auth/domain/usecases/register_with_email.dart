import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/auth/domain/entities/user.dart';
import 'package:movie_discovery_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmail extends UseCase<User, RegisterWithEmailParams> {
  RegisterWithEmail(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, User>> call(RegisterWithEmailParams params) async {
    return await repository.registerWithEmailAndPassword(
      email: params.email,
      password: params.password,
      displayName: params.displayName,
    );
  }
}

class RegisterWithEmailParams {
  const RegisterWithEmailParams({
    required this.email,
    required this.password,
    this.displayName,
  });

  final String email;
  final String password;
  final String? displayName;
}
