import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/theme/app_colors.dart';
import 'package:movie_discovery_app/core/theme/app_spacing.dart';
import 'package:movie_discovery_app/core/theme/app_text_styles.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/favorites_provider.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_trailer_player.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: detailsState.whenDetails(
        initial: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
        loaded: (movie, _) => CustomScrollView(
          slivers: [
            // App Bar with backdrop image
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              stretch: true,
              backgroundColor: AppColors.primary,
              elevation: 0,
              leading: Container(
                margin: const EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: AppColors.overlay,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowDark,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_back, color: AppColors.textWhite),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Backdrop image
                    if (movie.backdropUrl.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: movie.backdropUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.cardElevated,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.cardElevated,
                          child: const Icon(
                            Icons.movie_outlined,
                            size: 100,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      )
                    else
                      Container(
                        color: AppColors.cardElevated,
                        child: const Icon(
                          Icons.movie_outlined,
                          size: 100,
                          color: AppColors.textTertiary,
                        ),
                      ),

                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.7),
                          ],
                          stops: const [0.5, 0.8, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(AppSpacing.sm),
                  decoration: const BoxDecoration(
                    color: AppColors.overlay,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowDark,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorite ? AppColors.favorite : AppColors.textWhite,
                    ),
                    onPressed: () {
                      ref
                          .read(movieFavoriteStatusProvider(movieId).notifier)
                          .toggle();
                      ref
                          .read(movieDetailsProvider(movieId).notifier)
                          .updateFavoriteStatus(!isFavorite);
                    },
                  ),
                ),
              ],
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster and basic info section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster with hero animation
                        Hero(
                          tag: 'movie_poster_$movieId',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMd),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowDark,
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMd),
                              child: SizedBox(
                                width: 120,
                                height: 180,
                                child: movie.posterUrl.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: movie.posterUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: AppColors.shimmerBase,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primary,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: AppColors.cardElevated,
                                          child: const Icon(
                                            Icons.movie_outlined,
                                            size: 50,
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        color: AppColors.cardElevated,
                                        child: const Icon(
                                          Icons.movie_outlined,
                                          size: 50,
                                          color: AppColors.textTertiary,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),

                        // Movie basic info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                movie.originalTitle,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),

                              // Rating
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: AppColors.accentGradient,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusRound),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.textWhite,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.rating.toStringAsFixed(1),
                                      style: AppTextStyles.labelLarge.copyWith(
                                        color: AppColors.textWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' (${movie.voteCount})',
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: AppColors.textWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),

                              // Release date
                              _buildInfoChip(
                                Icons.calendar_today,
                                movie.releaseDate,
                              ),
                              const SizedBox(height: AppSpacing.xs),

                              // Language
                              _buildInfoChip(
                                Icons.language,
                                movie.originalLanguage.toUpperCase(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Genres
                    if (movie.genreNames.isNotEmpty) ...[
                      Text(
                        l10n.genres,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.primaryLight
                                      : AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: movie.genreNames.map((genre) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppColors.primaryGradient,
                              ),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusRound),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              genre,
                              style: AppTextStyles.chipText,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],

                    // Trailer Player
                    MovieTrailerPlayer(movieId: movieId),
                    const SizedBox(height: AppSpacing.lg),

                    // Overview section
                    _buildSection(
                      context,
                      l10n.overview,
                      movie.overview.isNotEmpty
                          ? movie.overview
                          : l10n.noOverview,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Additional Info
                    _buildSection(context, l10n.additionalInformation, null),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoCard(context, l10n.popularity,
                        movie.popularity.toStringAsFixed(1)),
                    _buildInfoCard(context, l10n.adultContent,
                        movie.adult ? l10n.yes : l10n.no),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
        error: (message) => Scaffold(
          appBar: AppBar(
            title: Text(l10n.error),
            backgroundColor: AppColors.primary,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.errorOccurred,
                    style: AppTextStyles.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(movieDetailsProvider(movieId).notifier)
                          .loadMovieDetails();
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: AppTextStyles.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        if (content != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppColors.dividerLight,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primaryLight
                        : AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
