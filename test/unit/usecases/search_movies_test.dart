import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/search_movies.dart';

@GenerateMocks([MovieRepository])
import 'search_movies_test.mocks.dart';

void main() {
  late SearchMovies useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = SearchMovies(mockRepository);

    // Provide default dummy for Mockito
    provideDummy<Either<Failure, List<Movie>>>(const Right([]));
  });

  final testMovies = [
    const Movie(
      id: 1,
      title: 'Search Result Movie',
      overview: 'Found by search',
      posterPath: '/search.jpg',
      backdropPath: '/backdrop.jpg',
      voteAverage: 7.5,
      voteCount: 1500,
      releaseDate: '2023-01-01',
      genreIds: [28],
      popularity: 90.0,
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Search Result Movie',
    ),
  ];

  const searchParams = SearchParams(query: 'Avengers', page: 1);

  group('SearchMovies', () {
    test('should return search results when successful', () async {
      // Arrange
      when(mockRepository.searchMovies('Avengers', 1))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      final result = await useCase(searchParams);

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), equals(testMovies));
      verify(mockRepository.searchMovies('Avengers', 1)).called(1);
    });

    test('should return empty list when no results found', () async {
      // Arrange
      when(mockRepository.searchMovies('NonexistentMovie', 1))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result =
          await useCase(const SearchParams(query: 'NonexistentMovie', page: 1));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), isEmpty);
    });

    test('should return ServerFailure when server error occurs', () async {
      // Arrange
      when(mockRepository.searchMovies('Avengers', 1))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      // Act
      final result = await useCase(searchParams);

      // Assert
      expect(result, isA<Left<Failure, List<Movie>>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
    });

    test('should handle special characters in search query', () async {
      // Arrange
      const specialQuery = 'Spider-Man: No Way Home';
      when(mockRepository.searchMovies(specialQuery, 1))
          .thenAnswer((_) async => Right(testMovies));

      // Act
      await useCase(const SearchParams(query: specialQuery, page: 1));

      // Assert
      verify(mockRepository.searchMovies(specialQuery, 1)).called(1);
    });

    test('should handle empty search query', () async {
      // Arrange
      when(mockRepository.searchMovies('', 1))
          .thenAnswer((_) async => const Right([]));

      // Act
      final result = await useCase(const SearchParams(query: '', page: 1));

      // Assert
      expect(result, isA<Right<Failure, List<Movie>>>());
      expect(result.fold((l) => null, (r) => r), isEmpty);
    });
  });
}
