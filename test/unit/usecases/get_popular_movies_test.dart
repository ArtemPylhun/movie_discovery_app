import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_popular_movies.dart';

@GenerateMocks([MovieRepository])
import 'get_popular_movies_test.mocks.dart';

void main() {
  late GetPopularMovies useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetPopularMovies(mockRepository);

    // Provide default dummy for Mockito
    provideDummy<Either<Failure, List<Movie>>>(const Right([]));
  });

  final testMovies = [
    const Movie(
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
    const Movie(
      id: 2,
      title: 'Test Movie 2',
      overview: 'Overview 2',
      posterPath: '/poster2.jpg',
      backdropPath: '/backdrop2.jpg',
      voteAverage: 7.2,
      voteCount: 500,
      releaseDate: '2023-02-01',
      genreIds: [35, 18],
      popularity: 80.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Test Movie 2',
    ),
  ];

  group('GetPopularMovies', () {
    test('should return list of movies when repository call is successful',
        () async {
      // Arrange
      when(mockRepository.getPopularMovies(1))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), equals(testMovies));
      verify(mockRepository.getPopularMovies(1)).called(1);
    });

    test('should return ServerFailure when repository throws ServerException',
        () async {
      // Arrange
      when(mockRepository.getPopularMovies(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(mockRepository.getPopularMovies(1)).called(1);
    });

    test('should return NetworkFailure when repository throws NetworkException',
        () async {
      // Arrange
      when(mockRepository.getPopularMovies(1)).thenAnswer(
          (_) async => const Left(NetworkFailure('No internet connection')));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<NetworkFailure>());
      verify(mockRepository.getPopularMovies(1)).called(1);
    });

    test('should pass correct page parameter to repository', () async {
      // Arrange
      when(mockRepository.getPopularMovies(2))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      await useCase(const PaginationParams(page: 2));

      // Assert
      verify(mockRepository.getPopularMovies(2)).called(1);
    });

    test('should return empty list when repository returns empty list',
        () async {
      // Arrange
      when(mockRepository.getPopularMovies(1))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), isEmpty);
    });
  });
}
