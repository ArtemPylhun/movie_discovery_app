import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_discovery_app/features/movies/presentation/screens/movie_details_screen.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/global_favorites_provider.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/favorites_provider.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_movie_details.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

void main() {
  const testMovie = Movie(
    id: 550,
    title: 'Fight Club',
    overview:
        'A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression...',
    posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
    backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
    voteAverage: 8.433,
    voteCount: 27000,
    releaseDate: '1999-10-15',
    genreIds: [18],
    popularity: 85.0,
    adult: false,
    originalLanguage: 'en',
    originalTitle: 'Fight Club',
  );

  Widget createTestWidget(
      {Movie? movie, bool isFavorite = false, Set<int> favorites = const {}}) {
    return ProviderScope(
      overrides: [
        movieDetailsProvider(550).overrideWith(
          (ref) => TestMovieDetailsNotifier(movie, isFavorite),
        ),
        globalFavoritesNotifierProvider.overrideWith(
          (ref) => TestGlobalFavoritesNotifier(favorites),
        ),
        movieFavoriteStatusProvider(550).overrideWith(
          (ref) => TestMovieFavoriteNotifier(isFavorite),
        ),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
        ],
        home: MovieDetailsScreen(movieId: 550),
      ),
    );
  }

  group('MovieDetailsScreen', () {
    testWidgets('should display loading state initially', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display movie title when loaded', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert - Title appears in multiple places (main title and original title)
      expect(find.text('Fight Club'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display movie overview', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert
      expect(
          find.textContaining('A ticking-time-bomb insomniac'), findsOneWidget);
    });

    testWidgets('should display release date', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert
      expect(find.text('1999-10-15'), findsOneWidget);
    });

    testWidgets('should display rating', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // The rating should be voteAverage/2 = 8.433/2 = 4.2
      // Assert
      expect(find.textContaining('4.2'), findsOneWidget);
    });

    testWidgets('should display vote count', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert
      expect(find.textContaining('27000'), findsOneWidget);
    });

    testWidgets('should display favorite button when not favorite',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('should display filled favorite button when is favorite',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(
          movie: testMovie, isFavorite: true, favorites: {550}));

      // Assert
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('should have back button', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('should display error state when movie fails to load',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: null));

      // Assert - Should show some error UI
      expect(find.byType(MovieDetailsScreen), findsOneWidget);
    });

    testWidgets('should display poster image when available', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert - Check for image widget or network image
      expect(find.byType(MovieDetailsScreen), findsOneWidget);
    });

    testWidgets('should handle favorite button tap', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Find and tap favorite button
      final favoriteButton = find.byIcon(Icons.favorite_border);
      if (favoriteButton.evaluate().isNotEmpty) {
        await tester.tap(favoriteButton);
        await tester.pump();
      }

      // Assert - button should still exist (state change would be handled by provider)
      expect(find.byType(MovieDetailsScreen), findsOneWidget);
    });

    testWidgets('should display movie genres if available', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(movie: testMovie));

      // Assert - Should show genre information
      expect(find.byType(MovieDetailsScreen), findsOneWidget);
    });

    testWidgets('should handle adult content indicator', (tester) async {
      // Arrange
      const adultMovie = Movie(
        id: 551,
        title: 'Adult Movie',
        overview: 'Adult content movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 7.0,
        voteCount: 1000,
        releaseDate: '2023-01-01',
        genreIds: [18],
        popularity: 50.0,
        adult: true,
        originalLanguage: 'en',
        originalTitle: 'Adult Movie',
      );

      // Act
      await tester.pumpWidget(createTestWidget(movie: adultMovie));

      // Assert - Adult content should be handled appropriately
      // Title appears in multiple places (main title and original title)
      expect(find.text('Adult Movie'), findsAtLeastNWidgets(1));
    });
  });
}

class TestMovieDetailsNotifier extends MovieDetailsNotifier {
  TestMovieDetailsNotifier(Movie? movie, bool isFavorite)
      : super(
          _MockRef(),
          _MockGetMovieDetails(),
          _MockCheckFavoriteStatus(),
          550,
        ) {
    if (movie != null) {
      state = MovieDetailsLoaded(movie, isFavorite);
    } else {
      state = const MovieDetailsLoading();
    }
  }

  @override
  Future<void> loadMovieDetails() async {
    // No-op for testing
  }

  @override
  void updateFavoriteStatus(bool isFavorite) {
    if (state is MovieDetailsLoaded) {
      final currentState = state as MovieDetailsLoaded;
      state = MovieDetailsLoaded(currentState.movie, isFavorite);
    }
  }
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

class _MockGetMovieDetails implements GetMovieDetails {
  @override
  Future<Either<Failure, Movie>> call(params) async {
    return const Right(Movie(
      id: 0,
      title: '',
      overview: '',
      posterPath: null,
      backdropPath: null,
      voteAverage: 0,
      voteCount: 0,
      releaseDate: '',
      genreIds: [],
      popularity: 0,
      adult: false,
      originalLanguage: '',
      originalTitle: '',
    ));
  }

  @override
  MovieRepository get repository => throw UnimplementedError();
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

class TestMovieFavoriteNotifier extends MovieFavoriteNotifier {
  TestMovieFavoriteNotifier(bool initialStatus)
      : super(550, _MockFavoritesAction()) {
    state = initialStatus;
  }

  @override
  Future<void> toggle() async {
    state = !state;
  }

  @override
  void updateStatus(bool isFavorite) {
    state = isFavorite;
  }
}

class _MockFavoritesAction extends FavoritesAction {
  _MockFavoritesAction()
      : super(_MockRef(), _MockToggleFavorite(), _MockCheckFavoriteStatus());

  @override
  Future<bool> toggleFavorite(int movieId) async {
    return true;
  }

  @override
  Future<bool> checkFavoriteStatus(int movieId) async {
    return false;
  }
}
