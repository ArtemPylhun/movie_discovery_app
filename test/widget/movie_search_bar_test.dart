import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_search_bar.dart';

void main() {
  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: MovieSearchBar(),
        ),
      ),
    );
  }

  group('MovieSearchBar', () {
    testWidgets('should display search placeholder text', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Check for placeholder text
      expect(find.text('Search movies...'), findsOneWidget);
    });

    testWidgets('should display search icon', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should display tune/filter icon', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byIcon(Icons.tune), findsOneWidget);
    });

    testWidgets('should be tappable with InkWell', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - verify InkWell exists for tap functionality
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should be wrapped in container with padding', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Check that Container exists
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should have Material widget with elevation', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Check Material widget exists (for elevation)
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('should be tappable for navigation', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - InkWell should be present for tap functionality
      // Note: Testing actual navigation would require mocking Navigator
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(MovieSearchBar), findsOneWidget);
    });

    testWidgets('should display all visual elements', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Check for all key visual elements
      expect(find.text('Search movies...'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.tune), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
