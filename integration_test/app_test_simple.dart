import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_discovery_app/main.dart' as app;

/// Simplified integration test runner
///
/// Run with: flutter test integration_test/app_test_simple.dart --dart-define=TMDB_KEY=your_key
///
/// NOTE: Integration tests that call app.main() multiple times can have issues.
/// For comprehensive testing, run individual flow test files separately:
///
/// flutter test integration_test/flows/authentication_flow_test.dart --dart-define=TMDB_KEY=your_key
/// flutter test integration_test/flows/movie_browsing_flow_test.dart --dart-define=TMDB_KEY=your_key
/// etc.
///
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App launches and displays UI', (WidgetTester tester) async {
    // Launch the app once
    app.main();

    // Wait for app to initialize
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Basic smoke test - verify app loaded
    // The app should show either login screen or home screen
    expect(find.text('Movie Discovery'), findsWidgets);

    print('✅ App launched successfully');
  });
}
