import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_discovery_app/core/network/api_client.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/local/movie_database.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/local/movie_local_data_source.dart';
import 'package:movie_discovery_app/features/movies/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie_discovery_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movie_discovery_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_movie_details.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/search_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_favorite_movies.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/toggle_favorite.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/check_favorite_status.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Core
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiClient(getIt()));

  // Database
  getIt.registerLazySingleton(() => MovieDatabase());

  // Data Sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTopRatedMovies(getIt()));
  getIt.registerLazySingleton(() => GetUpcomingMovies(getIt()));
  getIt.registerLazySingleton(() => GetMovieDetails(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));
  getIt.registerLazySingleton(() => GetFavoriteMovies(getIt()));
  getIt.registerLazySingleton(() => ToggleFavorite(getIt()));
  getIt.registerLazySingleton(() => CheckFavoriteStatus(getIt()));
}

Future<void> resetDI() async {
  await getIt.reset();
}