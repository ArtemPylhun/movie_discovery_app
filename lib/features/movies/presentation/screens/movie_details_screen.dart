import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/favorites_provider.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(movieDetailsProvider(movieId));
    final isFavorite = ref.watch(movieFavoriteStatusProvider(movieId));

    return Scaffold(
      body: detailsState.whenDetails(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (movie, _) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: movie.backdropUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: movie.backdropUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, size: 100),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.movie, size: 100),
                      ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    ref.read(movieFavoriteStatusProvider(movieId).notifier).toggle();
                    // Also update the details state
                    ref.read(movieDetailsProvider(movieId).notifier).updateFavoriteStatus(!isFavorite);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 120,
                            height: 180,
                            child: movie.posterUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: movie.posterUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[300],
                                      child: const Center(child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.movie, size: 50),
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.movie, size: 50),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Movie Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.originalTitle,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[600],
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.rating.toStringAsFixed(1),
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    ' (${movie.voteCount} votes)',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Release Date: ${movie.releaseDate}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Language: ${movie.originalLanguage.toUpperCase()}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              if (movie.genreNames.isNotEmpty) ...[
                                Text(
                                  'Genres',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: movie.genreNames.map((genre) {
                                    return Chip(
                                      label: Text(
                                        genre,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.overview.isNotEmpty ? movie.overview : 'No overview available.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Additional Info',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow('Popularity', movie.popularity.toStringAsFixed(1)),
                    _buildInfoRow('Adult Content', movie.adult ? 'Yes' : 'No'),
                    _buildInfoRow('Genres', movie.genreNames.join(', ')),
                  ],
                ),
              ),
            ),
          ],
        ),
        error: (message) => Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
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
                  onPressed: () {
                    ref.read(movieDetailsProvider(movieId).notifier).loadMovieDetails();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

// Extension to add when method to MovieDetailsState
extension MovieDetailsStateExt on MovieDetailsState {
  T whenDetails<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(Movie movie, bool isFavorite) loaded,
    required T Function(String message) error,
  }) {
    if (this is MovieDetailsInitial) {
      return initial();
    } else if (this is MovieDetailsLoading) {
      return loading();
    } else if (this is MovieDetailsLoaded) {
      final state = this as MovieDetailsLoaded;
      return loaded(state.movie, state.isFavorite);
    } else if (this is MovieDetailsError) {
      final state = this as MovieDetailsError;
      return error(state.message);
    } else {
      return initial();
    }
  }
}