import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/usecases/base_usecase.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_movie_details.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/search_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_favorite_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';

// Movie List State
abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListInitial extends MovieListState {
  const MovieListInitial();
}

class MovieListLoading extends MovieListState {
  const MovieListLoading();
}

class MovieListLoadingMore extends MovieListState {
  const MovieListLoadingMore(this.movies);

  final List<Movie> movies;

  @override
  List<Object?> get props => [movies];
}

class MovieListLoaded extends MovieListState {
  const MovieListLoaded(this.movies, {this.hasReachedMax = false});

  final List<Movie> movies;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [movies, hasReachedMax];
}

class MovieListError extends MovieListState {
  const MovieListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// Movie Details State
abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {
  const MovieDetailsInitial();
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
}

class MovieDetailsLoaded extends MovieDetailsState {
  const MovieDetailsLoaded(this.movie, this.isFavorite);

  final Movie movie;
  final bool isFavorite;

  @override
  List<Object?> get props => [movie, isFavorite];
}

class MovieDetailsError extends MovieDetailsState {
  const MovieDetailsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// Search Movies State
abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object?> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {
  const SearchMoviesInitial();
}

class SearchMoviesLoading extends SearchMoviesState {
  const SearchMoviesLoading();
}

class SearchMoviesLoadingMore extends SearchMoviesState {
  const SearchMoviesLoadingMore(this.movies, this.query);

  final List<Movie> movies;
  final String query;

  @override
  List<Object?> get props => [movies, query];
}

class SearchMoviesLoaded extends SearchMoviesState {
  const SearchMoviesLoaded(this.movies, this.query, {this.hasReachedMax = false});

  final List<Movie> movies;
  final String query;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [movies, query, hasReachedMax];
}

class SearchMoviesError extends SearchMoviesState {
  const SearchMoviesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// Movie List Notifier
class MovieListNotifier extends StateNotifier<MovieListState> {
  MovieListNotifier(this._useCase) : super(const MovieListInitial());

  final UseCase<List<Movie>, PaginationParams> _useCase; // Can be GetPopularMovies, GetTopRatedMovies, or GetUpcomingMovies
  int _currentPage = 1;
  List<Movie> _allMovies = [];

  Future<void> loadMovies() async {
    if (state is MovieListLoading) return;

    state = const MovieListLoading();
    _currentPage = 1;
    _allMovies = [];

    final result = await _useCase.call(PaginationParams(page: _currentPage));

    result.fold(
      (failure) => state = MovieListError(failure.message),
      (movies) {
        _allMovies = movies;
        state = MovieListLoaded(movies, hasReachedMax: movies.length < 20);
      },
    );
  }

  Future<void> loadMoreMovies() async {
    if (state is MovieListLoading || state is MovieListLoadingMore) return;
    if (state is MovieListLoaded && (state as MovieListLoaded).hasReachedMax) return;

    if (state is MovieListLoaded) {
      state = MovieListLoadingMore(_allMovies);
      _currentPage++;

      final result = await _useCase.call(PaginationParams(page: _currentPage));

      result.fold(
        (failure) => state = MovieListLoaded(_allMovies),
        (newMovies) {
          _allMovies.addAll(newMovies);
          state = MovieListLoaded(_allMovies, hasReachedMax: newMovies.length < 20);
        },
      );
    }
  }

  void refresh() {
    loadMovies();
  }
}

// Movie Details Notifier
class MovieDetailsNotifier extends StateNotifier<MovieDetailsState> {
  MovieDetailsNotifier(
    this._getMovieDetails,
    this._checkFavoriteStatus,
    this._movieId,
  ) : super(const MovieDetailsInitial()) {
    loadMovieDetails();
  }

  final GetMovieDetails _getMovieDetails;
  final CheckFavoriteStatus _checkFavoriteStatus;
  final int _movieId;

  Future<void> loadMovieDetails() async {
    state = const MovieDetailsLoading();

    final movieResult = await _getMovieDetails.call(GetMovieDetailsParams(movieId: _movieId));

    movieResult.fold(
      (failure) => state = MovieDetailsError(failure.message),
      (movie) async {
        final favoriteResult = await _checkFavoriteStatus.call(
          CheckFavoriteStatusParams(movieId: _movieId),
        );

        favoriteResult.fold(
          (failure) => state = MovieDetailsLoaded(movie, false),
          (isFavorite) => state = MovieDetailsLoaded(movie, isFavorite),
        );
      },
    );
  }

  void updateFavoriteStatus(bool isFavorite) {
    if (state is MovieDetailsLoaded) {
      final currentState = state as MovieDetailsLoaded;
      state = MovieDetailsLoaded(currentState.movie, isFavorite);
    }
  }
}

// Search Movies Notifier
class SearchMoviesNotifier extends StateNotifier<SearchMoviesState> {
  SearchMoviesNotifier(this._searchMovies) : super(const SearchMoviesInitial());

  final SearchMovies _searchMovies;
  int _currentPage = 1;
  List<Movie> _allMovies = [];
  String _currentQuery = '';

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      state = const SearchMoviesInitial();
      return;
    }

    if (query != _currentQuery) {
      _currentQuery = query;
      _currentPage = 1;
      _allMovies = [];
      state = const SearchMoviesLoading();
    } else if (state is SearchMoviesLoading || state is SearchMoviesLoadingMore) {
      return;
    }

    final result = await _searchMovies.call(SearchParams(query: query, page: _currentPage));

    result.fold(
      (failure) => state = SearchMoviesError(failure.message),
      (movies) {
        if (_currentPage == 1) {
          _allMovies = movies;
        } else {
          _allMovies.addAll(movies);
        }
        state = SearchMoviesLoaded(_allMovies, query, hasReachedMax: movies.length < 20);
      },
    );
  }

  Future<void> loadMoreSearchResults() async {
    if (state is SearchMoviesLoading || state is SearchMoviesLoadingMore) return;
    if (state is SearchMoviesLoaded && (state as SearchMoviesLoaded).hasReachedMax) return;

    if (state is SearchMoviesLoaded) {
      state = SearchMoviesLoadingMore(_allMovies, _currentQuery);
      _currentPage++;

      final result = await _searchMovies.call(SearchParams(query: _currentQuery, page: _currentPage));

      result.fold(
        (failure) => state = SearchMoviesLoaded(_allMovies, _currentQuery),
        (newMovies) {
          _allMovies.addAll(newMovies);
          state = SearchMoviesLoaded(_allMovies, _currentQuery, hasReachedMax: newMovies.length < 20);
        },
      );
    }
  }
}

// Favorite Movies Notifier
class FavoriteMoviesNotifier extends StateNotifier<MovieListState> {
  FavoriteMoviesNotifier(this._getFavoriteMovies, this._toggleFavorite)
      : super(const MovieListInitial());

  final GetFavoriteMovies _getFavoriteMovies;
  final ToggleFavorite _toggleFavorite;

  Future<void> loadFavoriteMovies() async {
    state = const MovieListLoading();

    final result = await _getFavoriteMovies.call(const NoParams());

    result.fold(
      (failure) => state = MovieListError(failure.message),
      (movies) => state = MovieListLoaded(movies, hasReachedMax: true),
    );
  }

  Future<void> toggleFavorite(int movieId) async {
    final result = await _toggleFavorite.call(ToggleFavoriteParams(movieId: movieId));

    result.fold(
      (failure) => <String, dynamic>{}, // Handle error silently or show snackbar
      (_) => loadFavoriteMovies(), // Reload favorites
    );
  }

  void refresh() {
    loadFavoriteMovies();
  }
}