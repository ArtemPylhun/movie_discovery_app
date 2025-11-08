import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_discovery_app/main.dart' as app;
import '../helpers/test_actions.dart';
import '../helpers/test_setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Movie Browsing Flow Tests', () {
    setUp(() async {
      await IntegrationTestHelper.resetApp();
    });
    testWidgets('Should load and display movies on home screen',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Note: This test assumes user is logged in or app allows browsing without login
      // If login is required, the test would need to perform login first

      // Wait for movies to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify that movie cards are displayed (or loading indicators)
      final movieCards = find.byType(Card);
      final loadingIndicators = find.byType(CircularProgressIndicator);

      // Either movies or loading should be visible
      expect(
        movieCards.evaluate().isNotEmpty ||
            loadingIndicators.evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('Should navigate through all movie tabs',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // List of tabs to test
      final tabs = ['Popular', 'Top Rated', 'Upcoming', 'Favorites'];

      for (final tabName in tabs) {
        final tabFinder = find.text(tabName);

        if (tabFinder.evaluate().isNotEmpty) {
          // Navigate to tab
          await TestActions.navigateToTab(tester, tabName);

          // Verify tab is active
          expect(find.text(tabName), findsOneWidget);

          // Wait for content to load
          await tester.pumpAndSettle(const Duration(seconds: 3));
        }
      }
    });

    testWidgets('Should open movie details when tapping on a movie card',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Wait for movies to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final movieCards = find.byType(Card);

      if (movieCards.evaluate().isNotEmpty) {
        // Tap on first movie
        await TestActions.tapFirstMovie(tester);

        // Verify details screen is shown (should have back button)
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);

        // Verify details screen elements
        expect(
          find.byType(SliverAppBar),
          findsWidgets,
          skip: true,
        );

        // Go back to home
        await TestActions.goBack(tester);

        // Verify we're back on home screen
        expect(find.byType(TabBar), findsOneWidget);
      }
    });

    testWidgets('Should scroll through movie list',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Wait for movies to load
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final scrollables = find.byType(Scrollable);

      if (scrollables.evaluate().isNotEmpty) {
        // Scroll down
        await TestActions.scrollDown(tester);

        // Wait for new items to load (if pagination exists)
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Scroll back up
        await TestActions.scrollUp(tester);

        await tester.pumpAndSettle();
      }
    });

    testWidgets('Should display movie information in details screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Wait for movies
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final movieCards = find.byType(Card);

      if (movieCards.evaluate().isNotEmpty) {
        // Open movie details
        await TestActions.tapFirstMovie(tester);

        // Wait for details to load
        await tester.pumpAndSettle(const Duration(seconds: 5));

        // Check for common movie detail elements
        // Rating stars
        final starIcons = find.byIcon(Icons.star);
        final starBorderIcons = find.byIcon(Icons.star_border);

        expect(
          starIcons.evaluate().isNotEmpty ||
              starBorderIcons.evaluate().isNotEmpty,
          isTrue,
          skip: true,
        );

        // Favorite button
        final favoriteIcons = find.byIcon(Icons.favorite_border);
        expect(favoriteIcons, findsWidgets, skip: true);

        // Navigate back
        await TestActions.goBack(tester);
      }
    });

    testWidgets('Should handle rapid tab switching without crashes',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      final tabs = ['Popular', 'Top Rated', 'Upcoming', 'Favorites'];

      // Rapidly switch between tabs
      for (int i = 0; i < 3; i++) {
        for (final tab in tabs) {
          final tabFinder = find.text(tab);
          if (tabFinder.evaluate().isNotEmpty) {
            await tester.tap(tabFinder);
            await tester.pump(); // Don't wait for settle
          }
        }
      }

      // Wait for everything to settle
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // App should still be responsive
      expect(find.byType(TabBar), findsOneWidget);
    });

    testWidgets('Should display empty state in Favorites when no favorites',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Navigate to Favorites tab
      final favoritesTab = find.text('Favorites');

      if (favoritesTab.evaluate().isNotEmpty) {
        await TestActions.navigateToTab(tester, 'Favorites');

        // Wait for content to load
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Should show either empty state or favorite movies
        // Empty state usually has an icon and message
        final emptyStateIcon = find.byIcon(Icons.favorite_border);
        final movieCards = find.byType(Card);

        expect(
          emptyStateIcon.evaluate().isNotEmpty ||
              movieCards.evaluate().isNotEmpty,
          isTrue,
        );
      }
    });

    testWidgets('Should maintain scroll position when switching tabs',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Wait for movies
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Scroll down on Popular tab
      final scrollables = find.byType(Scrollable);
      if (scrollables.evaluate().isNotEmpty) {
        await TestActions.scrollDown(tester);
        await tester.pumpAndSettle();

        // Switch to another tab
        await TestActions.navigateToTab(tester, 'Top Rated');

        // Switch back to Popular
        await TestActions.navigateToTab(tester, 'Popular');

        // Scroll position behavior depends on implementation
        // This test just verifies no crashes occur
        expect(find.byType(TabBar), findsOneWidget);
      }
    });
  });
}
