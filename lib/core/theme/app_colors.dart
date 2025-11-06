import 'package:flutter/material.dart';

/// Application color palette
/// A modern, professional color scheme with deep indigo primary and amber accents
class AppColors {
  AppColors._();

  // Primary Colors - Deep Indigo/Purple
  static const Color primary = Color(0xFF1A237E); // Deep Blue
  static const Color primaryLight = Color(0xFF534BAE); // Lighter shade
  static const Color primaryDark = Color(0xFF000051); // Darker shade
  static const Color primaryContainer = Color(0xFF3949AB);

  // Secondary Colors - Amber/Orange accents
  static const Color secondary = Color(0xFFFF6F00); // Deep Orange
  static const Color secondaryLight = Color(0xFFFF9E40); // Lighter orange
  static const Color secondaryDark = Color(0xFFC43E00); // Darker orange
  static const Color secondaryContainer = Color(0xFFFFB74D);

  // Accent Colors
  static const Color accent = Color(0xFFFFC107); // Amber
  static const Color accentLight = Color(0xFFFFD54F);
  static const Color accentDark = Color(0xFFFFA000);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA); // Light grey background
  static const Color backgroundDark = Color(0xFF121212); // Dark background
  static const Color surface = Color(0xFFFFFFFF); // White surface
  static const Color surfaceDark = Color(0xFF1E1E1E); // Dark surface

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color cardElevated = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Dark grey text
  static const Color textSecondary = Color(0xFF757575); // Medium grey text
  static const Color textTertiary = Color(0xFF9E9E9E); // Light grey text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFF44336); // Red
  static const Color info = Color(0xFF2196F3); // Blue

  // Rating Colors
  static const Color ratingGold = Color(0xFFFFD700);
  static const Color ratingStar = Color(0xFFFFC107);
  static const Color ratingBackground = Color(0xFF1A1A1A);

  // Favorite Color
  static const Color favorite = Color(0xFFE91E63); // Pink/Red for favorites
  static const Color favoriteLight = Color(0xFFF48FB1);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF1A237E),
    Color(0xFF3949AB),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFFFF6F00),
    Color(0xFFFFB74D),
  ];

  static const List<Color> cardOverlayGradient = [
    Color(0x00000000), // Transparent at top
    Color(0xCC000000), // Semi-transparent black at bottom
  ];

  static const List<Color> accentGradient = [
    Color(0xFFFFA000),
    Color(0xFFFFD54F),
  ];

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // 10% black
  static const Color shadowMedium = Color(0x33000000); // 20% black
  static const Color shadowDark = Color(0x4D000000); // 30% black

  // Divider Colors
  static const Color divider = Color(0xFFBDBDBD);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x40000000); // 25% black
  static const Color overlayDark = Color(0xB3000000); // 70% black
}
