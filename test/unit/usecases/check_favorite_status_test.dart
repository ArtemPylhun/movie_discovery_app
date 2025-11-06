import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';

@GenerateMocks([MovieRepository])
import 'check_favorite_status_test.mocks.dart';

void main() {
  late CheckFavoriteStatus useCase;
  late MockMovieRepository mockRepository;
  const testUserId = 'test-user-123';

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = CheckFavoriteStatus(mockRepository);

    // Provide default dummy for when not explicitly stubbed
    provideDummy<Either<Failure, bool>>(const Right(false));
  });

  const movieId = 550;
  const params =
      CheckFavoriteStatusParams(userId: testUserId, movieId: movieId);

  group('CheckFavoriteStatus', () {
    test('should return true when movie is in favorites', () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.fold((l) => null, (r) => r), isTrue);
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
    });

    test('should return false when movie is not in favorites', () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Right(false));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Right<Failure, bool>>());
      expect(result.fold((l) => null, (r) => r), isFalse);
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
    });

    test('should return CacheFailure when repository fails', () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Left(CacheFailure('Database error')));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
      expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
    });

    test('should pass correct movie ID to repository', () async {
      // Arrange
      const specificMovieId = 12345;
      const specificParams = CheckFavoriteStatusParams(
          userId: testUserId, movieId: specificMovieId);

      when(mockRepository.isFavorite(testUserId, specificMovieId))
          .thenAnswer((_) async => const Right(true));

      // Act
      await useCase(specificParams);

      // Assert
      verify(mockRepository.isFavorite(testUserId, specificMovieId)).called(1);
    });

    test('should handle different movie IDs independently', () async {
      // Arrange
      const movieId1 = 100;
      const movieId2 = 200;

      when(mockRepository.isFavorite(testUserId, movieId1))
          .thenAnswer((_) async => const Right(true));
      when(mockRepository.isFavorite(testUserId, movieId2))
          .thenAnswer((_) async => const Right(false));

      // Act
      final result1 = await useCase(const CheckFavoriteStatusParams(
          userId: testUserId, movieId: movieId1));
      final result2 = await useCase(const CheckFavoriteStatusParams(
          userId: testUserId, movieId: movieId2));

      // Assert
      expect(result1.fold((l) => null, (r) => r), isTrue);
      expect(result2.fold((l) => null, (r) => r), isFalse);
      verify(mockRepository.isFavorite(testUserId, movieId1)).called(1);
      verify(mockRepository.isFavorite(testUserId, movieId2)).called(1);
    });
  });
}
