import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/register_with_email.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/sign_out.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:movie_discovery_app/features/auth/domain/usecases/check_auth_status.dart';
import 'package:movie_discovery_app/features/auth/presentation/providers/auth_state.dart';

// Use Case Providers
final signInWithEmailProvider = Provider<SignInWithEmail>(
  (ref) => getIt<SignInWithEmail>(),
);

final registerWithEmailProvider = Provider<RegisterWithEmail>(
  (ref) => getIt<RegisterWithEmail>(),
);

final signInWithGoogleProvider = Provider<SignInWithGoogle>(
  (ref) => getIt<SignInWithGoogle>(),
);

final signOutProvider = Provider<SignOut>(
  (ref) => getIt<SignOut>(),
);

final getCurrentUserProvider = Provider<GetCurrentUser>(
  (ref) => getIt<GetCurrentUser>(),
);

final checkAuthStatusProvider = Provider<CheckAuthStatus>(
  (ref) => getIt<CheckAuthStatus>(),
);

// State Providers
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.read(signInWithEmailProvider),
    ref.read(registerWithEmailProvider),
    ref.read(signInWithGoogleProvider),
    ref.read(signOutProvider),
    ref.read(getCurrentUserProvider),
  ),
);

// Helper provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState is Authenticated;
});
