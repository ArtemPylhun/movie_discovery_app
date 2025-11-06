import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/video.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
class VideoModel with _$VideoModel {
  const factory VideoModel({
    required String id,
    required String key,
    required String name,
    required String site,
    required String type,
    required bool official,
    @JsonKey(name: 'published_at') required String publishedAt,
  }) = _VideoModel;

  const VideoModel._();

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Video toEntity() {
    return Video(
      id: id,
      key: key,
      name: name,
      site: site,
      type: type,
      official: official,
      publishedAt: publishedAt,
    );
  }
}

@freezed
class VideoListResponse with _$VideoListResponse {
  const factory VideoListResponse({
    required int id,
    required List<VideoModel> results,
  }) = _VideoListResponse;

  factory VideoListResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoListResponseFromJson(json);
}
