import 'package:movie_discovery_app/core/constants/api_constants.dart';
import 'package:movie_discovery_app/core/network/api_client.dart';
import 'package:movie_discovery_app/features/movies/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieListResponse> getPopularMovies(int page);
  Future<MovieListResponse> getTopRatedMovies(int page);
  Future<MovieListResponse> getUpcomingMovies(int page);
  Future<MovieListResponse> searchMovies(String query, int page);
  Future<MovieModel> getMovieDetails(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  MovieRemoteDataSourceImpl(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<MovieListResponse> getPopularMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.popularMovies,
      queryParameters: {ApiConstants.pageParam: page},
    );

    return MovieListResponse.fromJson(response.data!);
  }

  @override
  Future<MovieListResponse> getTopRatedMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.topRatedMovies,
      queryParameters: {ApiConstants.pageParam: page},
    );

    return MovieListResponse.fromJson(response.data!);
  }

  @override
  Future<MovieListResponse> getUpcomingMovies(int page) async {
    final response = await apiClient.get(
      ApiConstants.upcomingMovies,
      queryParameters: {ApiConstants.pageParam: page},
    );

    return MovieListResponse.fromJson(response.data!);
  }

  @override
  Future<MovieListResponse> searchMovies(String query, int page) async {
    final response = await apiClient.get(
      ApiConstants.searchMovies,
      queryParameters: {
        ApiConstants.queryParam: query,
        ApiConstants.pageParam: page,
      },
    );

    return MovieListResponse.fromJson(response.data!);
  }

  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    final response =
        await apiClient.get('${ApiConstants.movieDetails}/$movieId');

    return MovieModel.fromJson(response.data!);
  }
}
