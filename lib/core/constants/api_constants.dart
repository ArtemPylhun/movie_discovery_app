class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Get API key from compile-time environment variable
  static const String apiKey = String.fromEnvironment(
    'TMDB_KEY',
    defaultValue: '',
  );

  static void validateApiKey() {
    if (apiKey.isEmpty) {
      throw Exception(
        'TMDB_KEY not provided. Use: flutter run --dart-define=TMDB_KEY=your_key',
      );
    }
  }

  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';
  static const String searchMovies = '/search/movie';
  static const String movieDetails = '/movie';
  static const String movieCredits = '/movie/{id}/credits';

  // Movie Videos - format: /movie/{movie_id}/videos
  static String movieVideos(int movieId) => '/movie/$movieId/videos';

  // Parameters
  static const String apiKeyParam = 'api_key';
  static const String pageParam = 'page';
  static const String queryParam = 'query';
  static const String languageParam = 'language';
  static const String defaultLanguage = 'en-US';
}
