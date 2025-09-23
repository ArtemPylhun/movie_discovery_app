import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/core/storage/hive_storage.dart';
import 'package:movie_discovery_app/features/movies/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // .env file doesn't exist, that's okay for CI/CD
    // Debug print removed for production
  }

  // Initialize Hive for local storage
  await HiveStorage.init();

  // Initialize dependency injection
  await setupDI();

  runApp(const ProviderScope(child: MovieDiscoveryApp()));
}

class MovieDiscoveryApp extends StatelessWidget {
  const MovieDiscoveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Discovery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
