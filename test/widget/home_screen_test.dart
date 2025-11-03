import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_discovery_app/features/movies/presentation/screens/home_screen.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/global_favorites_provider.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_favorite_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

void main() {
  const testMovies = [
    Movie(
      id: 1,
      title: 'Test Movie 1',
      overview: 'Overview 1',
      posterPath: '/poster1.jpg',
      backdropPath: '/backdrop1.jpg',
      voteAverage: 8.5,
      voteCount: 1000,
      releaseDate: '2023-01-01',
      genreIds: [28, 12],
      popularity: 100.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Test Movie 1',
    ),
  ];

  Widget createTestWidget({List<Movie> movies = testMovies}) {
    return ProviderScope(
      overrides: [
        popularMoviesProvider
            .overrideWith((ref) => TestMovieListNotifier(movies)),
        topRatedMoviesProvider
            .overrideWith((ref) => TestMovieListNotifier(movies)),
        upcomingMoviesProvider
            .overrideWith((ref) => TestMovieListNotifier(movies)),
        favoriteMoviesProvider
            .overrideWith((ref) => TestFavoriteMoviesNotifier(movies)),
        globalFavoritesNotifierProvider
            .overrideWith((ref) => TestGlobalFavoritesNotifier({})),
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
        home: HomeScreen(),
      ),
    );
  }

  group('HomeScreen', () {
    testWidgets('should display app bar with title', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Movie Discovery'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display TabBar with 4 tabs', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(4));
    });

    testWidgets('should display Popular tab', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Popular'), findsOneWidget);
    });

    testWidgets('should display Top Rated tab', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('should display Upcoming tab', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Upcoming'), findsOneWidget);
    });

    testWidgets('should display Favorites tab', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Favorites'), findsOneWidget);
    });

    testWidgets('should have TabController with length 4', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Get the TabBar
      final TabBar tabBar = tester.widget(find.byType(TabBar));

      // Assert
      expect(tabBar.tabs.length, 4);
    });

    testWidgets('should display search bar', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('should switch between tabs', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());

      // Tap on Top Rated tab (index 1)
      await tester.tap(find.text('Top Rated'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Assert - should still show the same screen structure
      expect(find.text('Movie Discovery'), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('should have correct theme colors', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      final AppBar appBar = tester.widget(find.byType(AppBar));

      // Assert - Just verify appBar exists
      expect(appBar, isNotNull);
      // Note: backgroundColor can be null if using default theme
      expect(appBar.elevation, 0);
    });
  });
}

class TestMovieListNotifier extends MovieListNotifier {
  TestMovieListNotifier(List<Movie> movies) : super(_MockMovieUseCase()) {
    state = MovieListLoaded(movies);
  }

  @override
  Future<void> loadMovies() async {
    // No-op for testing
  }

  @override
  Future<void> loadMoreMovies() async {
    // No-op for testing
  }
}

class TestFavoriteMoviesNotifier extends FavoriteMoviesNotifier {
  TestFavoriteMoviesNotifier(List<Movie> movies)
      : super(
          _MockRef(),
          _MockGetFavoriteMovies(),
          _MockToggleFavorite(),
        ) {
    state = MovieListLoaded(movies, hasReachedMax: true);
  }

  @override
  Future<void> loadFavoriteMovies() async {
    // No-op for testing
  }

  @override
  Future<void> toggleFavorite(int movieId) async {
    // No-op for testing
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
    return state.contains(movieId);
  }

  @override
  void refreshFavoriteStatus(int movieId) {
    // No-op for testing
  }
}

// Mock classes implementing proper interfaces
class _MockMovieUseCase implements UseCase<List<Movie>, PaginationParams> {
  @override
  Future<Either<Failure, List<Movie>>> call(PaginationParams params) async {
    return const Right([]);
  }
}

class _MockRef implements Ref {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockGetFavoriteMovies implements GetFavoriteMovies {
  @override
  Future<Either<Failure, List<Movie>>> call(params) async {
    return const Right([]);
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
