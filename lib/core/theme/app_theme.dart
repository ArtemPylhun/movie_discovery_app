import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_discovery_app/core/theme/app_colors.dart';
import 'package:movie_discovery_app/core/theme/app_spacing.dart';
import 'package:movie_discovery_app/core/theme/app_text_styles.dart';

/// Application theme configuration
/// Provides a modern, professional theme with Material Design 3
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        tertiary: AppColors.accent,
        tertiaryContainer: AppColors.accentLight,
        surface: AppColors.surface,
        surfaceTint: AppColors.primaryLight,
        error: AppColors.error,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnSecondary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textWhite,
        outline: AppColors.divider,
        shadow: AppColors.shadowMedium,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.background,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: AppSpacing.elevationMedium,
        centerTitle: false,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: AppColors.textWhite,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textWhite,
          size: AppSpacing.iconMd,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: AppSpacing.elevationMedium,
        shadowColor: AppColors.shadowMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        color: AppColors.cardLight,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppSpacing.elevationMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          textStyle: AppTextStyles.buttonText,
          minimumSize: const Size(64, AppSpacing.buttonHeightMd),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          side: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.buttonText,
          minimumSize: const Size(64, AppSpacing.buttonHeightMd),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.buttonText,
          minimumSize: const Size(64, AppSpacing.buttonHeightMd),
        ),
      ),

      // FloatingActionButton theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: AppSpacing.elevationHigh,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textWhite,
        shape: CircleBorder(),
        iconSize: AppSpacing.iconMd,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primary,
        deleteIconColor: AppColors.textWhite,
        disabledColor: AppColors.dividerLight,
        selectedColor: AppColors.primaryDark,
        secondarySelectedColor: AppColors.secondary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        labelStyle: AppTextStyles.chipText,
        secondaryLabelStyle: AppTextStyles.chipText,
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        elevation: AppSpacing.elevationVeryHigh,
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        titleTextStyle: AppTextStyles.titleLarge,
        contentTextStyle: AppTextStyles.bodyMedium,
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: AppSpacing.elevationVeryHigh,
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusLg),
          ),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: AppSpacing.iconMd,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: AppSpacing.md,
      ),

      // TabBar theme
      tabBarTheme: const TabBarThemeData(
        indicatorColor: AppColors.textWhite,
        labelColor: AppColors.textWhite,
        unselectedLabelColor: AppColors.textWhite,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.textWhite,
            width: 3,
          ),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.dividerLight,
        circularTrackColor: AppColors.dividerLight,
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textWhite,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: AppSpacing.elevationHigh,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color scheme for dark mode
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primary,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondary,
        tertiary: AppColors.accentLight,
        tertiaryContainer: AppColors.accent,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textWhite,
        onSurface: AppColors.textWhite,
        onError: AppColors.textWhite,
        outline: Color(0xFF757575),
        shadow: AppColors.shadowDark,
      ),

      scaffoldBackgroundColor: AppColors.backgroundDark,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: AppSpacing.elevationMedium,
        centerTitle: false,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: AppColors.textWhite,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textWhite,
          size: AppSpacing.iconMd,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: AppSpacing.elevationMedium,
        shadowColor: AppColors.shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        color: AppColors.cardDark,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),

      // Text theme with light colors for dark background
      textTheme: TextTheme(
        displayLarge:
            AppTextStyles.displayLarge.copyWith(color: AppColors.textWhite),
        displayMedium:
            AppTextStyles.displayMedium.copyWith(color: AppColors.textWhite),
        displaySmall:
            AppTextStyles.displaySmall.copyWith(color: AppColors.textWhite),
        headlineLarge:
            AppTextStyles.headlineLarge.copyWith(color: AppColors.textWhite),
        headlineMedium:
            AppTextStyles.headlineMedium.copyWith(color: AppColors.textWhite),
        headlineSmall:
            AppTextStyles.headlineSmall.copyWith(color: AppColors.textWhite),
        titleLarge:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textWhite),
        titleMedium:
            AppTextStyles.titleMedium.copyWith(color: AppColors.textWhite),
        titleSmall:
            AppTextStyles.titleSmall.copyWith(color: AppColors.textWhite),
        bodyLarge:
            AppTextStyles.bodyLarge.copyWith(color: const Color(0xFFE0E0E0)),
        bodyMedium:
            AppTextStyles.bodyMedium.copyWith(color: const Color(0xFFE0E0E0)),
        bodySmall:
            AppTextStyles.bodySmall.copyWith(color: const Color(0xFFB0B0B0)),
        labelLarge:
            AppTextStyles.labelLarge.copyWith(color: const Color(0xFFE0E0E0)),
        labelMedium:
            AppTextStyles.labelMedium.copyWith(color: const Color(0xFFB0B0B0)),
        labelSmall:
            AppTextStyles.labelSmall.copyWith(color: const Color(0xFF9E9E9E)),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppSpacing.elevationMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textWhite,
          textStyle: AppTextStyles.buttonText,
          minimumSize: const Size(64, AppSpacing.buttonHeightMd),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          side: const BorderSide(
            color: AppColors.primaryLight,
            width: 2,
          ),
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTextStyles.buttonText,
          minimumSize: const Size(64, AppSpacing.buttonHeightMd),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTextStyles.buttonText,
          minimumSize: const Size(64, AppSpacing.buttonHeightMd),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: Color(0xFF616161)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: Color(0xFF616161)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: const Color(0xFF9E9E9E),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          color: const Color(0xFFB0B0B0),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textWhite,
        size: AppSpacing.iconMd,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF424242),
        thickness: 1,
        space: AppSpacing.md,
      ),

      // TabBar theme
      tabBarTheme: const TabBarThemeData(
        indicatorColor: AppColors.textWhite,
        labelColor: AppColors.textWhite,
        unselectedLabelColor: Color(0xFFB0B0B0),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.textWhite,
            width: 3,
          ),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        elevation: AppSpacing.elevationVeryHigh,
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        titleTextStyle:
            AppTextStyles.titleLarge.copyWith(color: AppColors.textWhite),
        contentTextStyle:
            AppTextStyles.bodyMedium.copyWith(color: const Color(0xFFE0E0E0)),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: Color(0xFF424242),
        circularTrackColor: Color(0xFF424242),
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.cardDark,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textWhite,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: AppSpacing.elevationHigh,
      ),
    );
  }
}
