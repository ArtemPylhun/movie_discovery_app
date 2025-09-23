class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String apiKey = String.fromEnvironment('TMDB_KEY');

  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';
  static const String searchMovies = '/search/movie';
  static const String movieDetails = '/movie';
  static const String movieVideos = '/movie/{id}/videos';
  static const String movieCredits = '/movie/{id}/credits';

  // Parameters
  static const String apiKeyParam = 'api_key';
  static const String pageParam = 'page';
  static const String queryParam = 'query';
  static const String languageParam = 'language';
  static const String defaultLanguage = 'en-US';
}