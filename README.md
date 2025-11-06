# 🎬 Movie Discovery App

A professional Flutter mobile application for discovering movies and TV shows, built with Clean Architecture, Firebase Authentication, and offline-first capabilities.

## 🎯 Обрана тема

**Movie Discovery App** - Catalog of movies and TV shows with favorites, search, authentication, and offline support.

## 🏗️ Архітектура

### Clean Architecture (3 layers)

- **Domain Layer**: Entities, Repository interfaces, Use Cases
- **Data Layer**: Models, Data Sources (Remote & Local), Repository implementations
- **Presentation Layer**: Screens, Widgets, State Management (Riverpod)

### State Management

- **Riverpod** with StateNotifierProvider
- Global state for authentication and favorites
- Comprehensive error state handling

### Dependency Injection

- **GetIt** for service locator pattern
- 20+ registered dependencies (repositories, use cases, data sources)
- Lazy singleton instances for optimal memory management

### Repository Pattern

All data access goes through repositories:

- `MovieRepository` - Movie data operations
- `AuthRepository` - Authentication operations

## 🌐 API Integration

### APIs Used

- **TMDB API** (The Movie Database)
  - Popular, Top Rated, Upcoming movies
  - Movie search functionality
  - Movie details with cast and reviews

### Integration Features

- **HTTP Client**: Dio with custom interceptors
- **Retry Mechanism**: Automatic retry on network failures (3 attempts)
- **Logging**: Request/response logging for debugging
- **Error Handling**: Custom exceptions with user-friendly messages
- **Offline-First**: Cache-first strategy with automatic fallback

### Offline Strategy

1. **Primary**: Fetch from API and cache locally
2. **Fallback**: Return cached data on network failure
3. **Storage**: Drift (SQLite) database for persistent cache

## 🚀 Features

### Core Features

✅ **Authentication**

- Email/Password registration and login
- Google Sign-In OAuth integration
- Secure token storage with FlutterSecureStorage
- Automatic session persistence
- Protected routes with AuthGate

✅ **Movie Browsing**

- Browse Popular movies
- Browse Top Rated movies
- Browse Upcoming movies
- Infinite scroll pagination
- Pull-to-refresh

✅ **Search & Filters**

- Real-time movie search
- Search results pagination
- Debounced search input

✅ **Favorites/Watchlist**

- **User-specific favorites** with authentication
- Add/remove movies from favorites per user
- Persistent favorites storage in local database
- Favorites synced with user accounts
- Favorites tab with dedicated UI
- Favorite status indicators
- Multi-device favorites support (via authentication)

✅ **Movie Details**

- Detailed movie information
- Ratings and vote counts
- Release dates
- Movie overview/synopsis
- Backdrop and poster images
- **Movie trailers integration** with YouTube player
- Embedded trailer playback

✅ **Offline Support**

- Works without internet connection
- Cached movie data
- Cached user authentication
- Automatic sync when online

### Technical Features

✅ **Performance Optimizations**

- Lazy loading with pagination
- Image caching with CachedNetworkImage
- Shimmer loading animations
- Widget rebuild optimization
- Memory-efficient list rendering

✅ **UI/UX**

- Material Design 3
- **Professional theme system** with light and dark theme support
- Hero animations for smooth transitions
- Custom widgets (5 total)
- Responsive layouts
- Loading states and error handling
- Form validation
- Consistent color palette and typography

## 🧪 Testing

### Test Coverage

- **Unit Tests**: 50 tests
  - Use case tests (32 tests)
  - Repository tests (18 tests)
- **Widget Tests**: 25 tests
  - Custom widget tests
  - Screen tests
- **Integration Tests**: 5 test scenarios
  - Complete user flows
  - Navigation testing
  - Offline mode testing

### Coverage Statistics

```bash
flutter test --coverage
# Coverage report generated: coverage/lcov.info
```

**Current Test Count**: 85 passing tests

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/usecases/get_popular_movies_test.dart

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/app_test.dart
```

## 📱 Project Structure

```
movie_discovery_app/
├── lib/
│   ├── core/                          # Core utilities
│   │   ├── constants/                 # API constants, app constants
│   │   ├── di/                        # Dependency injection setup
│   │   ├── errors/                    # Custom exceptions & failures
│   │   ├── network/                   # HTTP client configuration
│   │   ├── storage/                   # Hive storage setup
│   │   └── usecases/                  # Base use case classes
│   ├── features/
│   │   ├── auth/                      # Authentication feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/       # Remote (Firebase) & Local
│   │   │   │   ├── models/            # UserModel
│   │   │   │   └── repositories/      # AuthRepositoryImpl
│   │   │   ├── domain/
│   │   │   │   ├── entities/          # User entity
│   │   │   │   ├── repositories/      # AuthRepository interface
│   │   │   │   └── usecases/          # 6 auth use cases
│   │   │   └── presentation/
│   │   │       ├── providers/         # Auth state & providers
│   │   │       └── screens/           # Login, Register screens
│   │   └── movies/                    # Movies feature
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   │   ├── local/         # Drift database
│   │       │   │   └── remote/        # TMDB API client
│   │       │   ├── models/            # MovieModel, VideoModel
│   │       │   └── repositories/      # MovieRepositoryImpl
│   │       ├── domain/
│   │       │   ├── entities/          # Movie, Video entities
│   │       │   ├── repositories/      # MovieRepository interface
│   │       │   └── usecases/          # 9 movie use cases (incl. GetMovieVideos)
│   │       └── presentation/
│   │           ├── providers/         # Movie state & providers
│   │           ├── screens/           # Home, Search, Details
│   │           └── widgets/           # 6 custom widgets (incl. MovieTrailerPlayer)
│   └── main.dart                      # App entry point
├── test/                              # Unit & Widget tests
│   ├── unit/
│   │   ├── repositories/
│   │   └── usecases/
│   └── widget/
├── integration_test/                  # E2E tests
├── .github/
│   └── workflows/
│       └── main.yml                   # CI/CD pipeline
├── coverage/                          # Test coverage reports
├── README.md
└── pubspec.yaml
```

## 🛠️ Setup Instructions

### Prerequisites

- Flutter SDK 3.5.0 or higher
- Dart SDK 3.5.0 or higher
- Firebase project (for authentication)
- TMDB API key

### Installation Steps

1. **Clone the repository**

```bash
git clone <repository-url>
cd movie_discovery_app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Set up TMDB API Key**

Get your API key from [TMDB](https://www.themoviedb.org/settings/api) and run:

```bash
# Development
flutter run --dart-define=TMDB_KEY=your_api_key_here

# Release build
flutter build apk --release --dart-define=TMDB_KEY=your_api_key_here
```

4. **Set up Firebase (for authentication)**

- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
- Add Android/iOS apps to your Firebase project
- Download `google-services.json` (Android) to `android/app/`
- Download `GoogleService-Info.plist` (iOS) to `ios/Runner/`
- Enable Email/Password and Google Sign-In in Firebase Authentication

5. **Run the app**

```bash
flutter run --dart-define=TMDB_KEY=your_api_key_here
```

### Build Commands

```bash
# Debug build
flutter build apk --debug --dart-define=TMDB_KEY=your_key

# Release build
flutter build apk --release --dart-define=TMDB_KEY=your_key

# Build with obfuscation
flutter build apk --release --obfuscate --split-debug-info=build/debug-info --dart-define=TMDB_KEY=your_key
```

## 🔧 CI/CD Pipeline

### GitHub Actions Workflow

Located at `.github/workflows/main.yml`

**Pipeline Jobs:**

1. **Analyze Job**

   - Runs `flutter analyze --fatal-infos`
   - Checks code quality and linting

2. **Test Job**

   - Runs all unit, widget, and integration tests
   - Generates code coverage report
   - Uploads coverage to Codecov

3. **Build Job**
   - Runs only if analyze and test pass
   - Builds release APK
   - Uploads APK as artifact

**Triggers:**

- Push to `main` or `develop` branches
- Pull requests

### Workflow Features

- ✅ Automated testing on every push
- ✅ Code coverage reporting
- ✅ APK build artifacts
- ✅ Environment variable management for API keys
- ✅ Parallel job execution

## 📊 Performance Optimizations

### Implemented Optimizations

1. **Image Caching**

   - CachedNetworkImage for all movie posters
   - Automatic disk caching
   - Memory cache optimization

2. **List Performance**

   - Lazy loading with pagination
   - ListView.builder for efficient rendering
   - GridView with cached extents

3. **State Management**

   - Selective widget rebuilds with Riverpod
   - StateNotifier for optimized state updates
   - Provider scoping to minimize rebuild scope

4. **Network Optimization**

   - Request debouncing for search
   - Response caching with Drift
   - Retry mechanism for failed requests

5. **Memory Management**
   - Lazy singleton pattern for services
   - Proper widget disposal
   - Image cache size limits

## 🔒 Security Measures

### Implemented Security Features

1. **API Key Management**

   - API keys passed via `--dart-define` (not in code)
   - Environment-based configuration
   - `.gitignore` includes sensitive files

2. **Secure Storage**

   - FlutterSecureStorage for auth tokens
   - Encrypted user credentials
   - Secure keychain/keystore usage

3. **Authentication**

   - Firebase Authentication security
   - Token-based session management
   - Automatic token refresh

4. **Code Protection**

   - Support for code obfuscation in release builds
   - Split debug info for crash reporting
   - ProGuard rules for Android

5. **Network Security**
   - HTTPS-only API calls
   - Certificate pinning ready
   - Secure headers in requests

## 🎨 Custom Widgets

1. **MovieCard** - Reusable movie card with image, title, rating
2. **MovieListSection** - Movie list with loading, error, empty states
3. **MovieSearchBar** - Custom search bar with navigation
4. **MovieLoadingGrid** - Shimmer loading animation grid
5. **FavoriteMoviesSection** - Dedicated favorites list component
6. **MovieTrailerPlayer** - YouTube trailer player with fallback UI

## 🏆 Bonus Features Implemented

- ✅ **Offline Sync Strategy**
  - Cache-first approach
  - Automatic sync when online
  - Persistent favorites
- ✅ **Movie Trailers Integration**
  - YouTube player integration
  - Auto-play trailers on movie details page
  - Fallback UI when no trailer available
- ✅ **User-Specific Favorites**
  - Favorites tied to user accounts
  - Multi-device support via authentication
  - Persistent across sessions
- ✅ **Professional Theme System**
  - Complete light theme implemented
  - Dark theme configuration ready
  - Consistent design tokens (colors, spacing, typography)
  - Material Design 3 compliance

**User-Specific Favorites:**

- ✅ Favorites are now **user-specific** and tied to authentication
- ✅ Each user has their own favorites list
- ✅ Favorites persist across devices when user logs in
- ✅ Local database stores favorites per user ID
- ✅ Offline-first architecture maintained

**Movie Trailers:**

- ✅ YouTube trailer integration implemented
- ✅ Trailers play directly in movie details screen
- ✅ Automatic trailer selection (official trailers prioritized)
- ✅ Graceful fallback when no trailer available

**Theme System:**

- ✅ Professional theme configuration implemented
- ✅ Light theme fully configured with Material Design 3
- ✅ Dark theme configuration ready
- ✅ Consistent design tokens (colors, spacing, typography)

### Planned Features

- [ ] **Dark/Light theme toggle** - Theme ready, just needs toggle UI
  - Add settings screen
  - Implement theme switcher
  - Persist theme preference
- [ ] **Multi-language support** (Ukrainian + English)
  - Implement i18n with intl package
  - Add language switcher
  - Translate all UI strings
- [ ] **Cloud sync for favorites** (optional enhancement)
  - Firestore integration for real-time sync
  - Conflict resolution for offline changes
- [ ] User reviews and ratings
- [ ] Watchlist with custom lists
- [ ] Push notifications for new releases
- [ ] Cast and crew information
- [ ] Similar movies recommendations

## 🤝 Contributing

This is an educational project for Flutter development coursework.

## 📄 License

This project is created for educational purposes as part of a Flutter development course.

## 👨‍💻 Developer

Created as part of Flutter Individual Project coursework.

---

## 📚 Dependencies

### Main Dependencies

- `flutter_riverpod` - State management
- `dio` - HTTP client
- `drift` - SQLite database
- `firebase_auth` - Authentication
- `google_sign_in` - Google OAuth
- `flutter_secure_storage` - Secure storage
- `cached_network_image` - Image caching
- `get_it` - Dependency injection
- `either_dart` - Functional error handling
- `youtube_player_flutter` - YouTube video player for trailers
- `freezed` - Code generation for immutable classes
- `equatable` - Value equality for entities

### Dev Dependencies

- `flutter_test` - Testing framework
- `mockito` - Mocking for tests
- `integration_test` - E2E testing
- `build_runner` - Code generation
- `flutter_lints` - Linting rules

## 🎓 Learning Outcomes

This project demonstrates:

- Clean Architecture implementation in Flutter
- Professional state management with Riverpod
- Comprehensive testing strategy
- CI/CD pipeline setup with GitHub Actions
- Firebase integration
- Offline-first mobile development
- REST API integration
- Security best practices
