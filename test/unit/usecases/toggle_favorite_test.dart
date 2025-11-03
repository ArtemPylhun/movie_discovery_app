import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:either_dart/either.dart';
import 'package:movie_discovery_app/core/errors/failures.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';

@GenerateMocks([MovieRepository])
import 'toggle_favorite_test.mocks.dart';

void main() {
  late ToggleFavorite useCase;
  late MockMovieRepository mockRepository;
  const testUserId = 'test-user-123';

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = ToggleFavorite(mockRepository);

    // Provide default dummies for when not explicitly stubbed
    provideDummy<Either<Failure, bool>>(const Right(false));
    provideDummy<Either<Failure, void>>(const Right(null));
  });

  const movieId = 550;
  const params = ToggleFavoriteParams(userId: testUserId, movieId: movieId);

  group('ToggleFavorite', () {
    test('should add movie to favorites when movie is not in favorites',
        () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Right(false));
      when(mockRepository.addToFavorites(testUserId, movieId))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
      verify(mockRepository.addToFavorites(testUserId, movieId)).called(1);
      verifyNever(mockRepository.removeFromFavorites(testUserId, movieId));
    });

    test('should remove movie from favorites when movie is in favorites',
        () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Right(true));
      when(mockRepository.removeFromFavorites(testUserId, movieId))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Right<Failure, void>>());
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
      verify(mockRepository.removeFromFavorites(testUserId, movieId)).called(1);
      verifyNever(mockRepository.addToFavorites(testUserId, movieId));
    });

    test('should return failure when checking favorite status fails', () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Left(CacheFailure('Database error')));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
      verifyNever(mockRepository.addToFavorites(testUserId, movieId));
      verifyNever(mockRepository.removeFromFavorites(testUserId, movieId));
    });

    test('should return failure when adding to favorites fails', () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Right(false));
      when(mockRepository.addToFavorites(testUserId, movieId))
          .thenAnswer((_) async => const Left(CacheFailure('Add failed')));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      expect(result.fold((l) => l.message, (r) => null), equals('Add failed'));
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
      verify(mockRepository.addToFavorites(testUserId, movieId)).called(1);
    });

    test('should return failure when removing from favorites fails', () async {
      // Arrange
      when(mockRepository.isFavorite(testUserId, movieId))
          .thenAnswer((_) async => const Right(true));
      when(mockRepository.removeFromFavorites(testUserId, movieId))
          .thenAnswer((_) async => const Left(CacheFailure('Remove failed')));

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      expect(
          result.fold((l) => l.message, (r) => null), equals('Remove failed'));
      verify(mockRepository.isFavorite(testUserId, movieId)).called(1);
      verify(mockRepository.removeFromFavorites(testUserId, movieId)).called(1);
    });

    test('should handle different movie IDs correctly', () async {
      // Arrange
      const differentMovieId = 12345;
      const differentParams =
          ToggleFavoriteParams(userId: testUserId, movieId: differentMovieId);

      when(mockRepository.isFavorite(testUserId, differentMovieId))
          .thenAnswer((_) async => const Right(false));
      when(mockRepository.addToFavorites(testUserId, differentMovieId))
          .thenAnswer((_) async => const Right(null));

      // Act
      await useCase(differentParams);

      // Assert
      verify(mockRepository.isFavorite(testUserId, differentMovieId)).called(1);
      verify(mockRepository.addToFavorites(testUserId, differentMovieId))
          .called(1);
    });
  });
}
