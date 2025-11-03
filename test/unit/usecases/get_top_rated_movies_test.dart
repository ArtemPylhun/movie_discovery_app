import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_top_rated_movies.dart';

@GenerateMocks([MovieRepository])
import 'get_top_rated_movies_test.mocks.dart';

void main() {
  late GetTopRatedMovies useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetTopRatedMovies(mockRepository);

    // Provide default dummy for Mockito
    provideDummy<Either<Failure, List<Movie>>>(const Right([]));
  });

  final testMovies = [
    const Movie(
      id: 1,
      title: 'Top Rated Movie',
      overview: 'Highly rated movie',
      posterPath: '/poster.jpg',
      backdropPath: '/backdrop.jpg',
      voteAverage: 9.2,
      voteCount: 5000,
      releaseDate: '2023-01-01',
      genreIds: [18],
      popularity: 150.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Top Rated Movie',
    ),
  ];

  group('GetTopRatedMovies', () {
    test('should return list of top rated movies when successful', () async {
      // Arrange
      when(mockRepository.getTopRatedMovies(1))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), equals(testMovies));
      verify(mockRepository.getTopRatedMovies(1)).called(1);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepository.getTopRatedMovies(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      // Act
      final result = await useCase(const PaginationParams(page: 1));

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      verify(mockRepository.getTopRatedMovies(1)).called(1);
    });

    test('should pass correct page parameter', () async {
      // Arrange
      when(mockRepository.getTopRatedMovies(5))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      await useCase(const PaginationParams(page: 5));

      // Assert
      verify(mockRepository.getTopRatedMovies(5)).called(1);
    });
  });
}
