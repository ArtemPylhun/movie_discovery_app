import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_discovery_app/core/network/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Core
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiClient(getIt()));

  // TODO: Add data sources, repositories, and use cases
  // This will be completed in Week 2
}

Future<void> resetDI() async {
  await getIt.reset();
}