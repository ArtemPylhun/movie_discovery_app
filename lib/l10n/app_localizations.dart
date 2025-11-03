import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Movie Discovery'**
  String get appTitle;

  /// Title shown in home screen app bar
  ///
  /// In en, this message translates to:
  /// **'Movie Discovery'**
  String get homeTitle;

  /// Popular movies tab
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get tabPopular;

  /// Top rated movies tab
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get tabTopRated;

  /// Upcoming movies tab
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get tabUpcoming;

  /// Favorites movies tab
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get tabFavorites;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Search bar hint text
  ///
  /// In en, this message translates to:
  /// **'Search movies...'**
  String get searchMovies;

  /// Search screen initial message
  ///
  /// In en, this message translates to:
  /// **'Search for movies'**
  String get searchForMovies;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No movies found for \"{query}\"'**
  String noMoviesFound(String query);

  /// Empty state for popular movies
  ///
  /// In en, this message translates to:
  /// **'No popular movies found'**
  String get noPopularMovies;

  /// Empty state for top rated movies
  ///
  /// In en, this message translates to:
  /// **'No top rated movies found'**
  String get noTopRatedMovies;

  /// Empty state for upcoming movies
  ///
  /// In en, this message translates to:
  /// **'No upcoming movies found'**
  String get noUpcomingMovies;

  /// Empty state for favorite movies
  ///
  /// In en, this message translates to:
  /// **'No favorite movies yet.\nStart adding movies to your favorites!'**
  String get noFavoriteMovies;

  /// Generic error label
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get errorOccurred;

  /// Error message with details
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(String message);

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Movie details screen title
  ///
  /// In en, this message translates to:
  /// **'Movie Details'**
  String get movieDetailsTitle;

  /// Overview section title
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// Message when overview is empty
  ///
  /// In en, this message translates to:
  /// **'No overview available.'**
  String get noOverview;

  /// Genres section title
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// Additional information section title
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInformation;

  /// Trailer section title
  ///
  /// In en, this message translates to:
  /// **'Trailer'**
  String get trailer;

  /// Popularity label
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity;

  /// Adult content label
  ///
  /// In en, this message translates to:
  /// **'Adult Content'**
  String get adultContent;

  /// Yes option
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No option
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign in subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// Sign up link text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Create account button text
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Register screen title
  ///
  /// In en, this message translates to:
  /// **'Join Movie Discovery'**
  String get joinMovieDiscovery;

  /// Register screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Create your account to get started'**
  String get createAccountSubtitle;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Display name field label
  ///
  /// In en, this message translates to:
  /// **'Display Name (Optional)'**
  String get displayName;

  /// Email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Email format validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// Password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Password validation message for registration
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterPasswordForRegister;

  /// Password length validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Confirm password validation message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// Password mismatch validation message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Divider text between login options
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// Google sign in button text
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// Sign up prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Sign in prompt text
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Appearance section header
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Account section header
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// About section header
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Dark mode setting label
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Enabled status text
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// Disabled status text
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Ukrainian language option
  ///
  /// In en, this message translates to:
  /// **'Українська'**
  String get languageUkrainian;

  /// Language selection dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Account information menu item
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// Account information subtitle
  ///
  /// In en, this message translates to:
  /// **'View your profile details'**
  String get viewProfileDetails;

  /// Account details dialog content
  ///
  /// In en, this message translates to:
  /// **'Your account details are managed through Firebase Authentication.'**
  String get accountDetailsManaged;

  /// Account signed in message
  ///
  /// In en, this message translates to:
  /// **'Signed in with your Firebase account'**
  String get signedInWith;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Sign out button text
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Sign out menu item subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get signOutSubtitle;

  /// Sign out confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out? You will need to sign in again to access your account.'**
  String get signOutConfirmation;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// About dialog title
  ///
  /// In en, this message translates to:
  /// **'About Movie Discovery'**
  String get aboutMovieDiscovery;

  /// About dialog description
  ///
  /// In en, this message translates to:
  /// **'A modern Flutter application for discovering movies and TV shows.'**
  String get aboutDescription;

  /// Feature list item
  ///
  /// In en, this message translates to:
  /// **'Browse popular, top-rated, and upcoming movies'**
  String get featureBrowse;

  /// Feature list item
  ///
  /// In en, this message translates to:
  /// **'Search for your favorite movies'**
  String get featureSearch;

  /// Feature list item
  ///
  /// In en, this message translates to:
  /// **'Save movies to your favorites'**
  String get featureFavorites;

  /// Feature list item
  ///
  /// In en, this message translates to:
  /// **'Dark mode support'**
  String get featureDarkMode;

  /// TMDb attribution text
  ///
  /// In en, this message translates to:
  /// **'Powered by The Movie Database (TMDb) API'**
  String get poweredByTmdb;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Version information dialog title
  ///
  /// In en, this message translates to:
  /// **'Version Information'**
  String get versionInformation;

  /// Version row label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// Build row label
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get buildLabel;

  /// Flutter SDK row label
  ///
  /// In en, this message translates to:
  /// **'Flutter SDK'**
  String get flutterSdkLabel;

  /// Educational project description
  ///
  /// In en, this message translates to:
  /// **'Educational project for learning Flutter with Clean Architecture'**
  String get educationalProject;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
