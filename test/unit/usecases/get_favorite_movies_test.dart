import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_favorite_movies.dart';

@GenerateMocks([MovieRepository])
import 'get_favorite_movies_test.mocks.dart';

void main() {
  late GetFavoriteMovies useCase;
  late MockMovieRepository mockRepository;
  const testUserId = 'test-user-123';

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetFavoriteMovies(mockRepository);

    // Provide default dummy for when not explicitly stubbed
    provideDummy<Either<Failure, List<Movie>>>(const Right([]));
  });

  final testFavoriteMovies = [
    const Movie(
      id: 1,
      title: 'Favorite Movie 1',
      overview: 'First favorite movie',
      posterPath: '/favorite1.jpg',
      backdropPath: '/backdrop1.jpg',
      voteAverage: 9.0,
      voteCount: 10000,
      releaseDate: '2020-01-01',
      genreIds: [28, 12],
      popularity: 200.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Favorite Movie 1',
    ),
    const Movie(
      id: 2,
      title: 'Favorite Movie 2',
      overview: 'Second favorite movie',
      posterPath: '/favorite2.jpg',
      backdropPath: '/backdrop2.jpg',
      voteAverage: 8.5,
      voteCount: 8000,
      releaseDate: '2021-05-15',
      genreIds: [18, 35],
      popularity: 150.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Favorite Movie 2',
    ),
  ];

  group('GetFavoriteMovies', () {
    test('should return list of favorite movies when successful', () async {
      // Arrange
      when(mockRepository.getFavoriteMovies(testUserId))
          .thenAnswer((_) async => Right(testFavoriteMovies));

      // Act
      final result =
          await useCase(const GetFavoriteMoviesParams(userId: testUserId));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), equals(testFavoriteMovies));
      verify(mockRepository.getFavoriteMovies(testUserId)).called(1);
    });

    test('should return empty list when no favorite movies exist', () async {
      // Arrange
      when(mockRepository.getFavoriteMovies(testUserId))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result =
          await useCase(const GetFavoriteMoviesParams(userId: testUserId));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), isEmpty);
      verify(mockRepository.getFavoriteMovies(testUserId)).called(1);
    });

    test('should return CacheFailure when repository fails', () async {
      // Arrange
      when(mockRepository.getFavoriteMovies(testUserId))
          .thenAnswer((_) async => const Left(CacheFailure('Database error')));

      // Act
      final result =
          await useCase(const GetFavoriteMoviesParams(userId: testUserId));

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
      verify(mockRepository.getFavoriteMovies(testUserId)).called(1);
    });

    test('should handle repository error correctly', () async {
      // Arrange
      const errorMessage = 'Failed to load favorites';
      when(mockRepository.getFavoriteMovies(testUserId))
          .thenAnswer((_) async => const Left(CacheFailure(errorMessage)));

      // Act
      final result =
          await useCase(const GetFavoriteMoviesParams(userId: testUserId));

      // Assert
      expect(result.fold((l) => l.message, (r) => null), equals(errorMessage));
    });
  });
}
