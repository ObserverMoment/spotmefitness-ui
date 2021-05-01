import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  String? _recordedFilePath;

  double _volumeDecibels = 0;
  Duration _recordingLength = Duration.zero;

  late StreamSubscription<RecordingDisposition> _progressListener;

  Duration _animDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    _initRecorder().then((value) {
      _mRecorder.setSubscriptionDuration(Duration(milliseconds: 50));

      // Set up listener.
      _progressListener = _mRecorder.onProgress!.listen((e) {
        setState(() {
          _volumeDecibels = e.decibels ?? 0;
          _recordingLength = e.duration;
        });
      });

      setState(() => _mRecorderIsInited = true);
    });
  }

  Future<void> _initRecorder() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      context.showDialog(
          title: 'Microphone Permission',
          content: MyText(
              'Please enable microphone access to be able to take voice notes.'),
          actions: [CupertinoDialogAction(child: MyText('OK'))]);
      context.pop();
    }

    Directory tempDir = await getTemporaryDirectory();

    final rand = DateTime.now().millisecondsSinceEpoch.toString();

    _recordedFilePath =
        '${tempDir.path}/${rand}journal_entry_voice_note_temp.aac';

    await _mRecorder.openAudioSession(
        category: SessionCategory.record, mode: SessionMode.modeSpokenAudio);
  }

  Future<void> _startRecorder() async {
    await _mRecorder.startRecorder(
        toFile: _recordedFilePath, audioSource: AudioSource.microphone);
  }

  Future<void> _stopRecorder() async {
    await _mRecorder.stopRecorder();
  }

  Future<void> _pauseStartOrResume() async {
    if (_mRecorder.isRecording) {
      await _mRecorder.pauseRecorder();
    } else if (_mRecorder.isPaused) {
      await _mRecorder.resumeRecorder();
    } else if (_mRecorder.isStopped) {
      await _startRecorder();
    }
    setState(() {});
  }

  Future<void> _saveRecording() async {
    if (!_mRecorder.isStopped) {
      await _mRecorder.stopRecorder();
    }
    widget.saveAudioRecording(_recordedFilePath!);
    context.pop();
  }

  Future<void> _clearAndReset() async {
    await context.showConfirmDialog(
        title: 'Clear recording?',
        onConfirm: () async {
          if (!_mRecorder.isStopped) {
            await _mRecorder.stopRecorder();
          }
          setState(() {
            _volumeDecibels = 0;
            _recordingLength = Duration.zero;
          });
        });
  }

  Future<void> _handleCancelAndClose(BuildContext context) async {
    await _mRecorder.stopRecorder();
    context.pop();
  }

  @override
  void dispose() {
    _progressListener.cancel();
    // https://github.com/dooboolab/flutter_sound/blob/master/flutter_sound/example/lib/simple_recorder/simple_recorder.dart
    _stopRecorder();
    _mRecorder.closeAudioSession();
    // NOTE: This clean up (from docs) is not required - we want to be able to access the file and upload it subsequently.
    // if (_recordedFilePath != null) {
    //   File _outputFile = File(_recordedFilePath);
    //   if (_outputFile.existsSync()) {
    //     _outputFile.delete();
    //   }
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
          leading: NavBarCancelButton(() => _handleCancelAndClose(context)),
          middle: NavBarTitle('Record Mic'),
          trailing: InfoPopupButton(
              infoWidget: MyText('Explains how the audio recorder works'))),
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _mRecorderIsInited
              ? Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: AnimatedSwitcher(
                            duration: _animDuration,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _mRecorder.isRecording
                                  ? SpinKitDoubleBounce(
                                      color: context.theme.primary
                                          .withOpacity(0.7),
                                      size: 26,
                                      duration: Duration(seconds: 4),
                                    )
                                  : Icon(
                                      CupertinoIcons.circle_fill,
                                      color: context.theme.primary
                                          .withOpacity(0.1),
                                      size: 26,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 2,
                              progress: min(1, _volumeDecibels / 120),
                              animationDuration: Duration(milliseconds: 50),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyText(
                        _recordingLength == Duration.zero
                            ? ''
                            : '${_recordingLength.inSeconds} seconds recorded',
                        weight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        decoration: BoxDecoration(
                            color: context.theme.primary,
                            shape: BoxShape.circle),
                        child: CupertinoButton(
                            child: AnimatedSwitcher(
                              duration: _animDuration,
                              child: _mRecorder.isRecording
                                  ? Icon(CupertinoIcons.pause_solid,
                                      color: context.theme.background, size: 36)
                                  : Icon(CupertinoIcons.mic_fill,
                                      color: context.theme.background,
                                      size: 36),
                            ),
                            onPressed: _pauseStartOrResume),
                      ),
                    ),
                    if (!_mRecorder.isRecording &&
                        _recordingLength != Duration.zero)
                      FadeIn(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              PrimaryButton(
                                  text: 'Save Recording',
                                  onPressed: _saveRecording),
                              SizedBox(height: 12),
                              DestructiveButton(
                                  text: 'Clear', onPressed: _clearAndReset)
                            ],
                          ),
                        ),
                      )
                  ],
                )
              : LoadingCircle(),
        ),
      ),
    );
  }
}
