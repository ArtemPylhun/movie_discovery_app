import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_movie_details.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/search_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_favorite_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';

// Use Case Providers
final getPopularMoviesProvider = Provider<GetPopularMovies>(
  (ref) => getIt<GetPopularMovies>(),
);

final getTopRatedMoviesProvider = Provider<GetTopRatedMovies>(
  (ref) => getIt<GetTopRatedMovies>(),
);

final getUpcomingMoviesProvider = Provider<GetUpcomingMovies>(
  (ref) => getIt<GetUpcomingMovies>(),
);

final getMovieDetailsProvider = Provider<GetMovieDetails>(
  (ref) => getIt<GetMovieDetails>(),
);

final searchMoviesProvider = Provider<SearchMovies>(
  (ref) => getIt<SearchMovies>(),
);

final getFavoriteMoviesProvider = Provider<GetFavoriteMovies>(
  (ref) => getIt<GetFavoriteMovies>(),
);

final toggleFavoriteProvider = Provider<ToggleFavorite>(
  (ref) => getIt<ToggleFavorite>(),
);

final checkFavoriteStatusProvider = Provider<CheckFavoriteStatus>(
  (ref) => getIt<CheckFavoriteStatus>(),
);

// State Providers
final popularMoviesProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>(
  (ref) => MovieListNotifier(ref.read(getPopularMoviesProvider)),
);

final topRatedMoviesProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>(
  (ref) => MovieListNotifier(ref.read(getTopRatedMoviesProvider)),
);

final upcomingMoviesProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>(
  (ref) => MovieListNotifier(ref.read(getUpcomingMoviesProvider)),
);

final movieDetailsProvider =
    StateNotifierProvider.family<MovieDetailsNotifier, MovieDetailsState, int>(
  (ref, movieId) => MovieDetailsNotifier(
    ref.read(getMovieDetailsProvider),
    ref.read(checkFavoriteStatusProvider),
    movieId,
  ),
);

final searchMoviesStateProvider =
    StateNotifierProvider<SearchMoviesNotifier, SearchMoviesState>(
  (ref) => SearchMoviesNotifier(ref.read(searchMoviesProvider)),
);

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, MovieListState>(
  (ref) => FavoriteMoviesNotifier(
    ref.read(getFavoriteMoviesProvider),
    ref.read(toggleFavoriteProvider),
  ),
);

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Current Page Providers (unused - can be removed if not needed)
// final popularMoviesPageProvider = StateProvider<int>((ref) => 1);
// final topRatedMoviesPageProvider = StateProvider<int>((ref) => 1);
// final upcomingMoviesPageProvider = StateProvider<int>((ref) => 1);
// final searchMoviesPageProvider = StateProvider<int>((ref) => 1);
