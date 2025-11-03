import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/l10n/language_provider.dart';
import 'package:movie_discovery_app/core/theme/app_colors.dart';
import 'package:movie_discovery_app/core/theme/app_spacing.dart';
import 'package:movie_discovery_app/core/theme/theme_provider.dart';
import 'package:movie_discovery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:movie_discovery_app/l10n/app_localizations.dart';

/// Settings screen with theme toggle and other app settings
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final locale = ref.watch(languageProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        children: [
          // Theme Section
          _buildSectionHeader(context, l10n.appearance),
          _buildThemeTile(context, ref, isDarkMode, l10n),
          _buildLanguageTile(context, ref, locale, l10n),
          const Divider(height: AppSpacing.lg),

          // Account Section
          _buildSectionHeader(context, l10n.account),
          _buildAccountInfoTile(context, l10n),
          _buildSignOutTile(context, ref, l10n),
          const Divider(height: AppSpacing.lg),

          // About Section
          _buildSectionHeader(context, l10n.about),
          _buildAboutTile(context, l10n),
          _buildVersionTile(context, l10n),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
      ),
    );
  }

  /// Build theme toggle tile
  Widget _buildThemeTile(BuildContext context, WidgetRef ref, bool isDarkMode,
      AppLocalizations l10n) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
      title: Text(l10n.darkMode),
      subtitle: Text(
        isDarkMode ? l10n.enabled : l10n.disabled,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          final newMode = value ? ThemeMode.dark : ThemeMode.light;
          ref.read(themeProvider.notifier).setThemeMode(newMode);
        },
        activeThumbColor: Theme.of(context).colorScheme.primary,
      ),
      onTap: () {
        ref.read(themeProvider.notifier).toggleTheme();
      },
    );
  }

  /// Build language selector tile
  Widget _buildLanguageTile(BuildContext context, WidgetRef ref, Locale locale,
      AppLocalizations l10n) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.language_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
      title: Text(l10n.language),
      subtitle: Text(
        AppLocales.getLanguageName(locale),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        _showLanguageDialog(context, ref, l10n);
      },
    );
  }

  /// Build account info tile
  Widget _buildAccountInfoTile(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.person_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: 24,
        ),
      ),
      title: Text(
        l10n.accountInformation,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(l10n.viewProfileDetails),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        _showAccountInfoDialog(context, l10n);
      },
    );
  }

  /// Build sign out tile
  Widget _buildSignOutTile(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.logout_rounded,
          color: Theme.of(context).colorScheme.error,
          size: 24,
        ),
      ),
      title: Text(l10n.signOut),
      subtitle: Text(l10n.signOutSubtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        _showSignOutDialog(context, ref, l10n);
      },
    );
  }

  /// Build about tile
  Widget _buildAboutTile(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.info_rounded,
          color: Theme.of(context).colorScheme.tertiary,
          size: 24,
        ),
      ),
      title: Text(l10n.about),
      subtitle: Text('${l10n.about} Movie Discovery'),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        _showAboutDialog(context, l10n);
      },
    );
  }

  /// Build version tile
  Widget _buildVersionTile(BuildContext context, AppLocalizations l10n) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.code_rounded,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
      ),
      title: Text(l10n.version),
      subtitle: const Text('0.1.0'),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        _showVersionInfoDialog(context, l10n);
      },
    );
  }

  /// Show language selection dialog
  void _showLanguageDialog(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final currentLocale = ref.read(languageProvider);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                Icons.language_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(l10n.selectLanguage),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppLocales.supportedLocales.map((locale) {
            final isSelected =
                locale.languageCode == currentLocale.languageCode;
            // ignore: deprecated_member_use
            return RadioListTile<Locale>(
              value: locale,
              // ignore: deprecated_member_use
              groupValue: currentLocale,
              title: Text(AppLocales.getNativeLanguageName(locale)),
              activeColor: Theme.of(context).colorScheme.primary,
              // ignore: deprecated_member_use
              onChanged: (Locale? value) {
                if (value != null) {
                  ref.read(languageProvider.notifier).setLanguage(value);
                  Navigator.of(context).pop();
                }
              },
              selected: isSelected,
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  /// Show account information dialog
  void _showAccountInfoDialog(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.accountInformation,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.accountDetailsManaged,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.email_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        l10n.email,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.signedInWith,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  /// Show sign out confirmation dialog
  void _showSignOutDialog(
      BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(l10n.signOut),
          ],
        ),
        content: Text(l10n.signOutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Pop settings screen
              ref.read(authProvider.notifier).signOut();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );
  }

  /// Show about dialog
  void _showAboutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
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
            Text(l10n.aboutMovieDiscovery),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.aboutDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureItem(
                    context,
                    Icons.movie_rounded,
                    l10n.featureBrowse,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildFeatureItem(
                    context,
                    Icons.search_rounded,
                    l10n.featureSearch,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildFeatureItem(
                    context,
                    Icons.favorite_rounded,
                    l10n.featureFavorites,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildFeatureItem(
                    context,
                    Icons.dark_mode_rounded,
                    l10n.featureDarkMode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.poweredByTmdb,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  /// Show version info dialog
  void _showVersionInfoDialog(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                Icons.code_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(l10n.versionInformation),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVersionInfoRow(context, l10n.versionLabel, '0.1.0'),
            const SizedBox(height: AppSpacing.sm),
            _buildVersionInfoRow(context, l10n.buildLabel, '1'),
            const SizedBox(height: AppSpacing.sm),
            _buildVersionInfoRow(context, l10n.flutterSdkLabel, '3.5.0'),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      l10n.educationalProject,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  /// Build feature item for about dialog
  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  /// Build version info row
  Widget _buildVersionInfoRow(
    BuildContext context,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}
