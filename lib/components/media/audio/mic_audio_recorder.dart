import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
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
        autoStartRecord: autoStartRecord,
        saveAudioRecording: saveAudioRecording,
      ));
}

class MicAudioRecorder extends StatefulWidget {
  final Key key;
  final bool autoStartRecord;
  final Function(String filePath) saveAudioRecording;

  MicAudioRecorder(
      {required this.key,
      required this.saveAudioRecording,
      this.autoStartRecord = false});

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

      if (widget.autoStartRecord) {
        _startRecorder().then((value) => setState(() {}));
      }
    });
  }

  Future<void> _startRecorder() async {
    await _mRecorder.startRecorder(
        toFile: _recordedFilePath, audioSource: AudioSource.microphone);
  }

  Future<void> _stopRecorder() async {
    await _mRecorder.stopRecorder();
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

  Future<void> _pauseOrResume() async {
    if (_mRecorder.isRecording) {
      await _mRecorder.pauseRecorder();
    } else {
      await _mRecorder.resumeRecorder();
    }
    setState(() {});
  }

  Future<void> _startOrSave() async {
    if (_recordedFilePath != null) {
      if (_mRecorder.isStopped) {
        await _startRecorder();
        setState(() {});
      } else {
        await _mRecorder.stopRecorder();
        widget.saveAudioRecording(_recordedFilePath!);
        context.pop();
      }
    }
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
      navigationBar: CreateEditPageNavBar(
        handleClose: () => _handleCancelAndClose(context),
        handleSave: () => {},
        formIsDirty: false,
        inputValid: true,
        title: 'Record Audio',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _mRecorderIsInited
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.mic_fill,
                              size: 120,
                              color: CupertinoTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                            ),
                            SizedBox(
                              height: 70,
                              child: AnimatedSwitcher(
                                duration: _animDuration,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _mRecorder.isRecording
                                      ? SpinKitDoubleBounce(
                                          color:
                                              Styles.heartRed.withOpacity(0.7),
                                          size: 40,
                                          duration: Duration(seconds: 4),
                                        )
                                      : Icon(
                                          CupertinoIcons.circle_fill,
                                          color:
                                              Styles.heartRed.withOpacity(0.1),
                                          size: 50,
                                        ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 4,
                                  progress: min(1, _volumeDecibels / 120),
                                  animationDuration: Duration(milliseconds: 50),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: H2('${_recordingLength.inSeconds} seconds'),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CupertinoButton(
                                    child: AnimatedSwitcher(
                                      duration: _animDuration,
                                      child: _mRecorder.isRecording
                                          ? Icon(
                                              CupertinoIcons.pause_fill,
                                              size: 100,
                                            )
                                          : Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.circle_filled,
                                                  size: 100,
                                                  color: Styles.heartRed,
                                                ),
                                                Icon(
                                                  CupertinoIcons.mic,
                                                  size: 56,
                                                )
                                              ],
                                            ),
                                    ),
                                    onPressed: _pauseOrResume),
                              ],
                            ),
                          ],
                        ),
                        PrimaryButton(
                          text: 'Done',
                          prefix: Icon(
                            CupertinoIcons.checkmark_circle_fill,
                            size: 32,
                            color: CupertinoTheme.of(context)
                                .primaryContrastingColor,
                          ),
                          onPressed: _startOrSave,
                        ),
                      ],
                    )
                  : LoadingCircle(),
            ),
          )
        ],
      ),
    );
  }
}
