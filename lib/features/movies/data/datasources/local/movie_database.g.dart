// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// ignore_for_file: type=lint
class $MoviesTable extends Movies with TableInfo<$MoviesTable, Movie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
      'backdrop_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _voteCountMeta =
      const VerificationMeta('voteCount');
  @override
  late final GeneratedColumn<int> voteCount = GeneratedColumn<int>(
      'vote_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genreIdsMeta =
      const VerificationMeta('genreIds');
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
      'genre_ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _popularityMeta =
      const VerificationMeta('popularity');
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
      'popularity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _adultMeta = const VerificationMeta('adult');
  @override
  late final GeneratedColumn<bool> adult = GeneratedColumn<bool>(
      'adult', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("adult" IN (0, 1))'));
  static const VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  @override
  late final GeneratedColumn<String> originalLanguage = GeneratedColumn<String>(
      'original_language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originalTitleMeta =
      const VerificationMeta('originalTitle');
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
      'original_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        releaseDate,
        genreIds,
        popularity,
        adult,
        originalLanguage,
        originalTitle,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movies';
  @override
  VerificationContext validateIntegrity(Insertable<Movie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path']!, _backdropPathMeta));
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('vote_count')) {
      context.handle(_voteCountMeta,
          voteCount.isAcceptableOrUnknown(data['vote_count']!, _voteCountMeta));
    } else if (isInserting) {
      context.missing(_voteCountMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('genre_ids')) {
      context.handle(_genreIdsMeta,
          genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta));
    } else if (isInserting) {
      context.missing(_genreIdsMeta);
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity']!, _popularityMeta));
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('adult')) {
      context.handle(
          _adultMeta, adult.isAcceptableOrUnknown(data['adult']!, _adultMeta));
    } else if (isInserting) {
      context.missing(_adultMeta);
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language']!, _originalLanguageMeta));
    } else if (isInserting) {
      context.missing(_originalLanguageMeta);
    }
    if (data.containsKey('original_title')) {
      context.handle(
          _originalTitleMeta,
          originalTitle.isAcceptableOrUnknown(
              data['original_title']!, _originalTitleMeta));
    } else if (isInserting) {
      context.missing(_originalTitleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Movie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Movie(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview'])!,
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path']),
      backdropPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_path']),
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      voteCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vote_count'])!,
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date'])!,
      genreIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre_ids'])!,
      popularity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}popularity'])!,
      adult: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}adult'])!,
      originalLanguage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_language'])!,
      originalTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}original_title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MoviesTable createAlias(String alias) {
    return $MoviesTable(attachedDatabase, alias);
  }
}

class Movie extends DataClass implements Insertable<Movie> {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final String genreIds;
  final double popularity;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Movie(
      {required this.id,
      required this.title,
      required this.overview,
      this.posterPath,
      this.backdropPath,
      required this.voteAverage,
      required this.voteCount,
      required this.releaseDate,
      required this.genreIds,
      required this.popularity,
      required this.adult,
      required this.originalLanguage,
      required this.originalTitle,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['overview'] = Variable<String>(overview);
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    map['vote_average'] = Variable<double>(voteAverage);
    map['vote_count'] = Variable<int>(voteCount);
    map['release_date'] = Variable<String>(releaseDate);
    map['genre_ids'] = Variable<String>(genreIds);
    map['popularity'] = Variable<double>(popularity);
    map['adult'] = Variable<bool>(adult);
    map['original_language'] = Variable<String>(originalLanguage);
    map['original_title'] = Variable<String>(originalTitle);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MoviesCompanion toCompanion(bool nullToAbsent) {
    return MoviesCompanion(
      id: Value(id),
      title: Value(title),
      overview: Value(overview),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      voteAverage: Value(voteAverage),
      voteCount: Value(voteCount),
      releaseDate: Value(releaseDate),
      genreIds: Value(genreIds),
      popularity: Value(popularity),
      adult: Value(adult),
      originalLanguage: Value(originalLanguage),
      originalTitle: Value(originalTitle),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Movie(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      overview: serializer.fromJson<String>(json['overview']),
      posterPath: serializer.fromJson<String?>(json['posterPath']),
      backdropPath: serializer.fromJson<String?>(json['backdropPath']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      voteCount: serializer.fromJson<int>(json['voteCount']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      genreIds: serializer.fromJson<String>(json['genreIds']),
      popularity: serializer.fromJson<double>(json['popularity']),
      adult: serializer.fromJson<bool>(json['adult']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String>(json['originalTitle']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'overview': serializer.toJson<String>(overview),
      'posterPath': serializer.toJson<String?>(posterPath),
      'backdropPath': serializer.toJson<String?>(backdropPath),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'voteCount': serializer.toJson<int>(voteCount),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'genreIds': serializer.toJson<String>(genreIds),
      'popularity': serializer.toJson<double>(popularity),
      'adult': serializer.toJson<bool>(adult),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'originalTitle': serializer.toJson<String>(originalTitle),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Movie copyWith(
          {int? id,
          String? title,
          String? overview,
          Value<String?> posterPath = const Value.absent(),
          Value<String?> backdropPath = const Value.absent(),
          double? voteAverage,
          int? voteCount,
          String? releaseDate,
          String? genreIds,
          double? popularity,
          bool? adult,
          String? originalLanguage,
          String? originalTitle,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Movie(
        id: id ?? this.id,
        title: title ?? this.title,
        overview: overview ?? this.overview,
        posterPath: posterPath.present ? posterPath.value : this.posterPath,
        backdropPath:
            backdropPath.present ? backdropPath.value : this.backdropPath,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        releaseDate: releaseDate ?? this.releaseDate,
        genreIds: genreIds ?? this.genreIds,
        popularity: popularity ?? this.popularity,
        adult: adult ?? this.adult,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Movie copyWithCompanion(MoviesCompanion data) {
    return Movie(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      overview: data.overview.present ? data.overview.value : this.overview,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      backdropPath: data.backdropPath.present
          ? data.backdropPath.value
          : this.backdropPath,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
      voteCount: data.voteCount.present ? data.voteCount.value : this.voteCount,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      popularity:
          data.popularity.present ? data.popularity.value : this.popularity,
      adult: data.adult.present ? data.adult.value : this.adult,
      originalLanguage: data.originalLanguage.present
          ? data.originalLanguage.value
          : this.originalLanguage,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Movie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('genreIds: $genreIds, ')
          ..write('popularity: $popularity, ')
          ..write('adult: $adult, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      overview,
      posterPath,
      backdropPath,
      voteAverage,
      voteCount,
      releaseDate,
      genreIds,
      popularity,
      adult,
      originalLanguage,
      originalTitle,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          other.id == this.id &&
          other.title == this.title &&
          other.overview == this.overview &&
          other.posterPath == this.posterPath &&
          other.backdropPath == this.backdropPath &&
          other.voteAverage == this.voteAverage &&
          other.voteCount == this.voteCount &&
          other.releaseDate == this.releaseDate &&
          other.genreIds == this.genreIds &&
          other.popularity == this.popularity &&
          other.adult == this.adult &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MoviesCompanion extends UpdateCompanion<Movie> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> overview;
  final Value<String?> posterPath;
  final Value<String?> backdropPath;
  final Value<double> voteAverage;
  final Value<int> voteCount;
  final Value<String> releaseDate;
  final Value<String> genreIds;
  final Value<double> popularity;
  final Value<bool> adult;
  final Value<String> originalLanguage;
  final Value<String> originalTitle;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MoviesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.overview = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.voteCount = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.popularity = const Value.absent(),
    this.adult = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MoviesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String overview,
    this.posterPath = const Value.absent(),
    this.backdropPath = const Value.absent(),
    required double voteAverage,
    required int voteCount,
    required String releaseDate,
    required String genreIds,
    required double popularity,
    required bool adult,
    required String originalLanguage,
    required String originalTitle,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : title = Value(title),
        overview = Value(overview),
        voteAverage = Value(voteAverage),
        voteCount = Value(voteCount),
        releaseDate = Value(releaseDate),
        genreIds = Value(genreIds),
        popularity = Value(popularity),
        adult = Value(adult),
        originalLanguage = Value(originalLanguage),
        originalTitle = Value(originalTitle);
  static Insertable<Movie> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? overview,
    Expression<String>? posterPath,
    Expression<String>? backdropPath,
    Expression<double>? voteAverage,
    Expression<int>? voteCount,
    Expression<String>? releaseDate,
    Expression<String>? genreIds,
    Expression<double>? popularity,
    Expression<bool>? adult,
    Expression<String>? originalLanguage,
    Expression<String>? originalTitle,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (overview != null) 'overview': overview,
      if (posterPath != null) 'poster_path': posterPath,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (voteCount != null) 'vote_count': voteCount,
      if (releaseDate != null) 'release_date': releaseDate,
      if (genreIds != null) 'genre_ids': genreIds,
      if (popularity != null) 'popularity': popularity,
      if (adult != null) 'adult': adult,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MoviesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? overview,
      Value<String?>? posterPath,
      Value<String?>? backdropPath,
      Value<double>? voteAverage,
      Value<int>? voteCount,
      Value<String>? releaseDate,
      Value<String>? genreIds,
      Value<double>? popularity,
      Value<bool>? adult,
      Value<String>? originalLanguage,
      Value<String>? originalTitle,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return MoviesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
      adult: adult ?? this.adult,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (voteCount.present) {
      map['vote_count'] = Variable<int>(voteCount.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (adult.present) {
      map['adult'] = Variable<bool>(adult.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('overview: $overview, ')
          ..write('posterPath: $posterPath, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('voteCount: $voteCount, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('genreIds: $genreIds, ')
          ..write('popularity: $popularity, ')
          ..write('adult: $adult, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta =
      const VerificationMeta('movieId');
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
      'movie_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES movies (id)'));
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [movieId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(_movieIdMeta,
          movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta));
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {movieId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      movieId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}movie_id'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int movieId;
  final DateTime addedAt;
  const Favorite({required this.movieId, required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<int>(movieId);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      movieId: Value(movieId),
      addedAt: Value(addedAt),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      movieId: serializer.fromJson<int>(json['movieId']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<int>(movieId),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  Favorite copyWith({int? movieId, DateTime? addedAt}) => Favorite(
        movieId: movieId ?? this.movieId,
        addedAt: addedAt ?? this.addedAt,
      );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('movieId: $movieId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(movieId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.movieId == this.movieId &&
          other.addedAt == this.addedAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> movieId;
  final Value<DateTime> addedAt;
  const FavoritesCompanion({
    this.movieId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.movieId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  static Insertable<Favorite> custom({
    Expression<int>? movieId,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoritesCompanion copyWith({Value<int>? movieId, Value<DateTime>? addedAt}) {
    return FavoritesCompanion(
      movieId: movieId ?? this.movieId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('movieId: $movieId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$MovieDatabase extends GeneratedDatabase {
  _$MovieDatabase(QueryExecutor e) : super(e);
  $MovieDatabaseManager get managers => $MovieDatabaseManager(this);
  late final $MoviesTable movies = $MoviesTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movies, favorites];
}

typedef $$MoviesTableCreateCompanionBuilder = MoviesCompanion Function({
  Value<int> id,
  required String title,
  required String overview,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  required double voteAverage,
  required int voteCount,
  required String releaseDate,
  required String genreIds,
  required double popularity,
  required bool adult,
  required String originalLanguage,
  required String originalTitle,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$MoviesTableUpdateCompanionBuilder = MoviesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> overview,
  Value<String?> posterPath,
  Value<String?> backdropPath,
  Value<double> voteAverage,
  Value<int> voteCount,
  Value<String> releaseDate,
  Value<String> genreIds,
  Value<double> popularity,
  Value<bool> adult,
  Value<String> originalLanguage,
  Value<String> originalTitle,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$MoviesTableReferences
    extends BaseReferences<_$MovieDatabase, $MoviesTable, Movie> {
  $$MoviesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FavoritesTable, List<Favorite>>
      _favoritesRefsTable(_$MovieDatabase db) => MultiTypedResultKey.fromTable(
          db.favorites,
          aliasName: $_aliasNameGenerator(db.movies.id, db.favorites.movieId));

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager($_db, $_db.favorites)
        .filter((f) => f.movieId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MoviesTableFilterComposer
    extends Composer<_$MovieDatabase, $MoviesTable> {
  $$MoviesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get overview => $composableBuilder(
      column: $table.overview, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backdropPath => $composableBuilder(
      column: $table.backdropPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get voteCount => $composableBuilder(
      column: $table.voteCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get popularity => $composableBuilder(
      column: $table.popularity, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get adult => $composableBuilder(
      column: $table.adult, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalLanguage => $composableBuilder(
      column: $table.originalLanguage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalTitle => $composableBuilder(
      column: $table.originalTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> favoritesRefs(
      Expression<bool> Function($$FavoritesTableFilterComposer f) f) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favorites,
        getReferencedColumn: (t) => t.movieId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoritesTableFilterComposer(
              $db: $db,
              $table: $db.favorites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MoviesTableOrderingComposer
    extends Composer<_$MovieDatabase, $MoviesTable> {
  $$MoviesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get overview => $composableBuilder(
      column: $table.overview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backdropPath => $composableBuilder(
      column: $table.backdropPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get voteCount => $composableBuilder(
      column: $table.voteCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get popularity => $composableBuilder(
      column: $table.popularity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get adult => $composableBuilder(
      column: $table.adult, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalLanguage => $composableBuilder(
      column: $table.originalLanguage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalTitle => $composableBuilder(
      column: $table.originalTitle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MoviesTableAnnotationComposer
    extends Composer<_$MovieDatabase, $MoviesTable> {
  $$MoviesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => column);

  GeneratedColumn<String> get backdropPath => $composableBuilder(
      column: $table.backdropPath, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => column);

  GeneratedColumn<int> get voteCount =>
      $composableBuilder(column: $table.voteCount, builder: (column) => column);

  GeneratedColumn<String> get releaseDate => $composableBuilder(
      column: $table.releaseDate, builder: (column) => column);

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<double> get popularity => $composableBuilder(
      column: $table.popularity, builder: (column) => column);

  GeneratedColumn<bool> get adult =>
      $composableBuilder(column: $table.adult, builder: (column) => column);

  GeneratedColumn<String> get originalLanguage => $composableBuilder(
      column: $table.originalLanguage, builder: (column) => column);

  GeneratedColumn<String> get originalTitle => $composableBuilder(
      column: $table.originalTitle, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> favoritesRefs<T extends Object>(
      Expression<T> Function($$FavoritesTableAnnotationComposer a) f) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.favorites,
        getReferencedColumn: (t) => t.movieId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FavoritesTableAnnotationComposer(
              $db: $db,
              $table: $db.favorites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MoviesTableTableManager extends RootTableManager<
    _$MovieDatabase,
    $MoviesTable,
    Movie,
    $$MoviesTableFilterComposer,
    $$MoviesTableOrderingComposer,
    $$MoviesTableAnnotationComposer,
    $$MoviesTableCreateCompanionBuilder,
    $$MoviesTableUpdateCompanionBuilder,
    (Movie, $$MoviesTableReferences),
    Movie,
    PrefetchHooks Function({bool favoritesRefs})> {
  $$MoviesTableTableManager(_$MovieDatabase db, $MoviesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoviesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoviesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoviesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> overview = const Value.absent(),
            Value<String?> posterPath = const Value.absent(),
            Value<String?> backdropPath = const Value.absent(),
            Value<double> voteAverage = const Value.absent(),
            Value<int> voteCount = const Value.absent(),
            Value<String> releaseDate = const Value.absent(),
            Value<String> genreIds = const Value.absent(),
            Value<double> popularity = const Value.absent(),
            Value<bool> adult = const Value.absent(),
            Value<String> originalLanguage = const Value.absent(),
            Value<String> originalTitle = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MoviesCompanion(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            releaseDate: releaseDate,
            genreIds: genreIds,
            popularity: popularity,
            adult: adult,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String overview,
            Value<String?> posterPath = const Value.absent(),
            Value<String?> backdropPath = const Value.absent(),
            required double voteAverage,
            required int voteCount,
            required String releaseDate,
            required String genreIds,
            required double popularity,
            required bool adult,
            required String originalLanguage,
            required String originalTitle,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MoviesCompanion.insert(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            releaseDate: releaseDate,
            genreIds: genreIds,
            popularity: popularity,
            adult: adult,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MoviesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({favoritesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (favoritesRefs) db.favorites],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (favoritesRefs)
                    await $_getPrefetchedData<Movie, $MoviesTable, Favorite>(
                        currentTable: table,
                        referencedTable:
                            $$MoviesTableReferences._favoritesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MoviesTableReferences(db, table, p0)
                                .favoritesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.movieId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MoviesTableProcessedTableManager = ProcessedTableManager<
    _$MovieDatabase,
    $MoviesTable,
    Movie,
    $$MoviesTableFilterComposer,
    $$MoviesTableOrderingComposer,
    $$MoviesTableAnnotationComposer,
    $$MoviesTableCreateCompanionBuilder,
    $$MoviesTableUpdateCompanionBuilder,
    (Movie, $$MoviesTableReferences),
    Movie,
    PrefetchHooks Function({bool favoritesRefs})>;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  Value<int> movieId,
  Value<DateTime> addedAt,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<int> movieId,
  Value<DateTime> addedAt,
});

final class $$FavoritesTableReferences
    extends BaseReferences<_$MovieDatabase, $FavoritesTable, Favorite> {
  $$FavoritesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MoviesTable _movieIdTable(_$MovieDatabase db) => db.movies
      .createAlias($_aliasNameGenerator(db.favorites.movieId, db.movies.id));

  $$MoviesTableProcessedTableManager get movieId {
    final $_column = $_itemColumn<int>('movie_id')!;

    final manager = $$MoviesTableTableManager($_db, $_db.movies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_movieIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FavoritesTableFilterComposer
    extends Composer<_$MovieDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));

  $$MoviesTableFilterComposer get movieId {
    final $$MoviesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.movieId,
        referencedTable: $db.movies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MoviesTableFilterComposer(
              $db: $db,
              $table: $db.movies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$MovieDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));

  $$MoviesTableOrderingComposer get movieId {
    final $$MoviesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.movieId,
        referencedTable: $db.movies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MoviesTableOrderingComposer(
              $db: $db,
              $table: $db.movies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$MovieDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$MoviesTableAnnotationComposer get movieId {
    final $$MoviesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.movieId,
        referencedTable: $db.movies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MoviesTableAnnotationComposer(
              $db: $db,
              $table: $db.movies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FavoritesTableTableManager extends RootTableManager<
    _$MovieDatabase,
    $FavoritesTable,
    Favorite,
    $$FavoritesTableFilterComposer,
    $$FavoritesTableOrderingComposer,
    $$FavoritesTableAnnotationComposer,
    $$FavoritesTableCreateCompanionBuilder,
    $$FavoritesTableUpdateCompanionBuilder,
    (Favorite, $$FavoritesTableReferences),
    Favorite,
    PrefetchHooks Function({bool movieId})> {
  $$FavoritesTableTableManager(_$MovieDatabase db, $FavoritesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
          }) =>
              FavoritesCompanion(
            movieId: movieId,
            addedAt: addedAt,
          ),
          createCompanionCallback: ({
            Value<int> movieId = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
          }) =>
              FavoritesCompanion.insert(
            movieId: movieId,
            addedAt: addedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FavoritesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({movieId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (movieId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.movieId,
                    referencedTable:
                        $$FavoritesTableReferences._movieIdTable(db),
                    referencedColumn:
                        $$FavoritesTableReferences._movieIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FavoritesTableProcessedTableManager = ProcessedTableManager<
    _$MovieDatabase,
    $FavoritesTable,
    Favorite,
    $$FavoritesTableFilterComposer,
    $$FavoritesTableOrderingComposer,
    $$FavoritesTableAnnotationComposer,
    $$FavoritesTableCreateCompanionBuilder,
    $$FavoritesTableUpdateCompanionBuilder,
    (Favorite, $$FavoritesTableReferences),
    Favorite,
    PrefetchHooks Function({bool movieId})>;

class $MovieDatabaseManager {
  final _$MovieDatabase _db;
  $MovieDatabaseManager(this._db);
  $$MoviesTableTableManager get movies =>
      $$MoviesTableTableManager(_db, _db.movies);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
}
