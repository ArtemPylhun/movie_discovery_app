import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/global_favorites_provider.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_loading_grid.dart';

class FavoriteMoviesSection extends ConsumerWidget {
  const FavoriteMoviesSection({
    super.key,
    required this.provider,
    required this.emptyMessage,
  });

  final StateNotifierProvider<FavoriteMoviesNotifier, MovieListState> provider;
  final String emptyMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    // Auto-refresh when global favorites change
    ref.listen(globalFavoritesNotifierProvider, (previous, next) {
      if (previous != next) {
        // Delay to avoid calling during build
        Future.microtask(() => ref.read(provider.notifier).refresh());
      }
    });

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(provider.notifier).refresh();
      },
      child: state.when(
        initial: () => const Center(
          child: Text('Pull to refresh'),
        ),
        loading: () => const MovieLoadingGrid(),
        loadingMore: (movies) => _buildMovieGrid(context, movies),
        loaded: (movies, hasReachedMax) => movies.isEmpty
            ? Center(
                child: Text(
                  emptyMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : _buildMovieGrid(context, movies),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: $message',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(provider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieGrid(BuildContext context, List<Movie> movies) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}

// Extension to add when method to MovieListState for favorites
extension FavoriteMoviesStateExt on MovieListState {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Movie> movies) loadingMore,
    required T Function(List<Movie> movies, bool hasReachedMax) loaded,
    required T Function(String message) error,
  }) {
    if (this is MovieListInitial) {
      return initial();
    } else if (this is MovieListLoading) {
      return loading();
    } else if (this is MovieListLoadingMore) {
      final state = this as MovieListLoadingMore;
      return loadingMore(state.movies);
    } else if (this is MovieListLoaded) {
      final state = this as MovieListLoaded;
      return loaded(state.movies, state.hasReachedMax);
    } else if (this is MovieListError) {
      final state = this as MovieListError;
      return error(state.message);
    } else {
      return initial();
    }
  }
}