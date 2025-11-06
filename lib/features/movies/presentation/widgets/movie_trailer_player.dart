import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_discovery_app/core/di/injection.dart';
import 'package:movie_discovery_app/features/movies/domain/entities/video.dart';
import 'package:movie_discovery_app/features/movies/domain/usecases/get_movie_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Provider for movie videos
final movieVideosProvider =
    FutureProvider.family<List<Video>, int>((ref, movieId) async {
  final getMovieVideos = getIt<GetMovieVideos>();
  final result = await getMovieVideos(GetMovieVideosParams(movieId: movieId));

  return result.fold(
    (failure) => throw Exception(failure.message),
    (videos) => videos,
  );
});

class MovieTrailerPlayer extends ConsumerStatefulWidget {
  const MovieTrailerPlayer({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  ConsumerState<MovieTrailerPlayer> createState() => _MovieTrailerPlayerState();
}

class _MovieTrailerPlayerState extends ConsumerState<MovieTrailerPlayer> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initializePlayer(String videoKey) {
    _controller = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        hideControls: false,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
      ),
    )..addListener(() {
        if (_isPlayerReady && mounted) {
          setState(() {});
        }
      });
    _isPlayerReady = true;
  }

  @override
  Widget build(BuildContext context) {
    final videosAsync = ref.watch(movieVideosProvider(widget.movieId));

    return videosAsync.when(
      data: (videos) {
        // Filter for YouTube trailers only
        final youtubeTrailers =
            videos.where((video) => video.isYouTubeTrailer).toList();

        if (youtubeTrailers.isEmpty) {
          return _buildNoTrailerWidget(context);
        }

        // Get the first official trailer or just the first trailer
        final trailer = youtubeTrailers.firstWhere(
          (video) => video.official,
          orElse: () => youtubeTrailers.first,
        );

        // Initialize controller if not already done
        if (_controller == null) {
          _initializePlayer(trailer.key);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trailer',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Theme.of(context).primaryColor,
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
                bottomActions: [
                  const CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                      playedColor: Theme.of(context).primaryColor,
                      handleColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const RemainingDuration(),
                  const PlaybackSpeedButton(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              trailer.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        );
      },
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trailer',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      error: (error, stack) => _buildNoTrailerWidget(context),
    );
  }

  Widget _buildNoTrailerWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trailer',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_library_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 12),
                Text(
                  'No trailer available',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
