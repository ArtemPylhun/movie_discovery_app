import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_discovery_app/core/constants/api_constants.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/core/l10n/language_provider.dart';
import 'package:movie_discovery_app/core/storage/hive_storage.dart';
import 'package:movie_discovery_app/core/theme/app_theme.dart';
import 'package:movie_discovery_app/core/theme/theme_provider.dart';
import 'package:movie_discovery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:movie_discovery_app/features/auth/presentation/providers/auth_state.dart';
import 'package:movie_discovery_app/features/auth/presentation/screens/login_screen.dart';
import 'package:movie_discovery_app/features/movies/presentation/screens/home_screen.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Validate API key is provided via --dart-define
  ApiConstants.validateApiKey();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive for local storage
  await HiveStorage.init();

  // Initialize dependency injection
  await setupDI();

  // Get SharedPreferences instance for theme provider
  final sharedPreferences = getIt<SharedPreferences>();

  runApp(
    ProviderScope(
      overrides: [
        // Override the sharedPreferences provider with actual instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MovieDiscoveryApp(),
    ),
  );
}

class MovieDiscoveryApp extends ConsumerWidget {
  const MovieDiscoveryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);

    return MaterialApp(
      title: 'Movie Discovery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      home: const AuthGate(),
    );
  }
}

/// AuthGate widget that determines which screen to show based on auth state
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      initial: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      authenticated: (_) => const HomeScreen(),
      unauthenticated: () => const LoginScreen(),
      error: (_) => const LoginScreen(),
    );
  }
}

/// Extension to handle AuthState with a when method
extension AuthStateExtension on AuthState {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(dynamic user) authenticated,
    required T Function() unauthenticated,
    required T Function(String message) error,
  }) {
    if (this is AuthInitial) {
      return initial();
    } else if (this is AuthLoading) {
      return loading();
    } else if (this is Authenticated) {
      return authenticated((this as Authenticated).user);
    } else if (this is Unauthenticated) {
      return unauthenticated();
    } else if (this is AuthError) {
      return error((this as AuthError).message);
    }
    return initial();
  }
}
