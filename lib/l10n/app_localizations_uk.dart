// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Кінодискавері';

  @override
  String get homeTitle => 'Кінодискавері';

  @override
  String get tabPopular => 'Популярні';

  @override
  String get tabTopRated => 'Топ рейтинг';

  @override
  String get tabUpcoming => 'Очікувані';

  @override
  String get tabFavorites => 'Улюблені';

  @override
  String get settings => 'Налаштування';

  @override
  String get searchMovies => 'Шукати фільми...';

  @override
  String get searchForMovies => 'Пошук фільмів';

  @override
  String noMoviesFound(String query) {
    return 'Не знайдено фільмів за запитом \"$query\"';
  }

  @override
  String get noPopularMovies => 'Не знайдено популярних фільмів';

  @override
  String get noTopRatedMovies => 'Не знайдено найрейтинговіших фільмів';

  @override
  String get noUpcomingMovies => 'Не знайдено очікуваних фільмів';

  @override
  String get noFavoriteMovies =>
      'У вас ще немає улюблених фільмів.\nПочніть додавати фільми до улюблених!';

  @override
  String get error => 'Помилка';

  @override
  String get errorOccurred => 'Ой! Щось пішло не так';

  @override
  String errorMessage(String message) {
    return 'Помилка: $message';
  }

  @override
  String get retry => 'Спробувати знову';

  @override
  String get loading => 'Завантаження...';

  @override
  String get movieDetailsTitle => 'Деталі фільму';

  @override
  String get overview => 'Огляд';

  @override
  String get noOverview => 'Огляд недоступний.';

  @override
  String get genres => 'Жанри';

  @override
  String get additionalInformation => 'Додаткова інформація';

  @override
  String get trailer => 'Трейлер';

  @override
  String get popularity => 'Популярність';

  @override
  String get adultContent => 'Для дорослих';

  @override
  String get yes => 'Так';

  @override
  String get no => 'Ні';

  @override
  String get signIn => 'Увійти';

  @override
  String get signInToContinue => 'Увійдіть, щоб продовжити';

  @override
  String get signUp => 'Реєстрація';

  @override
  String get createAccount => 'Створити обліковий запис';

  @override
  String get joinMovieDiscovery => 'Приєднатися до Кінодискавері';

  @override
  String get createAccountSubtitle => 'Створіть обліковий запис, щоб розпочати';

  @override
  String get email => 'Електронна пошта';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Підтвердіть пароль';

  @override
  String get displayName => 'Ім\'я (необов\'язково)';

  @override
  String get pleaseEnterEmail => 'Будь ласка, введіть електронну пошту';

  @override
  String get pleaseEnterValidEmail =>
      'Будь ласка, введіть дійсну електронну пошту';

  @override
  String get pleaseEnterPassword => 'Будь ласка, введіть пароль';

  @override
  String get pleaseEnterPasswordForRegister => 'Будь ласка, введіть пароль';

  @override
  String get passwordMinLength => 'Пароль має містити щонайменше 6 символів';

  @override
  String get pleaseConfirmPassword => 'Будь ласка, підтвердіть пароль';

  @override
  String get passwordsDoNotMatch => 'Паролі не збігаються';

  @override
  String get or => 'АБО';

  @override
  String get continueWithGoogle => 'Продовжити через Google';

  @override
  String get dontHaveAccount => 'Немає облікового запису? ';

  @override
  String get alreadyHaveAccount => 'Вже є обліковий запис? ';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get appearance => 'Зовнішній вигляд';

  @override
  String get account => 'Обліковий запис';

  @override
  String get about => 'Про додаток';

  @override
  String get darkMode => 'Темна тема';

  @override
  String get enabled => 'Увімкнено';

  @override
  String get disabled => 'Вимкнено';

  @override
  String get language => 'Мова';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get selectLanguage => 'Виберіть мову';

  @override
  String get accountInformation => 'Інформація про обліковий запис';

  @override
  String get viewProfileDetails => 'Переглянути деталі профілю';

  @override
  String get accountDetailsManaged =>
      'Деталі вашого облікового запису керуються через Firebase Authentication.';

  @override
  String get signedInWith => 'Увійшли через ваш обліковий запис Firebase';

  @override
  String get close => 'Закрити';

  @override
  String get signOut => 'Вийти';

  @override
  String get signOutSubtitle => 'Вийти з облікового запису';

  @override
  String get signOutConfirmation =>
      'Ви впевнені, що хочете вийти? Вам потрібно буде знову увійти, щоб отримати доступ до свого облікового запису.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get aboutMovieDiscovery => 'Про Кінодискавері';

  @override
  String get aboutDescription =>
      'Сучасний Flutter додаток для відкриття фільмів та серіалів.';

  @override
  String get featureBrowse =>
      'Переглядайте популярні, топові та очікувані фільми';

  @override
  String get featureSearch => 'Шукайте свої улюблені фільми';

  @override
  String get featureFavorites => 'Зберігайте фільми в улюблених';

  @override
  String get featureDarkMode => 'Підтримка темної теми';

  @override
  String get poweredByTmdb => 'Працює на базі The Movie Database (TMDb) API';

  @override
  String get version => 'Версія';

  @override
  String get versionInformation => 'Інформація про версію';

  @override
  String get versionLabel => 'Версія';

  @override
  String get buildLabel => 'Збірка';

  @override
  String get flutterSdkLabel => 'Flutter SDK';

  @override
  String get educationalProject =>
      'Освітній проєкт для вивчення Flutter з Clean Architecture';
}
