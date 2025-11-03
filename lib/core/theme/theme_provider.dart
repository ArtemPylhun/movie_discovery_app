import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keys for SharedPreferences storage
class _ThemePreferenceKeys {
  static const String themeMode = 'theme_mode';
}

/// Theme notifier that manages theme state and persists user preference
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier(this._prefs) : super(ThemeMode.system) {
    _loadThemeMode();
  }
  final SharedPreferences _prefs;

  /// Load saved theme mode from SharedPreferences
  void _loadThemeMode() {
    final savedThemeMode = _prefs.getString(_ThemePreferenceKeys.themeMode);
    if (savedThemeMode != null) {
      state = _themeModeFromString(savedThemeMode);
    }
  }

  /// Set theme mode and persist to SharedPreferences
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setString(
      _ThemePreferenceKeys.themeMode,
      _themeModeToString(mode),
    );
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Check if dark mode is currently active
  bool get isDarkMode => state == ThemeMode.dark;

  /// Convert ThemeMode to String for storage
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// Convert String to ThemeMode
  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}

/// Provider for SharedPreferences instance
/// This should be overridden with actual instance in main.dart
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
      'SharedPreferences must be initialized in main.dart');
});

/// Provider for theme notifier
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeNotifier(prefs);
});

/// Convenience provider to check if dark mode is active
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark;
});
