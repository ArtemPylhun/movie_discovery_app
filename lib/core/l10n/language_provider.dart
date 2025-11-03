import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_discovery_app/core/theme/theme_provider.dart';

/// Key for storing language preference in SharedPreferences
const String _languageKey = 'app_language';

/// Language provider that manages app language with persistence
final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LanguageNotifier(prefs);
});

/// Language notifier that handles language changes and persistence
class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier(this._prefs) : super(_getInitialLocale(_prefs));

  final SharedPreferences _prefs;

  /// Get initial locale from SharedPreferences or use system default
  static Locale _getInitialLocale(SharedPreferences prefs) {
    final languageCode = prefs.getString(_languageKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    // Default to English if no preference is saved
    return const Locale('en');
  }

  /// Set the app language and persist the preference
  Future<void> setLanguage(Locale locale) async {
    state = locale;
    await _prefs.setString(_languageKey, locale.languageCode);
  }

  /// Toggle between English and Ukrainian
  Future<void> toggleLanguage() async {
    final newLocale =
        state.languageCode == 'en' ? const Locale('uk') : const Locale('en');
    await setLanguage(newLocale);
  }

  /// Get the current language display name
  String getLanguageDisplayName() {
    switch (state.languageCode) {
      case 'uk':
        return 'Українська';
      case 'en':
      default:
        return 'English';
    }
  }
}

/// Supported locales for the app
class AppLocales {
  static const english = Locale('en');
  static const ukrainian = Locale('uk');

  static const List<Locale> supportedLocales = [
    english,
    ukrainian,
  ];

  /// Get language name by locale
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'uk':
        return 'Українська';
      case 'en':
      default:
        return 'English';
    }
  }

  /// Get native language name by locale (for display in language selection)
  static String getNativeLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'uk':
        return 'Українська';
      case 'en':
      default:
        return 'English';
    }
  }
}
