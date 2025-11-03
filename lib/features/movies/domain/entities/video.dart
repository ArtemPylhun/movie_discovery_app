import 'package:equatable/equatable.dart';

class Video extends Equatable {
  const Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final bool official;
  final String publishedAt;

  bool get isYouTubeTrailer => site == 'YouTube' && type == 'Trailer';

  String get youtubeUrl => 'https://www.youtube.com/watch?v=$key';

  @override
  List<Object?> get props => [id, key, name, site, type, official, publishedAt];
}
