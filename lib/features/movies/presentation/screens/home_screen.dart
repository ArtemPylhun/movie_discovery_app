import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_list_section.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_search_bar.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/favorite_movies_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(popularMoviesProvider.notifier).loadMovies();
      ref.read(topRatedMoviesProvider.notifier).loadMovies();
      ref.read(upcomingMoviesProvider.notifier).loadMovies();
      ref.read(favoriteMoviesProvider.notifier).loadFavoriteMovies();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Discovery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.trending_up), text: 'Popular'),
            Tab(icon: Icon(Icons.star), text: 'Top Rated'),
            Tab(icon: Icon(Icons.upcoming), text: 'Upcoming'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
          ],
        ),
      ),
      body: Column(
        children: [
          const MovieSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MovieListSection(
                  provider: popularMoviesProvider,
                  emptyMessage: 'No popular movies found',
                ),
                MovieListSection(
                  provider: topRatedMoviesProvider,
                  emptyMessage: 'No top rated movies found',
                ),
                MovieListSection(
                  provider: upcomingMoviesProvider,
                  emptyMessage: 'No upcoming movies found',
                ),
                FavoriteMoviesSection(
                  provider: favoriteMoviesProvider,
                  emptyMessage: 'No favorite movies yet.\nStart adding movies to your favorites!',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh current tab
          switch (_tabController.index) {
            case 0:
              ref.read(popularMoviesProvider.notifier).refresh();
              break;
            case 1:
              ref.read(topRatedMoviesProvider.notifier).refresh();
              break;
            case 2:
              ref.read(upcomingMoviesProvider.notifier).refresh();
              break;
            case 3:
              ref.read(favoriteMoviesProvider.notifier).refresh();
              break;
          }
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}