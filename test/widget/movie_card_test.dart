import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/global_favorites_provider.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';

void main() {
  const testMovie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
    backdropPath: '/backdrop.jpg',
    voteAverage: 7.5,
    voteCount: 1000,
    releaseDate: '2023-01-01',
    genreIds: [28],
    popularity: 100.0,
    adult: false,
    originalLanguage: 'en',
    originalTitle: 'Test Movie',
  );

  Widget createTestWidget(Movie movie, {Set<int> favorites = const {}}) {
    return ProviderScope(
      overrides: [
        globalFavoritesNotifierProvider.overrideWith(
          (ref) => TestGlobalFavoritesNotifier(favorites),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            height: 300,
            child: MovieCard(movie: movie),
          ),
        ),
      ),
    );
  }

  group('MovieCard', () {
    testWidgets('should display movie title and release date', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(testMovie));

      // Assert
      expect(find.text('Test Movie'), findsOneWidget);
      expect(find.text('2023-01-01'), findsOneWidget);
    });

    testWidgets('should display rating with star icon', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(testMovie));

      // Assert
      expect(find.text('3.8'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should display favorite border icon when not favorite',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(testMovie));

      // Assert
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });

    testWidgets('should display filled favorite icon when is favorite',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(testMovie, favorites: {1}));

      // Assert
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
    });

    testWidgets('should display movie placeholder icon when no poster',
        (tester) async {
      // Arrange
      const movieWithoutPoster = Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: null,
        backdropPath: '/backdrop.jpg',
        voteAverage: 7.5,
        voteCount: 1000,
        releaseDate: '2023-01-01',
        genreIds: [28],
        popularity: 100.0,
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Test Movie',
      );

      // Act
      await tester.pumpWidget(createTestWidget(movieWithoutPoster));

      // Assert
      expect(find.byIcon(Icons.movie_outlined), findsOneWidget);
    });

    testWidgets('should handle long movie titles with ellipsis',
        (tester) async {
      // Arrange
      const movieWithLongTitle = Movie(
        id: 1,
        title:
            'This is a very long movie title that should be truncated with ellipsis',
        overview: 'Test Overview',
        posterPath: '/test.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 7.5,
        voteCount: 1000,
        releaseDate: '2023-01-01',
        genreIds: [28],
        popularity: 100.0,
        adult: false,
        originalLanguage: 'en',
        originalTitle:
            'This is a very long movie title that should be truncated with ellipsis',
      );

      // Act
      await tester.pumpWidget(createTestWidget(movieWithLongTitle));

      // Assert
      final titleWidget = find.text(
          'This is a very long movie title that should be truncated with ellipsis');
      expect(titleWidget, findsOneWidget);

      final Text titleText = tester.widget(titleWidget);
      expect(titleText.maxLines, 2);
      expect(titleText.overflow, TextOverflow.ellipsis);
    });

    testWidgets('should be tappable', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(testMovie));

      // Assert
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('should have Card elevation', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestWidget(testMovie));

      // Assert
      final Card card = tester.widget(find.byType(Card));
      expect(card.elevation, 4);
    });

    testWidgets('should display correct rating format with one decimal place',
        (tester) async {
      // Arrange
      const movieWithPreciseRating = Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: '/test.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 8.765,
        voteCount: 1000,
        releaseDate: '2023-01-01',
        genreIds: [28],
        popularity: 100.0,
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Test Movie',
      );

      // Act
      await tester.pumpWidget(createTestWidget(movieWithPreciseRating));

      // Assert
      expect(find.text('4.4'), findsOneWidget);
    });
  });
}

class TestGlobalFavoritesNotifier extends GlobalFavoritesNotifier {
  TestGlobalFavoritesNotifier(Set<int> initialFavorites)
      : super(
          _MockRef(),
          _MockToggleFavorite(),
          _MockCheckFavoriteStatus(),
        ) {
    state = initialFavorites;
  }

  @override
  Future<bool> toggleFavorite(int movieId) async {
    final newFavorites = Set<int>.from(state);
    bool isFavorite;
    if (newFavorites.contains(movieId)) {
      newFavorites.remove(movieId);
      isFavorite = false;
    } else {
      newFavorites.add(movieId);
      isFavorite = true;
    }
    state = newFavorites;
    return isFavorite;
  }

  @override
  void refreshFavoriteStatus(int movieId) {
    // No-op for testing
  }
}

// Mock classes implementing proper interfaces
class _MockRef implements Ref {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockToggleFavorite implements ToggleFavorite {
  @override
  Future<Either<Failure, bool>> call(params) async {
    return const Right(true);
  }

  @override
  MovieRepository get repository => throw UnimplementedError();
}

class _MockCheckFavoriteStatus implements CheckFavoriteStatus {
  @override
  Future<Either<Failure, bool>> call(params) async {
    return const Right(false);
  }

  @override
  MovieRepository get repository => throw UnimplementedError();
}
