import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/features/movies/presentation/screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Note: Integration tests require platform channels (Firebase, Hive, etc.)
  // and should be run on a real device or emulator using:
  // flutter test integration_test/app_test.dart
  // or
  // flutter drive --target=test/integration/app_flow_test.dart

  Widget createTestApp() {
    return ProviderScope(
      child: MaterialApp(
        title: 'Movie Discovery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        home: const HomeScreen(),
      ),
    );
  }

  group('Movie Discovery App Integration Tests', () {
    test('Integration tests should be run on device/emulator', () {
      // This is a placeholder. Real integration tests are in integration_test/
      // and should be run with flutter drive or on a real device
      expect(true, true);
    });
  }, skip: true);

  group('Skipped Integration Tests - Run on device', () {
    testWidgets('Complete movie browsing flow', (tester) async {
      // Launch the app
      final app = createTestApp();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Test 1: Verify app launches successfully
      expect(find.text('Movie Discovery'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      // Test 2: Verify tabs are present
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.text('Upcoming'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);

      // Test 3: Navigate through different tabs
      await tester.tap(find.text('Top Rated'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Upcoming'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      // Go back to Popular tab
      await tester.tap(find.text('Popular'));
      await tester.pumpAndSettle();

      // Test 4: Wait for movies to load and verify movie cards are displayed
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Look for movie cards or any movie-related widgets
      final movieCards = find.byType(Card);
      if (movieCards.evaluate().isNotEmpty) {
        // Test 5: Tap on first movie to navigate to details
        await tester.tap(movieCards.first);
        await tester.pumpAndSettle();

        // Verify we navigated to movie details
        // (Details screen should have back button)
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);

        // Test 6: Go back to home
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Verify we're back on home screen
        expect(find.text('Movie Discovery'), findsOneWidget);
      }
    });

    testWidgets('Search functionality flow', (tester) async {
      // Skipped - run on device
    }, skip: true);

    testWidgets('Search functionality flow - device', (tester) async {
      // Launch the app
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Test 1: Navigate to search (if search is accessible from home)
      // This assumes there's a search button or search functionality
      final searchIcon = find.byIcon(Icons.search);
      if (searchIcon.evaluate().isNotEmpty) {
        await tester.tap(searchIcon);
        await tester.pumpAndSettle();

        // Test 2: Enter search query
        final searchField = find.byType(TextField);
        if (searchField.evaluate().isNotEmpty) {
          await tester.enterText(searchField, 'Avengers');
          await tester.testTextInput.receiveAction(TextInputAction.search);
          await tester.pumpAndSettle();

          // Wait for search results
          await tester.pumpAndSettle(const Duration(seconds: 3));

          // Test 3: Verify search interface is working
          expect(find.text('Avengers'), findsOneWidget);
        }
      }
    });

    testWidgets('Favorites functionality flow', (tester) async {
      // Skipped - run on device
    }, skip: true);

    testWidgets('Favorites functionality flow - device', (tester) async {
      // Launch the app
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Wait for movies to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Test 1: Find a movie card with favorite button
      final favoriteButtons = find.byIcon(Icons.favorite_border);
      if (favoriteButtons.evaluate().isNotEmpty) {
        // Test 2: Add movie to favorites
        await tester.tap(favoriteButtons.first);
        await tester.pumpAndSettle();

        // Test 3: Navigate to Favorites tab
        await tester.tap(find.text('Favorites'));
        await tester.pumpAndSettle();

        // Wait for favorites to load
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Test 4: Verify favorite movie appears in favorites tab
        // (This would depend on the actual implementation)
        expect(find.text('Favorites'), findsOneWidget);

        // Test 5: Go back to Popular to remove from favorites
        await tester.tap(find.text('Popular'));
        await tester.pumpAndSettle();

        // Find filled favorite button and tap to remove
        final filledFavoriteButtons = find.byIcon(Icons.favorite);
        if (filledFavoriteButtons.evaluate().isNotEmpty) {
          await tester.tap(filledFavoriteButtons.first);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Error handling and network scenarios', (tester) async {
      // Skipped - run on device
    }, skip: true);

    testWidgets('Error handling and network scenarios - device',
        (tester) async {
      // Launch the app
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Test 1: Verify app doesn't crash on startup
      expect(find.byType(MaterialApp), findsOneWidget);

      // Test 2: Handle potential network errors gracefully
      // Wait longer to see if any error states appear
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // App should still be functional
      expect(find.text('Movie Discovery'), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);

      // Test 3: Navigate through all tabs to ensure no crashes
      final tabs = ['Popular', 'Top Rated', 'Upcoming', 'Favorites'];
      for (final tab in tabs) {
        final tabFinder = find.text(tab);
        if (tabFinder.evaluate().isNotEmpty) {
          await tester.tap(tabFinder);
          await tester.pumpAndSettle();

          // Verify tab navigation worked
          expect(find.text('Movie Discovery'), findsOneWidget);
        }
      }
    });

    testWidgets('Performance and responsiveness test', (tester) async {
      // Skipped - run on device
    }, skip: true);

    testWidgets('Performance and responsiveness test - device', (tester) async {
      // Launch the app
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Test 1: Rapid tab switching
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Top Rated'));
        await tester.pump();
        await tester.tap(find.text('Popular'));
        await tester.pump();
        await tester.tap(find.text('Upcoming'));
        await tester.pump();
        await tester.tap(find.text('Favorites'));
        await tester.pump();
      }

      await tester.pumpAndSettle();

      // Test 2: Verify app is still responsive
      expect(find.text('Movie Discovery'), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);

      // Test 3: Scroll performance (if scrollable content exists)
      final scrollableWidgets = find.byType(Scrollable);
      if (scrollableWidgets.evaluate().isNotEmpty) {
        await tester.fling(
            scrollableWidgets.first, const Offset(0, -500), 1000);
        await tester.pumpAndSettle();
        await tester.fling(scrollableWidgets.first, const Offset(0, 500), 1000);
        await tester.pumpAndSettle();
      }
    });
  }, skip: true); // Skip integration tests - should be run on device/emulator
}
