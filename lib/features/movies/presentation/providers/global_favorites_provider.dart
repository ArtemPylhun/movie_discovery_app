import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:movie_discovery_app/features/auth/presentation/providers/auth_state.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';

// Global provider to track all favorite changes (user-specific)
final globalFavoritesNotifierProvider =
    StateNotifierProvider<GlobalFavoritesNotifier, Set<int>>(
  (ref) => GlobalFavoritesNotifier(
    ref,
    getIt<ToggleFavorite>(),
    getIt<CheckFavoriteStatus>(),
  ),
);

class GlobalFavoritesNotifier extends StateNotifier<Set<int>> {
  GlobalFavoritesNotifier(
    this._ref,
    this._toggleFavorite,
    this._checkFavoriteStatus,
  ) : super(<int>{});

  final Ref _ref;
  final ToggleFavorite _toggleFavorite;
  final CheckFavoriteStatus _checkFavoriteStatus;

  // Get current user ID from auth state
  String? get _currentUserId {
    final authState = _ref.read(authProvider);
    if (authState is Authenticated) {
      return authState.user.id;
    }
    return null;
  }

  Future<bool> toggleFavorite(int movieId) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    final result = await _toggleFavorite.call(
      ToggleFavoriteParams(userId: userId, movieId: movieId),
    );

    return result.fold(
      (failure) => false,
      (_) async {
        // Check the new status and update global state
        final statusResult = await _checkFavoriteStatus.call(
          CheckFavoriteStatusParams(userId: userId, movieId: movieId),
        );

        return statusResult.fold(
          (failure) => false,
          (isFavorite) {
            final newState = Set<int>.from(state);
            if (isFavorite) {
              newState.add(movieId);
            } else {
              newState.remove(movieId);
            }
            state = newState;
            return isFavorite;
          },
        );
      },
    );
  }

  Future<bool> checkFavoriteStatus(int movieId) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    final result = await _checkFavoriteStatus.call(
      CheckFavoriteStatusParams(userId: userId, movieId: movieId),
    );

    return result.fold(
      (failure) => false,
      (isFavorite) {
        final newState = Set<int>.from(state);
        if (isFavorite) {
          newState.add(movieId);
        } else {
          newState.remove(movieId);
        }
        state = newState;
        return isFavorite;
      },
    );
  }

  bool isFavorite(int movieId) {
    return state.contains(movieId);
  }

  void refreshFavoriteStatus(int movieId) {
    checkFavoriteStatus(movieId);
  }

  // Clear favorites when user logs out
  void clearFavorites() {
    state = <int>{};
  }
}
