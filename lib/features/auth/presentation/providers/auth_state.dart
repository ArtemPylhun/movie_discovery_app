import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/auth/domain/entities/user.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/register_with_email.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/sign_out.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/get_current_user.dart';

// Auth State
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  const Authenticated(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    this._signInWithEmail,
    this._registerWithEmail,
    this._signInWithGoogle,
    this._signOut,
    this._getCurrentUser,
  ) : super(const AuthInitial()) {
    _checkAuthStatus();
  }

  final SignInWithEmail _signInWithEmail;
  final RegisterWithEmail _registerWithEmail;
  final SignInWithGoogle _signInWithGoogle;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;

  Future<void> _checkAuthStatus() async {
    state = const AuthLoading();
    final result = await _getCurrentUser(const NoParams());

    result.fold(
      (failure) => state = const Unauthenticated(),
      (user) {
        if (user != null) {
          state = Authenticated(user);
        } else {
          state = const Unauthenticated();
        }
      },
    );
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();
    final result = await _signInWithEmail(
      SignInWithEmailParams(email: email, password: password),
    );

    result.fold(
      (failure) => state = AuthError(failure.message),
      (user) => state = Authenticated(user),
    );
  }

  Future<void> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AuthLoading();
    final result = await _registerWithEmail(
      RegisterWithEmailParams(
        email: email,
        password: password,
        displayName: displayName,
      ),
    );

    result.fold(
      (failure) => state = AuthError(failure.message),
      (user) => state = Authenticated(user),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading();
    final result = await _signInWithGoogle(const NoParams());

    result.fold(
      (failure) => state = AuthError(failure.message),
      (user) => state = Authenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    final result = await _signOut(const NoParams());

    result.fold(
      (failure) => state = AuthError(failure.message),
      (_) => state = const Unauthenticated(),
    );
  }

  void clearError() {
    if (state is AuthError) {
      state = const Unauthenticated();
    }
  }
}
