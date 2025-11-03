import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/exceptions.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:movie_discovery_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:movie_discovery_app/features/auth/domain/entities/user.dart';
import 'package:movie_discovery_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cache user locally
      await localDataSource.cacheUser(user);

      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Sign in failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final user = await remoteDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );

      // Cache user locally
      await localDataSource.cacheUser(user);

      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Registration failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();

      // Cache user locally
      await localDataSource.cacheUser(user);

      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Google sign in failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearCache();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Sign out failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      // Try to get from remote first
      final user = await remoteDataSource.getCurrentUser();

      if (user != null) {
        // Update cache
        await localDataSource.cacheUser(user);
        return Right(user.toEntity());
      }

      // If no remote user, try cache
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser.toEntity());
      }

      return const Right(null);
    } on ServerException catch (e) {
      // On server error, try cache
      try {
        final cachedUser = await localDataSource.getCachedUser();
        if (cachedUser != null) {
          return Right(cachedUser.toEntity());
        }
        return Left(ServerFailure(e.message));
      } catch (_) {
        return Left(ServerFailure(e.message));
      }
    } on NetworkException catch (e) {
      // On network error, use cache
      try {
        final cachedUser = await localDataSource.getCachedUser();
        if (cachedUser != null) {
          return Right(cachedUser.toEntity());
        }
        return Left(NetworkFailure(e.message));
      } catch (_) {
        return Left(NetworkFailure(e.message));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to get current user: ${e.toString()}'));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await remoteDataSource.isAuthenticated();
    } catch (e) {
      // If remote check fails, check cache
      return await localDataSource.hasCache();
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((user) {
      if (user != null) {
        // Cache user when state changes
        localDataSource.cacheUser(user);
        return user.toEntity();
      }
      // Clear cache when user signs out
      localDataSource.clearCache();
      return null;
    });
  }
}
