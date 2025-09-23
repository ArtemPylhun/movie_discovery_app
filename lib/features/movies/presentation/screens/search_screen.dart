import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/movie.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_state.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_card.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_loading_grid.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(fontSize: 18),
          textInputAction: TextInputAction.search,
          onSubmitted: _performSearch,
          onChanged: (query) {
            if (query.trim().isEmpty) {
              // Clear search results when query is empty
              ref.read(searchQueryProvider.notifier).state = '';
            }
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _performSearch(_searchController.text),
          ),
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                ref.read(searchQueryProvider.notifier).state = '';
                FocusScope.of(context).unfocus();
              },
            ),
        ],
      ),
      body: searchState.whenSearch(
        initial: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Search for movies',
                style: TextStyle(
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
                      'No movies found for "$query"',
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
                'Error: $message',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _performSearch(_searchController.text),
                child: const Text('Retry'),
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
