import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/exceptions.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/local/movie_local_data_source.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie_discovery_app/features/movies/data/models/movie_model.dart';
import 'package:movie_discovery_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';

@GenerateMocks([MovieRemoteDataSource, MovieLocalDataSource])
import 'movie_repository_test.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  const testUserId = 'test-user-123';

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const testMovieModel = MovieModel(
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

  const testMovieListResponse = MovieListResponse(
    page: 1,
    results: [testMovieModel],
    totalPages: 10,
    totalResults: 100,
  );

  group('getPopularMovies', () {
    test('should return remote data when remote call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getPopularMovies(1))
          .thenAnswer((_) async => testMovieListResponse);
      when(mockLocalDataSource.cacheMovies(any)).thenAnswer((_) async => {});

      // Act
      final result = await repository.getPopularMovies(1);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), hasLength(1));
      verify(mockRemoteDataSource.getPopularMovies(1));
      verify(mockLocalDataSource.cacheMovies(any));
    });

    test('should cache remote data when remote call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getPopularMovies(1))
          .thenAnswer((_) async => testMovieListResponse);
      when(mockLocalDataSource.cacheMovies(any)).thenAnswer((_) async => {});

      // Act
      await repository.getPopularMovies(1);

      // Assert
      verify(mockLocalDataSource.cacheMovies(testMovieListResponse.results));
    });

    test(
        'should return cached data when remote call fails with ServerException',
        () async {
      // Arrange
      when(mockRemoteDataSource.getPopularMovies(1))
          .thenThrow(const ServerException('Server error'));
      when(mockLocalDataSource.getCachedMovies())
          .thenAnswer((_) async => [testMovieModel]);

      // Act
      final result = await repository.getPopularMovies(1);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      verify(mockLocalDataSource.getCachedMovies());
    });

    test('should return ServerFailure when remote fails and no cached data',
        () async {
      // Arrange
      when(mockRemoteDataSource.getPopularMovies(1))
          .thenThrow(const ServerException('Server error'));
      when(mockLocalDataSource.getCachedMovies()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getPopularMovies(1);

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
    });

    test('should return NetworkFailure when NetworkException is thrown',
        () async {
      // Arrange
      when(mockRemoteDataSource.getPopularMovies(1))
          .thenThrow(const NetworkException('Network error'));
      when(mockLocalDataSource.getCachedMovies()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getPopularMovies(1);

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<NetworkFailure>());
    });
  });

  group('getTopRatedMovies', () {
    test('should return remote data when call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getTopRatedMovies(1))
          .thenAnswer((_) async => testMovieListResponse);
      when(mockLocalDataSource.cacheMovies(any)).thenAnswer((_) async => {});

      // Act
      final result = await repository.getTopRatedMovies(1);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      verify(mockRemoteDataSource.getTopRatedMovies(1));
      verify(mockLocalDataSource.cacheMovies(any));
    });

    test('should return ServerFailure when ServerException is thrown',
        () async {
      // Arrange
      when(mockRemoteDataSource.getTopRatedMovies(1))
          .thenThrow(const ServerException('Server error'));

      // Act
      final result = await repository.getTopRatedMovies(1);

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
    });
  });

  group('getUpcomingMovies', () {
    test('should return remote data when call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getUpcomingMovies(1))
          .thenAnswer((_) async => testMovieListResponse);
      when(mockLocalDataSource.cacheMovies(any)).thenAnswer((_) async => {});

      // Act
      final result = await repository.getUpcomingMovies(1);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      verify(mockRemoteDataSource.getUpcomingMovies(1));
    });
  });

  group('searchMovies', () {
    test('should return search results when call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.searchMovies('query', 1))
          .thenAnswer((_) async => testMovieListResponse);
      when(mockLocalDataSource.cacheMovies(any)).thenAnswer((_) async => {});

      // Act
      final result = await repository.searchMovies('query', 1);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      verify(mockRemoteDataSource.searchMovies('query', 1));
    });
  });

  group('getMovieDetails', () {
    test('should return movie details when call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getMovieDetails(1))
          .thenAnswer((_) async => testMovieModel);
      when(mockLocalDataSource.cacheMovie(any)).thenAnswer((_) async => {});

      // Act
      final result = await repository.getMovieDetails(1);

      // Assert
      expect(result, isA<Right<Failure, Movie>>());
      verify(mockRemoteDataSource.getMovieDetails(1));
      verify(mockLocalDataSource.cacheMovie(testMovieModel));
    });
  });

  group('getFavoriteMovies', () {
    test('should return favorite movies when favorites exist', () async {
      // Arrange
      when(mockLocalDataSource.getFavoriteMovieIds(testUserId))
          .thenAnswer((_) async => [1, 2]);
      when(mockLocalDataSource.getCachedMoviesByIds([1, 2]))
          .thenAnswer((_) async => [testMovieModel]);

      // Act
      final result = await repository.getFavoriteMovies(testUserId);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      verify(mockLocalDataSource.getFavoriteMovieIds(testUserId));
      verify(mockLocalDataSource.getCachedMoviesByIds([1, 2]));
    });

    test('should return empty list when no favorites exist', () async {
      // Arrange
      when(mockLocalDataSource.getFavoriteMovieIds(testUserId))
          .thenAnswer((_) async => []);

      // Act
      final result = await repository.getFavoriteMovies(testUserId);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), isEmpty);
      verifyNever(mockLocalDataSource.getCachedMoviesByIds(any));
    });
  });

  group('addToFavorites', () {
    test('should complete successfully when call succeeds', () async {
      // Arrange
      when(mockLocalDataSource.addToFavorites(testUserId, 1))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.addToFavorites(testUserId, 1);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(mockLocalDataSource.addToFavorites(testUserId, 1));
    });

    test('should return CacheFailure when exception is thrown', () async {
      // Arrange
      when(mockLocalDataSource.addToFavorites(testUserId, 1))
          .thenThrow(Exception('Database error'));

      // Act
      final result = await repository.addToFavorites(testUserId, 1);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
    });
  });

  group('removeFromFavorites', () {
    test('should complete successfully when call succeeds', () async {
      // Arrange
      when(mockLocalDataSource.removeFromFavorites(testUserId, 1))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.removeFromFavorites(testUserId, 1);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(mockLocalDataSource.removeFromFavorites(testUserId, 1));
    });
  });

  group('isFavorite', () {
    test('should return true when movie is favorite', () async {
      // Arrange
      when(mockLocalDataSource.isFavorite(testUserId, 1))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.isFavorite(testUserId, 1);

      // Assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.fold((l) => null, (r) => r), isTrue);
      verify(mockLocalDataSource.isFavorite(testUserId, 1));
    });

    test('should return false when movie is not favorite', () async {
      // Arrange
      when(mockLocalDataSource.isFavorite(testUserId, 1))
          .thenAnswer((_) async => false);

      // Act
      final result = await repository.isFavorite(testUserId, 1);

      // Assert
      expect(result.fold((l) => null, (r) => r), isFalse);
    });
  });
}
