import 'package:flutter_test/flutter_test.dart';
import 'package:movie_discovery_app/features/movies/data/models/movie_model.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';

void main() {
  const testMovieModel = MovieModel(
    id: 550,
    title: 'Fight Club',
    overview: 'A ticking-time-bomb insomniac and a slippery soap salesman...',
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

  final testMovieJson = {
    'id': 550,
    'title': 'Fight Club',
    'overview': 'A ticking-time-bomb insomniac and a slippery soap salesman...',
    'poster_path': '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
    'backdrop_path': '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
    'vote_average': 8.433,
    'vote_count': 27000,
    'release_date': '1999-10-15',
    'genre_ids': [18],
    'popularity': 85.0,
    'adult': false,
    'original_language': 'en',
    'original_title': 'Fight Club',
  };

  group('MovieModel', () {
    test('should create MovieModel from JSON correctly', () {
      // Act
      final result = MovieModel.fromJson(testMovieJson);

      // Assert
      expect(result.id, 550);
      expect(result.title, 'Fight Club');
      expect(result.posterPath, '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg');
      expect(result.voteAverage, 8.433);
      expect(result.genreIds, [18]);
    });

    test('should convert MovieModel to JSON correctly', () {
      // Act
      final result = testMovieModel.toJson();

      // Assert
      expect(result['id'], 550);
      expect(result['title'], 'Fight Club');
      expect(result['poster_path'], '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg');
      expect(result['vote_average'], 8.433);
      expect(result['genre_ids'], [18]);
    });

    test('should convert to Movie entity correctly', () {
      // Act
      final result = testMovieModel.toEntity();

      // Assert
      expect(result, isA<Movie>());
      expect(result.id, testMovieModel.id);
      expect(result.title, testMovieModel.title);
      expect(result.genreIds, testMovieModel.genreIds);
      expect(result.voteAverage, testMovieModel.voteAverage);
    });

    test('should create MovieModel from Movie entity correctly', () {
      // Arrange
      const movieEntity = Movie(
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

      // Act
      final result = MovieModel.fromEntity(movieEntity);

      // Assert
      expect(result.id, movieEntity.id);
      expect(result.title, movieEntity.title);
      expect(result.genreIds, movieEntity.genreIds);
    });

    test('should handle null posterPath correctly', () {
      // Arrange
      final jsonWithNullPoster = Map<String, dynamic>.from(testMovieJson);
      jsonWithNullPoster['poster_path'] = null;

      // Act
      final result = MovieModel.fromJson(jsonWithNullPoster);

      // Assert
      expect(result.posterPath, isNull);
    });

    test('should handle genres when converting to entity', () {
      // Arrange
      final movieWithGenres = testMovieModel.copyWith(
        genres: const [
          Genre(id: 18, name: 'Drama'),
          Genre(id: 53, name: 'Thriller'),
        ],
        genreIds: null,
      );

      // Act
      final result = movieWithGenres.toEntity();

      // Assert
      expect(result.genreIds, [18, 53]);
    });

    test('should use genreIds when genres is null', () {
      // Arrange
      final movieWithGenreIds = testMovieModel.copyWith(
        genres: null,
        genreIds: const [28, 12],
      );

      // Act
      final result = movieWithGenreIds.toEntity();

      // Assert
      expect(result.genreIds, [28, 12]);
    });

    test('should handle empty genreIds list', () {
      // Arrange
      const movieEntity = Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: '/test.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 7.5,
        voteCount: 1000,
        releaseDate: '2023-01-01',
        genreIds: [],
        popularity: 100.0,
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Test Movie',
      );

      // Act
      final result = MovieModel.fromEntity(movieEntity);

      // Assert
      expect(result.genreIds, isNull);
    });
  });

  group('Genre', () {
    test('should create Genre from JSON correctly', () {
      // Arrange
      final genreJson = {'id': 18, 'name': 'Drama'};

      // Act
      final result = Genre.fromJson(genreJson);

      // Assert
      expect(result.id, 18);
      expect(result.name, 'Drama');
    });

    test('should convert Genre to JSON correctly', () {
      // Arrange
      const genre = Genre(id: 28, name: 'Action');

      // Act
      final result = genre.toJson();

      // Assert
      expect(result['id'], 28);
      expect(result['name'], 'Action');
    });
  });

  group('MovieListResponse', () {
    test('should create MovieListResponse from JSON correctly', () {
      // Arrange
      final responseJson = {
        'page': 1,
        'results': [testMovieJson],
        'total_pages': 500,
        'total_results': 10000,
      };

      // Act
      final result = MovieListResponse.fromJson(responseJson);

      // Assert
      expect(result.page, 1);
      expect(result.results, hasLength(1));
      expect(result.totalPages, 500);
      expect(result.totalResults, 10000);
      expect(result.results.first.id, 550);
    });

    test('should convert MovieListResponse to JSON correctly', () {
      // Arrange
      const response = MovieListResponse(
        page: 1,
        results: [testMovieModel],
        totalPages: 500,
        totalResults: 10000,
      );

      // Act
      final result = response.toJson();

      // Assert
      expect(result['page'], 1);
      expect(result['results'], isList);
      expect(result['total_pages'], 500);
      expect(result['total_results'], 10000);
    });
  });
}
