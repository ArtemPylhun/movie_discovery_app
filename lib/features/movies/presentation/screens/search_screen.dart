import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/theme/app_colors.dart';
import 'package:movie_discovery_app/core/theme/app_spacing.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_loading_grid.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      ref.read(searchMoviesStateProvider.notifier).searchMovies(query.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchMoviesStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          constraints: const BoxConstraints(
            maxHeight: 46,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              hintText: l10n.searchMovies,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[400]
                        : AppColors.textTertiary,
                    fontSize: 16,
                  ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 12,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[300]
                    : AppColors.textSecondary,
                size: 22,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 46,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[300]
                            : AppColors.textSecondary,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 48,
                        minHeight: 46,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(searchQueryProvider.notifier).state = '';
                        setState(() {}); // Update to hide clear button
                      },
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 46,
              ),
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                ),
            textInputAction: TextInputAction.search,
            onSubmitted: _performSearch,
            onChanged: (query) {
              setState(() {}); // Update to show/hide clear button
              if (query.trim().isEmpty) {
                ref.read(searchQueryProvider.notifier).state = '';
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textWhite),
            onPressed: () => _performSearch(_searchController.text),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: searchState.whenSearch(
        initial: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.searchForMovies,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        loading: () => const MovieLoadingGrid(),
        loadingMore: (movies, query) => _buildSearchResults(movies, true),
        loaded: (movies, query, hasReachedMax) => movies.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.movie_filter,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noMoviesFound(query),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : _buildSearchResults(movies, false, hasReachedMax),
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
                l10n.errorMessage(message),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _performSearch(_searchController.text),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    List<Movie> movies,
    bool isLoadingMore, [
    bool hasReachedMax = false,
  ]) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!hasReachedMax &&
            !isLoadingMore &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          ref.read(searchMoviesStateProvider.notifier).loadMoreSearchResults();
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: movies.length + (isLoadingMore ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return const MovieLoadingCard();
          }
          return MovieCard(movie: movies[index]);
        },
      ),
    );
  }
}

// Extension to add when method to SearchMoviesState
extension SearchMoviesStateExt on SearchMoviesState {
  T whenSearch<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Movie> movies, String query) loadingMore,
    required T Function(List<Movie> movies, String query, bool hasReachedMax)
        loaded,
    required T Function(String message) error,
  }) {
    if (this is SearchMoviesInitial) {
      return initial();
    } else if (this is SearchMoviesLoading) {
      return loading();
    } else if (this is SearchMoviesLoadingMore) {
      final state = this as SearchMoviesLoadingMore;
      return loadingMore(state.movies, state.query);
    } else if (this is SearchMoviesLoaded) {
      final state = this as SearchMoviesLoaded;
      return loaded(state.movies, state.query, state.hasReachedMax);
    } else if (this is SearchMoviesError) {
      final state = this as SearchMoviesError;
      return error(state.message);
    } else {
      return initial();
    }
  }
}
