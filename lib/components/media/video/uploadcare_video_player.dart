import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/video/video_controls_overlay.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:video_player/video_player.dart';

class UploadcareVideoPlayer extends StatefulWidget {
  final String videoUri;
  final bool autoPlay;
  final bool autoLoop;
  UploadcareVideoPlayer(this.videoUri,
      {this.autoLoop = false, this.autoPlay = false});

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
    if (_videoInfo == null) {
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

      // When video is portrait only show v basic controls - play and full screen.
      // Generally these videos should be landscape.
      _controller = BetterPlayerController(
          BetterPlayerConfiguration(
            autoDispose: true,
            aspectRatio: _aspectRatio,
            autoPlay: widget.autoPlay,
            looping: widget.autoLoop,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              playerTheme: BetterPlayerTheme.custom,
              customControlsBuilder: (controller) {
                return FullScreenVideoControls(
                  controller: controller,
                  showEnterExitFullScreen: _aspectRatio! >= 1,
                  duration: Duration(milliseconds: _videoInfo!.duration),
                );
              },
            ),
          ),
          betterPlayerDataSource: _dataSource);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Wrapping in center helps maintain size when video is in a list view.
    // https://stackoverflow.com/questions/59472726/why-does-aspectratio-not-work-in-a-listview
    return _controller != null && _aspectRatio != null
        ? AspectRatio(
            aspectRatio: _aspectRatio!,
            child: BetterPlayer(
              controller: _controller!,
            ),
          )
        : LoadingCircle();
  }
}
