import 'package:movie_discovery_app/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatus {
  CheckAuthStatus(this.repository);

  final AuthRepository repository;

  Future<bool> call() async {
    return await repository.isAuthenticated();
  }
}
