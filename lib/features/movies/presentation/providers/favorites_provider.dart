import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';

// Favorites Action Provider
final favoritesActionProvider = Provider<FavoritesAction>(
  (ref) => FavoritesAction(
    getIt<ToggleFavorite>(),
    getIt<CheckFavoriteStatus>(),
  ),
);

// Individual Movie Favorite Status Provider
final movieFavoriteStatusProvider =
    StateNotifierProvider.family<MovieFavoriteNotifier, bool, int>(
  (ref, movieId) => MovieFavoriteNotifier(
    movieId,
    ref.read(favoritesActionProvider),
  ),
);

class FavoritesAction {
  const FavoritesAction(this._toggleFavorite, this._checkFavoriteStatus);

  final ToggleFavorite _toggleFavorite;
  final CheckFavoriteStatus _checkFavoriteStatus;

  Future<bool> toggleFavorite(int movieId) async {
    final result =
        await _toggleFavorite.call(ToggleFavoriteParams(movieId: movieId));

    return result.fold(
      (failure) => false, // Return false if toggle failed
      (_) async {
        // Check the new status after toggling
        final statusResult = await _checkFavoriteStatus.call(
          CheckFavoriteStatusParams(movieId: movieId),
        );
        return statusResult.fold(
          (failure) => false,
          (isFavorite) => isFavorite,
        );
      },
    );
  }

  Future<bool> checkFavoriteStatus(int movieId) async {
    final result = await _checkFavoriteStatus.call(
      CheckFavoriteStatusParams(movieId: movieId),
    );

    return result.fold(
      (failure) => false,
      (isFavorite) => isFavorite,
    );
  }
}

class MovieFavoriteNotifier extends StateNotifier<bool> {
  MovieFavoriteNotifier(this._movieId, this._favoritesAction) : super(false) {
    _loadFavoriteStatus();
  }

  final int _movieId;
  final FavoritesAction _favoritesAction;

  Future<void> _loadFavoriteStatus() async {
    final isFavorite = await _favoritesAction.checkFavoriteStatus(_movieId);
    state = isFavorite;
  }

  Future<void> toggle() async {
    final newStatus = await _favoritesAction.toggleFavorite(_movieId);
    state = newStatus;

    // Notify favorites list to refresh
    _notifyFavoritesChanged();
  }

  void updateStatus(bool isFavorite) {
    state = isFavorite;
  }

  void _notifyFavoritesChanged() {
    // This will be handled by listening to state changes
    // The FavoriteMoviesSection will refresh when needed
  }
}
