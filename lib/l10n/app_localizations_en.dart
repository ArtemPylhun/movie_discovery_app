// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Movie Discovery';

  @override
  String get homeTitle => 'Movie Discovery';

  @override
  String get tabPopular => 'Popular';

  @override
  String get tabTopRated => 'Top Rated';

  @override
  String get tabUpcoming => 'Upcoming';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get searchMovies => 'Search movies...';

  @override
  String get searchForMovies => 'Search for movies';

  @override
  String noMoviesFound(String query) {
    return 'No movies found for \"$query\"';
  }

  @override
  String get noPopularMovies => 'No popular movies found';

  @override
  String get noTopRatedMovies => 'No top rated movies found';

  @override
  String get noUpcomingMovies => 'No upcoming movies found';

  @override
  String get noFavoriteMovies =>
      'No favorite movies yet.\nStart adding movies to your favorites!';

  @override
  String get error => 'Error';

  @override
  String get errorOccurred => 'Oops! Something went wrong';

  @override
  String errorMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get movieDetailsTitle => 'Movie Details';

  @override
  String get overview => 'Overview';

  @override
  String get noOverview => 'No overview available.';

  @override
  String get genres => 'Genres';

  @override
  String get additionalInformation => 'Additional Information';

  @override
  String get trailer => 'Trailer';

  @override
  String get popularity => 'Popularity';

  @override
  String get adultContent => 'Adult Content';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get signUp => 'Sign Up';

  @override
  String get createAccount => 'Create Account';

  @override
  String get joinMovieDiscovery => 'Join Movie Discovery';

  @override
  String get createAccountSubtitle => 'Create your account to get started';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get displayName => 'Display Name (Optional)';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get pleaseEnterPasswordForRegister => 'Please enter a password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get pleaseConfirmPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get or => 'OR';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get account => 'Account';

  @override
  String get about => 'About';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get viewProfileDetails => 'View your profile details';

  @override
  String get accountDetailsManaged =>
      'Your account details are managed through Firebase Authentication.';

  @override
  String get signedInWith => 'Signed in with your Firebase account';

  @override
  String get close => 'Close';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutSubtitle => 'Sign out of your account';

  @override
  String get signOutConfirmation =>
      'Are you sure you want to sign out? You will need to sign in again to access your account.';

  @override
  String get cancel => 'Cancel';

  @override
  String get aboutMovieDiscovery => 'About Movie Discovery';

  @override
  String get aboutDescription =>
      'A modern Flutter application for discovering movies and TV shows.';

  @override
  String get featureBrowse => 'Browse popular, top-rated, and upcoming movies';

  @override
  String get featureSearch => 'Search for your favorite movies';

  @override
  String get featureFavorites => 'Save movies to your favorites';

  @override
  String get featureDarkMode => 'Dark mode support';

  @override
  String get poweredByTmdb => 'Powered by The Movie Database (TMDb) API';

  @override
  String get version => 'Version';

  @override
  String get versionInformation => 'Version Information';

  @override
  String get versionLabel => 'Version';

  @override
  String get buildLabel => 'Build';

  @override
  String get flutterSdkLabel => 'Flutter SDK';

  @override
  String get educationalProject =>
      'Educational project for learning Flutter with Clean Architecture';
}
