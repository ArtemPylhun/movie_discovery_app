# 🎬 Movie Discovery App — Implementation Plan

## 📂 Project Structure (Clean Architecture)

```
lib/
├── core/                   # Global utils, constants, error handling, DI
│   ├── errors/             # AppException, Failure classes
│   ├── network/            # Dio setup, interceptors
│   ├── usecases/           # BaseUseCase abstract class
│   ├── di/                 # get_it setup
│   └── config/             # env, themes, localization
│
├── features/
│   ├── auth/               # Login/Register flows
│   │   ├── data/           # Repositories, models, datasources
│   │   ├── domain/         # Entities, usecases, repositories contracts
│   │   └── presentation/   # Screens, state (BLoC/Riverpod)
│   │
│   ├── movies/             # Catalog, Search, Details
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── favorites/          # Watchlist management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── profile/            # User settings, theme, localization
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── shared/                 # Shared widgets, themes, animations
└── main.dart               # App entry point
```

---

## 🔑 Core Principles

### ✅ Clean Architecture
- **Domain layer**: Pure business logic (Entities + UseCases)
- **Data layer**: Handles API & Local storage (Repositories impl)
- **Presentation layer**: UI + State (BLoC or Riverpod)

### ✅ Dependency Injection
- Use `get_it` for DI
```dart
final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
}
```

### ✅ Repository Pattern
```dart
abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final MovieLocalDataSource local;

  MovieRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final movies = await remote.getPopularMovies();
      local.cacheMovies(movies);
      return movies;
    } catch (_) {
      return local.getCachedMovies();
    }
  }
}
```

---

## 🌐 API Integration (TMDB)

- **Client**: Dio with interceptors
- **Offline-first**: SQLite/Drift for caching, Hive for preferences
- **Retry mechanism**: DioRetryInterceptor
- **Logging**: PrettyDioLogger

```dart
final dio = Dio(BaseOptions(baseUrl: "https://api.themoviedb.org/3"))
  ..interceptors.add(PrettyDioLogger())
  ..interceptors.add(ApiKeyInterceptor());
```

---

## 📱 State Management

### Recommended: **Riverpod**
- Simpler, less boilerplate, testable
- Example:
```dart
final moviesProvider = FutureProvider((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getPopularMovies();
});
```

---

## 💾 Local Storage

- **SQLite/Drift** → movie cache
- **Hive** → favorites, settings
- **Secure Storage** → API keys, tokens

```dart
final box = await Hive.openBox('favorites');
box.put(movie.id, movie.toJson());
```

---

## 🔐 Authentication

- Firebase Auth (Google/Email)
- Securely store token with `flutter_secure_storage`
- Protected routes with `GoRouter` / `Navigator 2.0`

```dart
if (authState.isLoggedIn) {
  return HomeScreen();
} else {
  return LoginScreen();
}
```

---

## 🎨 Custom UI & Animations

- **Hero transitions** for movie posters
- **Shimmer loading** for skeletons
- **Custom MovieCard widget** with rating stars

```dart
class MovieCard extends StatelessWidget {
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: movie.id,
      child: Card(
        child: Column(
          children: [
            Image.network(movie.posterUrl),
            Text(movie.title),
            RatingBar(rating: movie.rating),
          ],
        ),
      ),
    );
  }
}
```

---

## 🚀 Performance

- Use `const` constructors
- Optimize list with `ListView.builder`
- Image caching via `cached_network_image`
- Debounce search queries

```dart
final debouncer = Debouncer(milliseconds: 500);
onChanged: (query) => debouncer.run(() => searchMovies(query));
```

---

## 🧪 Testing

- **Unit tests** → UseCases, Repositories
- **Widget tests** → MovieCard, MovieList
- **Integration tests** → Auth + Favorites flow

```dart
test('GetPopularMovies returns cached data if API fails', () async {
  final result = await repo.getPopularMovies();
  expect(result, isA<List<Movie>>());
});
```

Target: **70%+ coverage**

---

## 🔧 CI/CD (GitHub Actions)

```yaml
name: Flutter CI/CD
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze --fatal-infos
      - run: flutter test --coverage

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: flutter build apk --release
```

---

## 🔒 Security

- API Keys in `.env` (flutter_dotenv)
- Tokens in Secure Storage
- ProGuard & Obfuscation for release
```bash
flutter build apk --release --obfuscate --split-debug-info=build/debug
```

---

## 🏆 Bonus Features

- Dark/Light mode → via `ThemeMode.system`
- Multi-language → via `flutter_localizations`
- Offline sync → background sync with `workmanager`

---

## 📅 Timeline (6 weeks)

1. **Week 1**: Setup architecture + DI + Auth
2. **Week 2**: TMDB integration + Home UI
3. **Week 3**: State management + Search + Favorites
4. **Week 4**: Offline storage + Testing
5. **Week 5**: CI/CD + Security
6. **Week 6**: Documentation + Final polish

---

✅ With this plan you will cover: Clean Architecture, Riverpod/BLoC, API integration, local storage, authentication, performance, testing, CI/CD, security, custom UI, and bonus tasks.
