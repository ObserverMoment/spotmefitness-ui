import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/video/video_controls_overlay.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// For displaying video within the flow of content. Not full screen.
/// Must pass either a [String videoUri] (Uploadcare UUID) or a [BetterPlayerController controller]
class UploadcareVideoPlayer extends StatefulWidget {
  final Key? key;
  final String videoUri;
  final bool autoPlay;
  final bool autoLoop;
  final bool isFullScreen;

  /// Seek to this point immediately.
  final Duration? startPosition;
  UploadcareVideoPlayer(
      {this.key,
      required this.videoUri,
      this.autoLoop = false,
      this.autoPlay = false,
      this.startPosition,
      this.isFullScreen = false})
      : super(key: key);

  @override
  _UploadcareVideoPlayerState createState() => _UploadcareVideoPlayerState();
}

class _UploadcareVideoPlayerState extends State<UploadcareVideoPlayer> {
  BetterPlayerController? _controller;
  BetterPlayerDataSource? _dataSource;
  VideoInfoEntity? _videoInfo;
  double? _aspectRatio;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideoController().then((_) {
      setState(() {});
    });
  }

  // Calls Uploadcare API and gets back a full url that the video player can use to play the video.
  Future<void> _initializeVideoController() async {
    _videoInfo = await UploadcareService.getVideoInfoRaw(widget.videoUri);
    if (_videoInfo?.url == null) {
      setState(() {
        _errorMessage = 'Sorry, we were not able to play this video.';
      });
      throw Exception('Unable to retrieve video data from the CDN.');
    } else {
      _dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, _videoInfo!.url,
          cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true));

      _aspectRatio = _videoInfo!.width / _videoInfo!.height;
      if (_aspectRatio == null || _aspectRatio == 0) {
        setState(() {
          _errorMessage = 'Sorry, could not work out the aspect ratio.';
        });
        throw Exception('Unable to get the video aspect ratio for display.');
      }

      // Show full controls if the player is full screen.
      // Or if the video is landscape (and should be taking up the full width of the screen).
      final _showFullControls = widget.isFullScreen || _aspectRatio! >= 1;
      _controller = BetterPlayerController(
          BetterPlayerConfiguration(
            autoDispose: false,
            fit: BoxFit.cover,
            aspectRatio: _aspectRatio,
            autoPlay: widget.autoPlay,
            looping: widget.autoLoop,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              playerTheme: BetterPlayerTheme.custom,
              customControlsBuilder: (controller) {
                return _showFullControls
                    ? FullVideoControls(
                        controller: controller,
                        showEnterExitFullScreen: _showFullControls,
                        enterExitFullScreen: widget.isFullScreen
                            ? () => context.pop(
                                result: _controller!
                                    .videoPlayerController!.position)
                            : _handleEnterFullScreen,
                        duration: Duration(milliseconds: _videoInfo!.duration),
                      )
                    : MinimalVideoControls(
                        controller: controller,
                        enterFullScreen: _handleEnterFullScreen,
                      );
              },
            ),
          ),
          betterPlayerDataSource: _dataSource);
      final _initialized = _controller!.isVideoInitialized();
      if (_initialized ?? false) {
        setState(() {
          _errorMessage = 'Sorry, could not get this video ready to play.';
        });
        throw Exception(
            'The video controller did not initialize correctly. Please check the file url..');
      }

      if (widget.startPosition != null) {
        _controller!.seekTo(widget.startPosition!);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _handleEnterFullScreen() async {
    final _startPosition = await _controller!.videoPlayerController!.position;
    final _positionWhenClosed = await context.push<Duration>(
        fullscreenDialog: _aspectRatio! < 1,
        child: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            child: SizedBox.expand(
              child: RotatedBox(
                quarterTurns: _aspectRatio! < 1 ? 0 : 1,
                child: UploadcareVideoPlayer(
                    key: Key('${widget.videoUri} - full screen'),
                    videoUri: widget.videoUri,
                    isFullScreen: true,
                    autoPlay: true,
                    startPosition: _startPosition ?? Duration(seconds: 0)),
              ),
            )));
    _controller!.seekTo(_positionWhenClosed);
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
        : _controller != null
            ? Hero(
                tag: 'uploadcare-video-player-hero',
                child: AspectRatio(
                  aspectRatio: _aspectRatio!,
                  child: BetterPlayer(
                    controller: _controller!,
                  ),
                ),
              )
            : LoadingCircle();
  }
}
