import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_movie_details.dart';

@GenerateMocks([MovieRepository])
import 'get_movie_details_test.mocks.dart';

void main() {
  late GetMovieDetails useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetMovieDetails(mockRepository);

    // Provide default dummy for Mockito
    provideDummy<Either<Failure, Movie>>(
      const Right(Movie(
        id: 0,
        title: '',
        overview: '',
        posterPath: '',
        backdropPath: '',
        voteAverage: 0,
        voteCount: 0,
        releaseDate: '',
        genreIds: [],
        popularity: 0,
        adult: false,
        originalLanguage: '',
        originalTitle: '',
      )),
    );
  });

  const testMovie = Movie(
    id: 550,
    title: 'Fight Club',
    overview:
        'A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression...',
    posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
    backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
    voteAverage: 8.433,
    voteCount: 27000,
    releaseDate: '1999-10-15',
    genreIds: [18],
    popularity: 85.0,
    adult: false,
    originalLanguage: 'en',
    originalTitle: 'Fight Club',
  );

  const movieDetailsParams = GetMovieDetailsParams(movieId: 550);

  group('GetMovieDetails', () {
    test('should return movie details when successful', () async {
      // Arrange
      when(mockRepository.getMovieDetails(550))
          .thenAnswer((_) async => const Right(testMovie));

      // Act
      final result = await useCase(movieDetailsParams);

      // Assert
      expect(result, isA<Right<Failure, Movie>>());
      expect(result.fold((l) => null, (r) => r), equals(testMovie));
      verify(mockRepository.getMovieDetails(550)).called(1);
    });

    test('should return ServerFailure when server error occurs', () async {
      // Arrange
      when(mockRepository.getMovieDetails(550))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      // Act
      final result = await useCase(movieDetailsParams);

      // Assert
      expect(result, isA<Left<Failure, Movie>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(mockRepository.getMovieDetails(550)).called(1);
    });

    test('should return NetworkFailure when network error occurs', () async {
      // Arrange
      when(mockRepository.getMovieDetails(550))
          .thenAnswer((_) async => const Left(NetworkFailure('No internet')));

      // Act
      final result = await useCase(movieDetailsParams);

      // Assert
      expect(result, isA<Left<Failure, Movie>>());
      expect(result.fold((l) => l, (r) => null), isA<NetworkFailure>());
    });

    test('should pass correct movie ID to repository', () async {
      // Arrange
      const movieId = 12345;
      when(mockRepository.getMovieDetails(movieId))
          .thenAnswer((_) async => const Right(testMovie));

      // Act
      await useCase(const GetMovieDetailsParams(movieId: movieId));

      // Assert
      verify(mockRepository.getMovieDetails(movieId)).called(1);
    });

    test('should handle non-existent movie ID', () async {
      // Arrange
      const nonExistentMovieId = 999999;
      when(mockRepository.getMovieDetails(nonExistentMovieId)).thenAnswer(
          (_) async => const Left(ServerFailure('Movie not found')));

      // Act
      final result = await useCase(
          const GetMovieDetailsParams(movieId: nonExistentMovieId));

      // Assert
      expect(result, isA<Left<Failure, Movie>>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Movie not found'));
    });
  });
}
