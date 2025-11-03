// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return _VideoModel.fromJson(json);
}

/// @nodoc
mixin _$VideoModel {
  String get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get site => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get official => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_at')
  String get publishedAt => throw _privateConstructorUsedError;

  /// Serializes this VideoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoModelCopyWith<VideoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoModelCopyWith<$Res> {
  factory $VideoModelCopyWith(
          VideoModel value, $Res Function(VideoModel) then) =
      _$VideoModelCopyWithImpl<$Res, VideoModel>;
  @useResult
  $Res call(
      {String id,
      String key,
      String name,
      String site,
      String type,
      bool official,
      @JsonKey(name: 'published_at') String publishedAt});
}

/// @nodoc
class _$VideoModelCopyWithImpl<$Res, $Val extends VideoModel>
    implements $VideoModelCopyWith<$Res> {
  _$VideoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? site = null,
    Object? type = null,
    Object? official = null,
    Object? publishedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      site: null == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      official: null == official
          ? _value.official
          : official // ignore: cast_nullable_to_non_nullable
              as bool,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoModelImplCopyWith<$Res>
    implements $VideoModelCopyWith<$Res> {
  factory _$$VideoModelImplCopyWith(
          _$VideoModelImpl value, $Res Function(_$VideoModelImpl) then) =
      __$$VideoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String key,
      String name,
      String site,
      String type,
      bool official,
      @JsonKey(name: 'published_at') String publishedAt});
}

/// @nodoc
class __$$VideoModelImplCopyWithImpl<$Res>
    extends _$VideoModelCopyWithImpl<$Res, _$VideoModelImpl>
    implements _$$VideoModelImplCopyWith<$Res> {
  __$$VideoModelImplCopyWithImpl(
      _$VideoModelImpl _value, $Res Function(_$VideoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? site = null,
    Object? type = null,
    Object? official = null,
    Object? publishedAt = null,
  }) {
    return _then(_$VideoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      site: null == site
          ? _value.site
          : site // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      official: null == official
          ? _value.official
          : official // ignore: cast_nullable_to_non_nullable
              as bool,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoModelImpl extends _VideoModel {
  const _$VideoModelImpl(
      {required this.id,
      required this.key,
      required this.name,
      required this.site,
      required this.type,
      required this.official,
      @JsonKey(name: 'published_at') required this.publishedAt})
      : super._();

  factory _$VideoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String key;
  @override
  final String name;
  @override
  final String site;
  @override
  final String type;
  @override
  final bool official;
  @override
  @JsonKey(name: 'published_at')
  final String publishedAt;

  @override
  String toString() {
    return 'VideoModel(id: $id, key: $key, name: $name, site: $site, type: $type, official: $official, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.site, site) || other.site == site) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.official, official) ||
                other.official == official) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, key, name, site, type, official, publishedAt);

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoModelImplCopyWith<_$VideoModelImpl> get copyWith =>
      __$$VideoModelImplCopyWithImpl<_$VideoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoModelImplToJson(
      this,
    );
  }
}

abstract class _VideoModel extends VideoModel {
  const factory _VideoModel(
          {required final String id,
          required final String key,
          required final String name,
          required final String site,
          required final String type,
          required final bool official,
          @JsonKey(name: 'published_at') required final String publishedAt}) =
      _$VideoModelImpl;
  const _VideoModel._() : super._();

  factory _VideoModel.fromJson(Map<String, dynamic> json) =
      _$VideoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get key;
  @override
  String get name;
  @override
  String get site;
  @override
  String get type;
  @override
  bool get official;
  @override
  @JsonKey(name: 'published_at')
  String get publishedAt;

  /// Create a copy of VideoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoModelImplCopyWith<_$VideoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoListResponse _$VideoListResponseFromJson(Map<String, dynamic> json) {
  return _VideoListResponse.fromJson(json);
}

/// @nodoc
mixin _$VideoListResponse {
  int get id => throw _privateConstructorUsedError;
  List<VideoModel> get results => throw _privateConstructorUsedError;

  /// Serializes this VideoListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoListResponseCopyWith<VideoListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoListResponseCopyWith<$Res> {
  factory $VideoListResponseCopyWith(
          VideoListResponse value, $Res Function(VideoListResponse) then) =
      _$VideoListResponseCopyWithImpl<$Res, VideoListResponse>;
  @useResult
  $Res call({int id, List<VideoModel> results});
}

/// @nodoc
class _$VideoListResponseCopyWithImpl<$Res, $Val extends VideoListResponse>
    implements $VideoListResponseCopyWith<$Res> {
  _$VideoListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<VideoModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoListResponseImplCopyWith<$Res>
    implements $VideoListResponseCopyWith<$Res> {
  factory _$$VideoListResponseImplCopyWith(_$VideoListResponseImpl value,
          $Res Function(_$VideoListResponseImpl) then) =
      __$$VideoListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, List<VideoModel> results});
}

/// @nodoc
class __$$VideoListResponseImplCopyWithImpl<$Res>
    extends _$VideoListResponseCopyWithImpl<$Res, _$VideoListResponseImpl>
    implements _$$VideoListResponseImplCopyWith<$Res> {
  __$$VideoListResponseImplCopyWithImpl(_$VideoListResponseImpl _value,
      $Res Function(_$VideoListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? results = null,
  }) {
    return _then(_$VideoListResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<VideoModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoListResponseImpl implements _VideoListResponse {
  const _$VideoListResponseImpl(
      {required this.id, required final List<VideoModel> results})
      : _results = results;

  factory _$VideoListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoListResponseImplFromJson(json);

  @override
  final int id;
  final List<VideoModel> _results;
  @override
  List<VideoModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'VideoListResponse(id: $id, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoListResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_results));

  /// Create a copy of VideoListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoListResponseImplCopyWith<_$VideoListResponseImpl> get copyWith =>
      __$$VideoListResponseImplCopyWithImpl<_$VideoListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoListResponseImplToJson(
      this,
    );
  }
}

abstract class _VideoListResponse implements VideoListResponse {
  const factory _VideoListResponse(
      {required final int id,
      required final List<VideoModel> results}) = _$VideoListResponseImpl;

  factory _VideoListResponse.fromJson(Map<String, dynamic> json) =
      _$VideoListResponseImpl.fromJson;

  @override
  int get id;
  @override
  List<VideoModel> get results;

  /// Create a copy of VideoListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoListResponseImplCopyWith<_$VideoListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
