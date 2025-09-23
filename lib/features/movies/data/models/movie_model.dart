import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class Genre with _$Genre {
  const factory Genre({
    required int id,
    required String name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    required int id,
    required String title,
    required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    List<Genre>? genres,
    required double popularity,
    required bool adult,
    @JsonKey(name: 'original_language') required String originalLanguage,
    @JsonKey(name: 'original_title') required String originalTitle,
  }) = _MovieModel;

  const MovieModel._();

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  factory MovieModel.fromEntity(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      releaseDate: movie.releaseDate,
      genreIds: movie.genreIds.isNotEmpty ? movie.genreIds : null,
      popularity: movie.popularity,
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
    );
  }

  Movie toEntity() {
    // Use genres if available (movie details), otherwise genreIds (movie lists)
    final effectiveGenreIds = genres != null
        ? genres!.map((genre) => genre.id).toList()
        : genreIds ?? [];

    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      genreIds: effectiveGenreIds,
      popularity: popularity,
      adult: adult,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
    );
  }
}

@freezed
class MovieListResponse with _$MovieListResponse {
  const factory MovieListResponse({
    required int page,
    required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _MovieListResponse;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);
}