import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static const String _userPrefsBox = 'user_preferences';
  static const String _settingsBox = 'app_settings';

  static Box<dynamic>? _userPrefsBoxInstance;
  static Box<dynamic>? _settingsBoxInstance;

  static Future<void> init() async {
    await Hive.initFlutter();

    _userPrefsBoxInstance = await Hive.openBox(_userPrefsBox);
    _settingsBoxInstance = await Hive.openBox(_settingsBox);
  }

  // User Preferences
  static Box<dynamic> get userPrefs {
    if (_userPrefsBoxInstance == null) {
      throw Exception('HiveStorage not initialized. Call HiveStorage.init() first.');
    }
    return _userPrefsBoxInstance!;
  }

  // App Settings
  static Box<dynamic> get settings {
    if (_settingsBoxInstance == null) {
      throw Exception('HiveStorage not initialized. Call HiveStorage.init() first.');
    }
    return _settingsBoxInstance!;
  }

  // Convenience methods for common operations
  static Future<void> setUserPreference(String key, dynamic value) async {
    await userPrefs.put(key, value);
  }

  static T? getUserPreference<T>(String key, {T? defaultValue}) {
    return userPrefs.get(key, defaultValue: defaultValue) as T?;
  }

  static Future<void> setSetting(String key, dynamic value) async {
    await settings.put(key, value);
  }

  static T? getSetting<T>(String key, {T? defaultValue}) {
    return settings.get(key, defaultValue: defaultValue) as T?;
  }

  static Future<void> clearUserPreferences() async {
    await userPrefs.clear();
  }

  static Future<void> clearSettings() async {
    await settings.clear();
  }

  static Future<void> close() async {
    await _userPrefsBoxInstance?.close();
    await _settingsBoxInstance?.close();
  }
}

// Constants for commonly used preference keys
class HiveKeys {
  // User Preferences
  static const String lastSelectedTab = 'last_selected_tab';
  static const String favoriteGenres = 'favorite_genres';
  static const String searchHistory = 'search_history';

  // App Settings
  static const String isDarkMode = 'is_dark_mode';
  static const String language = 'language';
  static const String cacheSize = 'cache_size';
  static const String autoRefresh = 'auto_refresh';
}