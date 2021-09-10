import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class AudioPlayerController {
  static Future<AudioPlayer> init(
      {required AudioPlayer player,
      AudioSessionConfiguration? sessionType,
      required String audioUri,
      LoopMode loopMode = LoopMode.one,
      bool autoPlay = false,
      Duration}) async {
    final session = await AudioSession.instance;
    await session.configure(sessionType ?? AudioSessionConfiguration.speech());

    try {
      final url = await UploadcareService.getFileUrl(audioUri);

      if (Utils.textNotNull(url)) {
        await player.setUrl(url!);
        await player.setLoopMode(loopMode);

        // Listen to errors during playback.
        player.playbackEventStream.listen(null,
            onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });

        if (autoPlay) {
          player.play();
        }
      } else {
        throw Exception('Could not retrieve a valid url for this file.');
      }
    } on PlayerException catch (e) {
      print("Error code: ${e.code}");
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all errors
      print(e);
    } finally {
      return player;
    }
  }

  static Future<void> openAudioPlayer(
      {required BuildContext context,
      required String audioUri,
      required String audioTitle,
      String? audioSubtitle,
      required String pageTitle,
      bool autoPlay = false}) async {
    await context.push(
        fullscreenDialog: true,
        child: FullAudioPlayer(
          audioUri: audioUri,
          pageTitle: pageTitle,
          audioTitle: audioTitle,
          audioSubtitle: audioSubtitle,
          autoPlay: autoPlay,
        ));
  }
}

/// Playes an audio file from an uploadcare uri
class FullAudioPlayer extends StatefulWidget {
  final String audioUri;
  final Widget? image;
  final String pageTitle;
  final String audioTitle;
  final String? audioSubtitle;
  final bool autoPlay;
  FullAudioPlayer(
      {required this.audioUri,
      this.image,
      required this.pageTitle,
      required this.audioTitle,
      this.audioSubtitle,
      this.autoPlay = false});

  @override
  _FullAudioPlayerState createState() => _FullAudioPlayerState();
}

class _FullAudioPlayerState extends State<FullAudioPlayer> {
  late AudioPlayer _player;
  Duration _totalDuration = Duration.zero;

  final double _playPauseButtonSize = 75;
  final double _jumpSeekButtonSize = 42;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    await AudioPlayerController.init(
      player: _player,
      audioUri: widget.audioUri,
      autoPlay: widget.autoPlay,
    );
    setState(() {
      _totalDuration = _player.duration!;
    });
  }

  void _handleScrubSeek(double position) {
    _player.seek(Duration(
        milliseconds: (_totalDuration.inMilliseconds * position).round()));
  }

  void _seekTo(Duration seekTo) {
    _player.seek(seekTo.clamp(Duration.zero, _totalDuration));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        middle: NavBarTitle(widget.pageTitle),
        backgroundColor: context.theme.background,
        customLeading: CupertinoButton(
            child: Icon(CupertinoIcons.chevron_down), onPressed: context.pop),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.image != null
                ? widget.image
                : Icon(
                    CupertinoIcons.waveform,
                    size: 80,
                    color: context.theme.primary.withOpacity(0.85),
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            height: 120,
            child: StreamBuilder<Duration?>(
                stream: _player.positionStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: MyText('Sorry, there was a problem.'));
                  } else {
                    return AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        child: (!snapshot.hasData ||
                                _totalDuration == Duration.zero)
                            ? Center(
                                child: LoadingDots(
                                size: 12,
                              ))
                            : Column(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: SliderTheme(
                                      data: SliderThemeData(
                                        trackHeight: 2.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 5),
                                      ),
                                      child: Slider(
                                        value: (snapshot.data!.inMilliseconds /
                                                _totalDuration.inMilliseconds)
                                            .clamp(0, 1.0),
                                        onChanged: _handleScrubSeek,
                                        activeColor: context.theme.primary,
                                        inactiveColor: context.theme.primary
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(snapshot.data!.compactDisplay(),
                                            size: FONTSIZE.SMALL),
                                        MyText(
                                            '- ${(_totalDuration - snapshot.data!).compactDisplay()}',
                                            size: FONTSIZE.SMALL),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: H2(widget.audioTitle),
          ),
          if (Utils.textNotNull(widget.audioSubtitle))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(widget.audioSubtitle!),
            ),
          SizedBox(
            child: StreamBuilder<PlayerState>(
                stream: _player.playerStateStream,
                builder: (context, stateSnapShot) {
                  if (stateSnapShot.hasError) {
                    return Center(child: MyText('Sorry, there was a problem.'));
                  } else {
                    if (!stateSnapShot.hasData) {
                      return Center(
                          child: LoadingDots(
                        size: 12,
                      ));
                    } else {
                      return StreamBuilder<Duration?>(
                          stream: _player.positionStream,
                          builder: (context, durationSnapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (durationSnapshot.hasData)
                                  FadeIn(
                                    child: CupertinoButton(
                                      onPressed: () => _seekTo(Duration(
                                          seconds:
                                              durationSnapshot.data!.inSeconds -
                                                  15)),
                                      child: JumpSeekIcon(
                                        forward: false,
                                        size: _jumpSeekButtonSize,
                                      ),
                                    ),
                                  ),
                                CupertinoButton(
                                  onPressed: () => stateSnapShot.data!.playing
                                      ? _player.pause()
                                      : _player.play(),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 400),
                                    child: stateSnapShot.data!.playing
                                        ? Icon(
                                            CupertinoIcons.pause_circle_fill,
                                            size: _playPauseButtonSize,
                                          )
                                        : Icon(
                                            CupertinoIcons.play_circle_fill,
                                            size: _playPauseButtonSize,
                                          ),
                                  ),
                                ),
                                if (durationSnapshot.hasData)
                                  CupertinoButton(
                                    onPressed: () => _seekTo(Duration(
                                        seconds:
                                            durationSnapshot.data!.inSeconds +
                                                15)),
                                    child: JumpSeekIcon(
                                      forward: true,
                                      size: _jumpSeekButtonSize,
                                    ),
                                  ),
                              ],
                            );
                          });
                    }
                  }
                }),
          )
        ],
      ),
    );
  }
}
