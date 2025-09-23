# 🎬 Movie Discovery App - Implementation Plan

## 📊 Scoring Strategy (100 points)

| Component | Points | What You Need |
|-----------|--------|--------------|
| Architecture | 25 | Clean Architecture + GetIt DI + Repository Pattern |
| API Integration | 20 | Dio + Offline cache + Error handling |
| State Management | 15 | Riverpod with proper error states |
| Testing | 15 | 70%+ coverage (Unit + Widget + Integration) |
| CI/CD | 10 | GitHub Actions with full pipeline |
| UI/UX | 10 | 2 custom widgets + animations |
| Code Quality | 5 | Linting + Documentation |
| **Bonus** | +10 | Dark theme (+3) + i18n (+3) + Offline sync (+4) |

## 🚀 Week 1: Foundation (25 points)

### Project Structure
```
lib/
├── core/
│   ├── constants/          # API keys, URLs
│   ├── errors/             # Exceptions, Failures
│   ├── network/            # Dio setup
│   ├── usecases/           # BaseUseCase
│   └── di/                 # GetIt injection
├── features/
│   ├── movies/
│   │   ├── data/
│   │   │   ├── datasources/  # Remote & Local
│   │   │   ├── models/       # MovieModel
│   │   │   └── repositories/ # MovieRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/     # Movie entity
│   │   │   ├── repositories/ # MovieRepository abstract
│   │   │   └── usecases/     # GetPopularMovies, etc
│   │   └── presentation/
│   │       ├── providers/    # Riverpod providers
│   │       ├── pages/        # Screens
│   │       └── widgets/      # MovieCard, etc
│   ├── auth/               # Same structure
│   └── favorites/          # Same structure
└── main.dart
```

### Key Files to Create

**1. Dependency Injection (core/di/injection.dart)**
```dart
final getIt = GetIt.instance;

void setupDI() {
  // Core
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiClient(getIt()));

  // Data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(getIt())
  );
  getIt.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl()
  );

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt(), getIt())
  );

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));
}
```

**2. Repository Pattern (data/repositories/movie_repository_impl.dart)**
```dart
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final MovieLocalDataSource local;

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page) async {
    try {
      final movies = await remote.getPopularMovies(page);
      await local.cacheMovies(movies);
      return Right(movies);
    } catch (e) {
      final cached = await local.getCachedMovies();
      return cached.isNotEmpty ? Right(cached) : Left(ServerFailure());
    }
  }
}
```

## 🌐 Week 2: API & Storage (20 points)

### TMDB Integration
```dart
class ApiClient {
  final Dio dio;
  static const apiKey = String.fromEnvironment('TMDB_KEY');

  ApiClient(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': apiKey},
    );
    dio.interceptors.addAll([
      LogInterceptor(),
      RetryInterceptor(retries: 3),
    ]);
  }
}
```

### Drift Database Setup
```dart
@DriftDatabase(tables: [Movies, Favorites])
class AppDatabase extends _$AppDatabase {
  @override
  int get schemaVersion => 1;

  Future<List<Movie>> getCachedMovies() => select(movies).get();
  Future<void> cacheMovies(List<MovieModel> items) =>
    batch((b) => b.insertAll(movies, items));
}
```

## 🎯 Week 3: Features & State (15 points)

### Riverpod Providers
```dart
// Popular Movies
final popularMoviesProvider = AsyncNotifierProvider<
  PopularMoviesNotifier, List<Movie>
>(() => PopularMoviesNotifier());

class PopularMoviesNotifier extends AsyncNotifier<List<Movie>> {
  int _page = 1;

  @override
  Future<List<Movie>> build() => _fetchMovies();

  Future<List<Movie>> _fetchMovies() async {
    final useCase = ref.read(getPopularMoviesProvider);
    final result = await useCase(_page);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (movies) => movies,
    );
  }

  Future<void> loadMore() async {
    _page++;
    final newMovies = await _fetchMovies();
    state = AsyncData([...state.value ?? [], ...newMovies]);
  }
}

// Search
final searchProvider = StateNotifierProvider<SearchNotifier, String>(
  (ref) => SearchNotifier()
);

// Favorites
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<int>>(
  (ref) => FavoritesNotifier()
);
```

### Core Screens
1. **HomeScreen** - Popular, Top Rated, Upcoming tabs
2. **SearchScreen** - With filters (genre, year, rating)
3. **MovieDetailScreen** - Info, trailers, cast
4. **FavoritesScreen** - Saved movies

## 🎨 Week 4: UI Components (10 points)

### Custom Widget 1: MovieCard
```dart
class MovieCard extends StatelessWidget {
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'movie-${movie.id}',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(...)],
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: movie.posterUrl,
              placeholder: (_, __) => Shimmer.fromColors(...),
            ),
            Text(movie.title),
            RatingStars(rating: movie.rating), // Custom Widget 2
          ],
        ),
      ),
    );
  }
}
```

### Custom Widget 2: RatingStars
```dart
class RatingStars extends StatelessWidget {
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating / 2 ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }
}
```

## 🧪 Week 5: Testing (15 points)

### Test Structure
```
test/
├── unit/
│   ├── usecases/        # 10 tests
│   ├── repositories/    # 10 tests
│   └── models/          # 5 tests
├── widget/
│   ├── movie_card_test.dart    # 5 tests
│   ├── rating_stars_test.dart  # 3 tests
│   └── screens/                # 10 tests
└── integration/
    ├── auth_flow_test.dart
    ├── search_flow_test.dart
    └── favorites_flow_test.dart
```

### Example Tests
```dart
// Unit Test
test('GetPopularMovies returns list of movies', () async {
  when(mockRepo.getPopularMovies(1))
    .thenAnswer((_) async => Right(moviesList));

  final result = await useCase(1);

  expect(result, Right(moviesList));
});

// Widget Test
testWidgets('MovieCard shows title and rating', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: MovieCard(movie: testMovie))
  );

  expect(find.text(testMovie.title), findsOneWidget);
  expect(find.byType(RatingStars), findsOneWidget);
});

// Integration Test
testWidgets('Complete favorites flow', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  await tester.tap(find.byIcon(Icons.favorite_border));
  await tester.pumpAndSettle();

  expect(find.byIcon(Icons.favorite), findsOneWidget);
});
```

## 🚀 Week 6: CI/CD & Production (10 points)

### GitHub Actions (.github/workflows/main.yml)
```yaml
name: Flutter CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze --fatal-infos

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info

  build:
    needs: [analyze, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: |
          echo "TMDB_KEY=${{ secrets.TMDB_KEY }}" >> .env
          flutter build apk --release --dart-define-from-file=.env
      - uses: actions/upload-artifact@v3
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

### Security Setup
```dart
// Never commit API keys
// .env (add to .gitignore)
TMDB_KEY=your_api_key_here

// Use in code
const apiKey = String.fromEnvironment('TMDB_KEY');

// For release build
flutter build apk --dart-define=TMDB_KEY=your_key
```

## ✅ Checklist for 100 Points

### Architecture (25)
- [ ] Clean Architecture layers
- [ ] GetIt dependency injection
- [ ] Repository pattern
- [ ] 5+ use cases

### API (20)
- [ ] Dio with interceptors
- [ ] Offline caching with Drift
- [ ] Error handling
- [ ] Retry mechanism

### State (15)
- [ ] Riverpod providers
- [ ] Error states
- [ ] Loading states
- [ ] Global state (auth, favorites)

### Testing (15)
- [ ] 70%+ code coverage
- [ ] Unit tests (25+)
- [ ] Widget tests (15+)
- [ ] Integration tests (3+)

### CI/CD (10)
- [ ] GitHub Actions workflow
- [ ] Automated testing
- [ ] Build artifacts
- [ ] Coverage reports

### UI/UX (10)
- [ ] MovieCard custom widget
- [ ] RatingStars custom widget
- [ ] Hero animations
- [ ] Shimmer loading

### Code Quality (5)
- [ ] Linting rules
- [ ] Complete README
- [ ] Code comments
- [ ] Git commit standards

### Bonus (+10)
- [ ] Dark/Light theme (+3)
- [ ] Ukrainian + English (+3)
- [ ] Offline sync with workmanager (+4)

## 📱 Quick Start Commands

```bash
# Create project
flutter create movie_discovery_app --org com.yourname

# Add dependencies
flutter pub add dio riverpod flutter_riverpod cached_network_image
flutter pub add drift sqlite3_flutter_libs get_it either dartz
flutter pub add flutter_secure_storage hive shimmer go_router

# Dev dependencies
flutter pub add -d build_runner drift_dev freezed_annotation
flutter pub add -d mockito flutter_test integration_test

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests with coverage
flutter test --coverage

# Build APK
flutter build apk --release
```

## 🎯 Daily Goals

**Week 1:** 3-4 hours/day on architecture
**Week 2:** 3-4 hours/day on API integration
**Week 3:** 4-5 hours/day on features
**Week 4:** 2-3 hours/day on UI
**Week 5:** 3-4 hours/day on testing
**Week 6:** 2-3 hours/day on CI/CD + polish

Total: ~120 hours for 100/100 points