import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

/// Helper to properly reset app state between integration tests
class IntegrationTestHelper {
  /// Reset GetIt to allow multiple app initializations
  static Future<void> resetApp() async {
    // Reset GetIt instance
    await GetIt.instance.reset();

    // Give it a moment to fully reset
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}
