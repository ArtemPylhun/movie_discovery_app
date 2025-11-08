import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_discovery_app/main.dart' as app;

/// Main integration test file - Basic smoke test
///
/// ⚠️ IMPORTANT: Due to app initialization conflicts when calling app.main()
/// multiple times, this file only runs a basic smoke test.
///
/// For comprehensive integration testing, run individual flow test files:
///
/// ```bash
/// # Set API key first (Windows)
/// set TMDB_KEY=your_api_key_here
///
/// # Run individual flow tests
/// flutter test integration_test/flows/authentication_flow_test.dart --dart-define=TMDB_KEY=%TMDB_KEY%
/// flutter test integration_test/flows/movie_browsing_flow_test.dart --dart-define=TMDB_KEY=%TMDB_KEY%
/// flutter test integration_test/flows/search_flow_test.dart --dart-define=TMDB_KEY=%TMDB_KEY%
/// flutter test integration_test/flows/favorites_flow_test.dart --dart-define=TMDB_KEY=%TMDB_KEY%
/// flutter test integration_test/flows/settings_flow_test.dart --dart-define=TMDB_KEY=%TMDB_KEY%
/// ```
///
/// Mac/Linux:
/// ```bash
/// export TMDB_KEY=your_api_key_here
/// flutter test integration_test/flows/authentication_flow_test.dart --dart-define=TMDB_KEY=$TMDB_KEY
/// ```
///
/// Test Coverage Available:
/// - flows/authentication_flow_test.dart: 8 tests - Login, logout, registration, error handling
/// - flows/movie_browsing_flow_test.dart: 8 tests - Tab navigation, movie details, scrolling
/// - flows/search_flow_test.dart: 10 tests - Movie search, results, empty states
/// - flows/favorites_flow_test.dart: 10 tests - Add/remove favorites, persistence
/// - flows/settings_flow_test.dart: 10 tests - Theme toggle, language change, preferences
///
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Smoke test - App launches successfully',
      (WidgetTester tester) async {
    // Launch the app
    app.main();

    // Wait for app to initialize
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Verify app loaded - should show either login or home screen
    expect(find.text('Movie Discovery'), findsWidgets);

    print('✅ Integration test smoke test passed');
    print('📋 For comprehensive testing, run individual flow test files');
  });
}
