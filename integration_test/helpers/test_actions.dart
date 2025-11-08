import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper class containing reusable test actions for integration tests
class TestActions {
  /// Performs login action with provided credentials
  static Future<void> login(
    WidgetTester tester, {
    required String email,
    required String password,
  }) async {
    // Find email and password fields by type
    final emailFields = find.byType(TextFormField);
    expect(emailFields, findsWidgets);

    // Assuming first field is email, second is password
    final emailField = emailFields.first;
    final passwordField = emailFields.at(1);

    // Enter credentials
    await tester.enterText(emailField, email);
    await tester.pumpAndSettle();

    await tester.enterText(passwordField, password);
    await tester.pumpAndSettle();

    // Find and tap login button
    final loginButton = find.widgetWithText(ElevatedButton, 'Sign In');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }

  /// Performs logout action
  static Future<void> logout(WidgetTester tester) async {
    // Open settings/menu
    final settingsIcon = find.byIcon(Icons.settings_rounded);
    expect(settingsIcon, findsOneWidget);

    await tester.tap(settingsIcon);
    await tester.pumpAndSettle();

    // Find and tap sign out button
    final signOutButton = find.text('Sign Out');
    expect(signOutButton, findsOneWidget);

    await tester.tap(signOutButton);
    await tester.pumpAndSettle();

    // Confirm logout if there's a confirmation dialog
    final confirmButtons = find.text('Sign Out');
    if (confirmButtons.evaluate().length > 1) {
      await tester.tap(confirmButtons.last);
      await tester.pumpAndSettle();
    }
  }

  /// Searches for a movie
  static Future<void> searchMovie(
    WidgetTester tester,
    String query,
  ) async {
    // Tap search icon
    final searchIcon = find.byIcon(Icons.search);
    expect(searchIcon, findsOneWidget);

    await tester.tap(searchIcon);
    await tester.pumpAndSettle();

    // Enter search query
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, query);
    await tester.pumpAndSettle();

    // Submit search
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }

  /// Navigates to a specific tab
  static Future<void> navigateToTab(
    WidgetTester tester,
    String tabName,
  ) async {
    final tabFinder = find.text(tabName);
    expect(tabFinder, findsOneWidget);

    await tester.tap(tabFinder);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  }

  /// Taps on the first movie card
  static Future<void> tapFirstMovie(WidgetTester tester) async {
    // Wait for movies to load
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final movieCards = find.byType(Card);
    expect(movieCards, findsWidgets);

    await tester.tap(movieCards.first);
    await tester.pumpAndSettle();
  }

  /// Toggles favorite on current movie
  static Future<void> toggleFavorite(WidgetTester tester) async {
    // Look for favorite or favorite_border icon
    final favoriteIcon = find.byIcon(Icons.favorite_border);
    final filledFavoriteIcon = find.byIcon(Icons.favorite);

    if (favoriteIcon.evaluate().isNotEmpty) {
      await tester.tap(favoriteIcon.first);
    } else if (filledFavoriteIcon.evaluate().isNotEmpty) {
      await tester.tap(filledFavoriteIcon.first);
    } else {
      throw Exception('No favorite button found');
    }

    await tester.pumpAndSettle();
  }

  /// Navigates back
  static Future<void> goBack(WidgetTester tester) async {
    final backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle();
  }

  /// Scrolls down on the current scrollable widget
  static Future<void> scrollDown(WidgetTester tester) async {
    final scrollable = find.byType(Scrollable).first;
    await tester.fling(scrollable, const Offset(0, -500), 1000);
    await tester.pumpAndSettle();
  }

  /// Scrolls up on the current scrollable widget
  static Future<void> scrollUp(WidgetTester tester) async {
    final scrollable = find.byType(Scrollable).first;
    await tester.fling(scrollable, const Offset(0, 500), 1000);
    await tester.pumpAndSettle();
  }

  /// Waits for a specific duration
  static Future<void> wait(
    WidgetTester tester,
    Duration duration,
  ) async {
    await tester.pumpAndSettle(duration);
  }
}
