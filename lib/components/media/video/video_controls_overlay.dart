import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// The first returns widget must be a valid stack child.
/// This is what is required by [BetterPlayerControlsConfiguration][customControlsBuilder]
class FullVideoControls extends StatefulWidget {
  final BetterPlayerController controller;
  final Duration duration;
  final Widget? overlay;
  final bool showEnterExitFullScreen;
  final void Function()? enterExitFullScreen;
  final bool isFullScreen;
  FullVideoControls(
      {required this.controller,
      required this.duration,
      this.showEnterExitFullScreen = true,
      this.isFullScreen = false,
      this.enterExitFullScreen,
      this.overlay})
      : assert((showEnterExitFullScreen && enterExitFullScreen != null) ||
            (!showEnterExitFullScreen && enterExitFullScreen == null));

  @override
  _FullVideoControlsState createState() => _FullVideoControlsState();
}

class _FullVideoControlsState extends State<FullVideoControls> {
  bool _isFinished = false;
  bool _isPlaying = false;
  // Between 0 and 1
  double _progress = 0.0;
  late Duration _duration;

  final _animDuration = Duration(milliseconds: 300);

  Future<void> _eventListener(event) async {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      final _position = await widget.controller.videoPlayerController?.position;
      if (_position != null) {
        setState(() {
          _progress =
              (_position.inMilliseconds / _duration.inMilliseconds).clamp(0, 1);
        });
      }
    }
    if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      setState(() {
        _isFinished = true;
        _isPlaying = false;
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
      setState(() {
        _isPlaying = true;
        _isFinished = false;
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _duration = widget.duration;
    widget.controller.addEventsListener(_eventListener);
  }

  void _handleSeek(dynamic progress) {
    widget.controller.seekTo(_duration * progress);
  }

  @override
  void dispose() {
    widget.controller.removeEventsListener(_eventListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          if (widget.overlay != null)
            Positioned(
                top: 0,
                left: 0,
                child: AnimatedSwitcher(
                    duration: _animDuration,
                    child: _isPlaying ? null : widget.overlay)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (_isPlaying) {
                      widget.controller.pause();
                    } else if (_isFinished) {
                      widget.controller.pause();
                      widget.controller.seekTo(Duration(milliseconds: 0));
                      widget.controller.play();
                    } else {
                      widget.controller.play();
                    }
                  },
                  child: Container(
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: _animDuration,
                        child: _isPlaying
                            ? null
                            : AnimatedSwitcher(
                                duration: _animDuration,
                                child: _isFinished
                                    ? Icon(
                                        CupertinoIcons.restart,
                                        color: Styles.white,
                                        size: 50,
                                      )
                                    : Icon(
                                        CupertinoIcons.play_fill,
                                        color: Styles.white,
                                        size: 50,
                                      ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: _animDuration,
                child: !_isPlaying || _isFinished
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 4.0,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 7),
                                  ),
                                  child: Slider(
                                    value: _progress,
                                    onChanged: _handleSeek,
                                    activeColor: Styles.peachRed,
                                    inactiveColor: Styles.lightGrey,
                                  ),
                                ),
                              ),
                            ),
                            MyText(
                              (_duration * (1 - _progress)).compactDisplay(),
                              color: Styles.white,
                              weight: FontWeight.bold,
                              size: FONTSIZE.SMALL,
                            )
                          ],
                        ),
                      )
                    : Container(height: 40, width: 0),
              )
            ],
          ),
          if (widget.showEnterExitFullScreen)
            Positioned(
                top: 6,
                right: 6,
                child: AnimatedSwitcher(
                    duration: _animDuration,
                    child: _isPlaying
                        ? Container(height: 0, width: 0)
                        : CupertinoButton(
                            onPressed: widget.enterExitFullScreen,
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Styles.black.withOpacity(0.1),
                                  shape: BoxShape.circle),
                              padding: const EdgeInsets.all(4),
                              child: widget.isFullScreen
                                  ? Icon(
                                      CupertinoIcons.clear,
                                      size: 30,
                                      color: Styles.white,
                                    )
                                  : Icon(
                                      CupertinoIcons.fullscreen,
                                      size: 26,
                                      color: Styles.white,
                                    ),
                            )))),
        ],
      ),
    );
  }
}

/// The first returns widget must be a valid stack child.
/// This is what is required by [BetterPlayerControlsConfiguration][customControlsBuilder]
class MinimalVideoControls extends StatelessWidget {
  final BetterPlayerController controller;
  final void Function() enterFullScreen;
  MinimalVideoControls(
      {required this.controller, required this.enterFullScreen});
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: enterFullScreen,
        behavior: HitTestBehavior.opaque,
        child: Container(
          child: Center(
            child: Icon(
              CupertinoIcons.play_fill,
              size: 45,
            ),
          ),
        ),
      ),
    );
  }
}
