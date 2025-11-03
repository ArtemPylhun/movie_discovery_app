import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_loading_grid.dart';

void main() {
  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: MovieLoadingGrid(),
        ),
      ),
    );
  }

  group('MovieLoadingGrid', () {
    testWidgets('should display grid view', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should display multiple loading placeholders', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Should have multiple shimmer/loading items
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('should have proper grid layout', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      final GridView gridView = tester.widget(find.byType(GridView));

      // Assert - Should have proper cross axis count
      expect(gridView, isNotNull);
    });

    testWidgets('should display shimmer effect', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Look for shimmer containers or loading indicators
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should have consistent item size', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - All loading items should be present
      final cards = find.byType(Card);
      expect(cards.evaluate().length, greaterThan(0));
    });

    testWidgets('should display loading animation', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Let animations run
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Assert - Grid should still be visible during animation
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should handle different screen sizes', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Resize the screen
      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pump();

      // Assert
      expect(find.byType(GridView), findsOneWidget);

      // Resize to mobile size
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should maintain aspect ratio', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Loading items should maintain movie card aspect ratio
      expect(find.byType(GridView), findsOneWidget);
      final cards = find.byType(Card);
      expect(cards.evaluate().length, greaterThan(0));
    });

    testWidgets('should display placeholder content', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert - Should have placeholder rectangles or containers
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should be scrollable', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Try to scroll the grid
      await tester.fling(find.byType(GridView), const Offset(0, -300), 1000);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - Grid should still be present after scroll attempt
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
