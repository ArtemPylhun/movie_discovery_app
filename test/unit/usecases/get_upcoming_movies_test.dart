import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_upcoming_movies.dart';

@GenerateMocks([MovieRepository])
import 'get_upcoming_movies_test.mocks.dart';

void main() {
  late GetUpcomingMovies useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetUpcomingMovies(mockRepository);

    // Provide default dummy for Mockito
    provideDummy<Either<Failure, List<Movie>>>(const Right([]));
  });

  final testMovies = [
    const Movie(
      id: 1,
      title: 'Upcoming Movie 1',
      overview: 'First upcoming movie',
      posterPath: '/upcoming1.jpg',
      backdropPath: '/backdrop1.jpg',
      voteAverage: 8.2,
      voteCount: 2500,
      releaseDate: '2025-06-15',
      genreIds: [28, 878],
      popularity: 120.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Upcoming Movie 1',
    ),
  ];

  group('GetUpcomingMovies', () {
    test('should return list of upcoming movies when successful', () async {
      // Arrange
      when(mockRepository.getUpcomingMovies(1))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), equals(testMovies));
      verify(mockRepository.getUpcomingMovies(1)).called(1);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepository.getUpcomingMovies(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(mockRepository.getUpcomingMovies(1)).called(1);
    });

    test('should pass correct page parameter', () async {
      // Arrange
      when(mockRepository.getUpcomingMovies(3))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      await useCase(const PaginationParams(page: 3));

      // Assert
      verify(mockRepository.getUpcomingMovies(3)).called(1);
    });
  });
}
