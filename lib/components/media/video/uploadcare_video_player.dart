import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/video/video_controls_overlay.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// All the data needed to create a better player controller and to play a video.
class VideoData {
  final VideoInfoEntity info;
  final double aspectRatio;
  final BetterPlayerDataSource dataSource;
  VideoData(this.info, this.aspectRatio, this.dataSource);
}

class VideoSetupManager {
  static Future<VideoData> getVideoData({required String videoUri}) async {
    VideoInfoEntity videoInfo =
        await UploadcareService.getVideoInfoRaw(videoUri);

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, videoInfo.url,
        cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true));

    double aspectRatio = videoInfo.width / videoInfo.height;

    return VideoData(videoInfo, aspectRatio, dataSource);
  }

  static BetterPlayerController initializeController(
      {required BetterPlayerDataSource dataSource,
      required double aspectRatio,
      Widget Function(BetterPlayerController)? customControlsBuilder,
      bool autoPlay = false,
      bool autoLoop = false}) {
    return BetterPlayerController(
        BetterPlayerConfiguration(
          autoDispose: false,
          fit: BoxFit.fill,
          aspectRatio: aspectRatio,
          autoPlay: autoPlay,
          looping: autoLoop,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            playerTheme: BetterPlayerTheme.custom,
            customControlsBuilder: customControlsBuilder,
          ),
        ),
        betterPlayerDataSource: dataSource);
  }

  static Future<double> getAspectRatio(String videoUri) async {
    final info = await UploadcareService.getVideoInfoRaw(videoUri);
    return info.width / info.height;
  }

  static Future<Duration> openFullScreenVideoPlayer({
    required BuildContext context,
    required String videoUri,
    double? aspectRatio,
    bool autoPlay = false,
    bool autoLoop = false,
    Duration? startPosition,
  }) async {
    final _aspect = aspectRatio ?? await getAspectRatio(videoUri);

    final positionOnExit = await Navigator.push<Duration?>(
        context,
        CupertinoPageRoute(
            fullscreenDialog: _aspect < 1,
            builder: (context) => Container(
                  color: Styles.black,
                  child: SizedBox.expand(
                    child: RotatedBox(
                      quarterTurns: _aspect < 1 ? 0 : 1,
                      child: FullScreenUploadcareVideoPlayer(
                          videoUri: videoUri,
                          autoPlay: autoPlay,
                          autoLoop: autoLoop,
                          startPosition: startPosition),
                    ),
                  ),
                )));
    return positionOnExit ?? Duration.zero;
  }
}

class FullScreenUploadcareVideoPlayer extends StatefulWidget {
  final String videoUri;
  final bool autoPlay;
  final bool autoLoop;
  final Duration? startPosition;
  FullScreenUploadcareVideoPlayer(
      {required this.videoUri,
      this.autoLoop = false,
      this.autoPlay = false,
      this.startPosition});

  @override
  _FullScreenUploadcareVideoPlayerState createState() =>
      _FullScreenUploadcareVideoPlayerState();
}

class _FullScreenUploadcareVideoPlayerState
    extends State<FullScreenUploadcareVideoPlayer> {
  BetterPlayerController? _controller;
  String? _errorMessage;
  VideoData? _videoData;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    _initializeVideo().then((_) {
      setState(() {});
    });
  }

  Future<void> _initializeVideo() async {
    try {
      _videoData =
          await VideoSetupManager.getVideoData(videoUri: widget.videoUri);
      if (_videoData == null) {
        throw Exception('Unable to get data for this video.');
      }

      _controller = VideoSetupManager.initializeController(
          dataSource: _videoData!.dataSource,
          aspectRatio: _videoData!.aspectRatio,
          autoLoop: widget.autoLoop,
          autoPlay: widget.autoPlay,
          customControlsBuilder: (controller) {
            return FullVideoControls(
              controller: controller,
              isFullScreen: true,
              showEnterExitFullScreen: true,
              enterExitFullScreen: () async {
                final position =
                    await controller.videoPlayerController!.position;
                _exitFullScreenPlayer(position);
              },
              duration: Duration(milliseconds: _videoData!.info.duration),
            );
          });

      if (_controller!.isVideoInitialized() ?? false) {
        throw Exception(
            'The video did not start correctly. Please check the file url..');
      } else {
        if (widget.startPosition != null) {
          _controller!.seekTo(widget.startPosition!);
        }
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _exitFullScreenPlayer(Duration? position) {
    context.pop(result: position);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Utils.textNotNull(_errorMessage)
        ? Center(
            child: MyText(
              _errorMessage!,
              color: Styles.errorRed,
            ),
          )
        : _initialized
            ? BetterPlayer(
                controller: _controller!,
              )
            : LoadingCircle();
  }
}

/// For displaying video within the flow of content. Not full screen.
class InlineUploadcareVideoPlayer extends StatefulWidget {
  final Key? key;
  final String videoUri;
  final bool autoPlay;
  final bool autoLoop;
  final bool isFullScreen;

  /// Seek to this point immediately.
  final Duration? startPosition;
  InlineUploadcareVideoPlayer(
      {this.key,
      required this.videoUri,
      this.autoLoop = false,
      this.autoPlay = false,
      this.startPosition,
      this.isFullScreen = false});

  @override
  _InlineUploadcareVideoPlayerState createState() =>
      _InlineUploadcareVideoPlayerState();
}

class _InlineUploadcareVideoPlayerState
    extends State<InlineUploadcareVideoPlayer> {
  BetterPlayerController? _controller;
  String? _errorMessage;
  VideoData? _videoData;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo().then((_) {
      setState(() {});
    });
  }

  // Calls Uploadcare API and gets back a full url that the video player can use to play the video.
  Future<void> _initializeVideo() async {
    try {
      _videoData =
          await VideoSetupManager.getVideoData(videoUri: widget.videoUri);
      if (_videoData == null) {
        throw Exception('Unable to get data for this video.');
      }
      final showFullControls =
          widget.isFullScreen || _videoData!.aspectRatio >= 1;

      _controller = VideoSetupManager.initializeController(
          dataSource: _videoData!.dataSource,
          aspectRatio: _videoData!.aspectRatio,
          customControlsBuilder: (controller) {
            return showFullControls
                ? FullVideoControls(
                    controller: controller,
                    isFullScreen: widget.isFullScreen,
                    showEnterExitFullScreen: showFullControls,
                    enterExitFullScreen: widget.isFullScreen
                        ? () async {
                            final position = await _controller!
                                .videoPlayerController!.position;
                            _exitFullScreenPlayer(position);
                          }
                        : _enterFullScreen,
                    duration: Duration(milliseconds: _videoData!.info.duration),
                  )
                : MinimalVideoControls(
                    controller: controller,
                    enterFullScreen: _enterFullScreen,
                  );
          });

      if (_controller!.isVideoInitialized() ?? false) {
        throw Exception(
            'The video did not start correctly. Please check the file url..');
      } else {
        if (widget.startPosition != null) {
          _controller!.seekTo(widget.startPosition!);
        }
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _enterFullScreen() async {
    final startPosition = await _controller!.videoPlayerController!.position;

    final positionWhenClosed =
        await VideoSetupManager.openFullScreenVideoPlayer(
            context: context,
            videoUri: widget.videoUri,
            aspectRatio: _videoData!.aspectRatio,
            startPosition: startPosition);
    _controller!.seekTo(positionWhenClosed);
  }

  void _exitFullScreenPlayer(Duration? position) {
    context.pop(result: position);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Utils.textNotNull(_errorMessage)
        ? Center(
            child: MyText(
              _errorMessage!,
              color: Styles.errorRed,
            ),
          )
        : _initialized
            ? AspectRatio(
                aspectRatio: _videoData!.aspectRatio,
                child: BetterPlayer(
                  controller: _controller!,
                ),
              )
            : LoadingCircle();
  }
}
