import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/theme/app_colors.dart';
import 'package:movie_discovery_app/core/theme/app_spacing.dart';
import 'package:movie_discovery_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_list_section.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/movie_search_bar.dart';
import 'package:movie_discovery_app/features/movies/presentation/widgets/favorite_movies_section.dart';
import 'package:movie_discovery_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.secondaryGradient,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: const Icon(
                Icons.movie_filter,
                color: AppColors.textWhite,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              l10n.homeTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: l10n.settings,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryGradient,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.textWhite,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.textWhite,
              unselectedLabelColor: AppColors.textWhite.withValues(alpha: 0.7),
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              tabs: [
                Tab(
                  icon: const Icon(Icons.trending_up, size: 20),
                  text: l10n.tabPopular,
                ),
                Tab(
                  icon: const Icon(Icons.star_rounded, size: 20),
                  text: l10n.tabTopRated,
                ),
                Tab(
                  icon: const Icon(Icons.upcoming_rounded, size: 20),
                  text: l10n.tabUpcoming,
                ),
                Tab(
                  icon: const Icon(Icons.favorite_rounded, size: 20),
                  text: l10n.tabFavorites,
                ),
              ],
            ),
          ),
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
                  emptyMessage: l10n.noPopularMovies,
                ),
                MovieListSection(
                  provider: topRatedMoviesProvider,
                  emptyMessage: l10n.noTopRatedMovies,
                ),
                MovieListSection(
                  provider: upcomingMoviesProvider,
                  emptyMessage: l10n.noUpcomingMovies,
                ),
                FavoriteMoviesSection(
                  provider: favoriteMoviesProvider,
                  emptyMessage: l10n.noFavoriteMovies,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.secondaryGradient,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.refresh_rounded, size: 28),
        ),
      ),
    );
  }
}
