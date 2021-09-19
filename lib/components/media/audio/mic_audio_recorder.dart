import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:record/record.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/timer_components.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:path_provider/path_provider.dart';

Future<void> openMicAudioRecorder(
    {required BuildContext context,
    required Function(String filePath) saveAudioRecording,
    bool autoStartRecord = false}) async {
  await context.push(
      fullscreenDialog: true,
      child: MicAudioRecorder(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        saveAudioRecording: saveAudioRecording,
      ));
}

class MicAudioRecorder extends StatefulWidget {
  final Key key;
  final Function(String filePath) saveAudioRecording;

  MicAudioRecorder({
    required this.key,
    required this.saveAudioRecording,
  });

  @override
  _MicAudioRecorderState createState() => _MicAudioRecorderState();
}

class _MicAudioRecorderState extends State<MicAudioRecorder> {
  bool _isStopped = true;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = Record();
  Amplitude? _amplitude;
  String? _recordedFilePath;

  Future<void> _pauseStartOrResume() async {
    if (_isStopped) {
      await _start();
    } else if (_isPaused) {
      await _resume();
    } else {
      await _pause();
    }
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        Directory tempDir = await getTemporaryDirectory();

        final rand = DateTime.now().millisecondsSinceEpoch.toString();

        _recordedFilePath =
            '${tempDir.path}/${rand}journal_entry_voice_note_temp.aac';

        await _audioRecorder.start(
            path: _recordedFilePath, encoder: AudioEncoder.AAC);

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isStopped = !isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }

  Future<void> _clearAndReset() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.stop();

    setState(() {
      _recordDuration = 0;
      _isStopped = true;
      _isPaused = false;
    });
  }

  Future<void> _saveRecording() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();

    widget.saveAudioRecording(path!);

    setState(() => _isStopped = true);
    context.pop();
  }

  /// dBFS amplitude
  /// 10^(x/20)
  /// https://www.moellerstudios.org/converting-amplitude-representations/
  double _calcVolumePeakPercent() {
    if (_amplitude == null || _amplitude!.current == double.negativeInfinity) {
      return 0.0;
    } else {
      return pow(10, (-_amplitude!.current / 20)).clamp(0.0, 1.0).toDouble();
    }
  }

  Future<void> _handleCancelAndClose() async {
    context.pop();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: MyNavBar(
          customLeading: NavBarCancelButton(_handleCancelAndClose),
          middle: NavBarTitle('Record Mic'),
          trailing: InfoPopupButton(
              infoWidget: MyText('Explains how the audio recorder works'))),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularPercentIndicator(
                    percent: _calcVolumePeakPercent(),
                    lineWidth: 1,
                    radius: MediaQuery.of(context).size.width * 0.35,
                    center: _amplitude != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                'Level',
                                size: FONTSIZE.SMALL,
                                subtext: true,
                              ),
                              SizedBox(height: 6),
                              MyText(
                                'Current: ${_amplitude?.current ?? 0.0}',
                                size: FONTSIZE.SMALL,
                                subtext: true,
                              ),
                              SizedBox(height: 3),
                              MyText(
                                'Max: ${_amplitude?.max ?? 0.0}',
                                size: FONTSIZE.SMALL,
                                subtext: true,
                              ),
                            ],
                          )
                        : null,
                    backgroundColor: context.theme.primary.withOpacity(0.1),
                    progressColor: Styles.peachRed,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedSwitcher(
                  duration: kStandardAnimationDuration,
                  child: !_isPaused && !_isStopped
                      ? SpinKitDoubleBounce(
                          color: Styles.peachRed.withOpacity(0.7),
                          size: 20,
                          duration: Duration(seconds: 4),
                        )
                      : Icon(
                          CupertinoIcons.circle_fill,
                          color: context.theme.primary.withOpacity(0.07),
                          size: 20,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimerDisplayText(
                  milliseconds: _recordDuration * 1000,
                  fontSize: FONTSIZE.HUGE,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                      color: context.theme.primary, shape: BoxShape.circle),
                  child: CupertinoButton(
                      child: AnimatedSwitcher(
                          duration: kStandardAnimationDuration,
                          child: _isPaused || _isStopped
                              ? Column(
                                  children: [
                                    Icon(CupertinoIcons.mic_fill,
                                        color: context.theme.background,
                                        size: 42),
                                    if (_recordDuration > 0)
                                      MyText(
                                        'More..',
                                        color: context.theme.background,
                                        lineHeight: 1.3,
                                        size: FONTSIZE.TINY,
                                      )
                                  ],
                                )
                              : Icon(CupertinoIcons.pause_solid,
                                  color: context.theme.background, size: 42)),
                      onPressed: _pauseStartOrResume),
                ),
              ),
              if (_isPaused && _recordDuration > 0)
                FadeIn(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      children: [
                        PrimaryButton(
                            text: 'Save Recording', onPressed: _saveRecording),
                        SizedBox(height: 12),
                        DestructiveButton(
                            text: 'Clear', onPressed: _clearAndReset)
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
