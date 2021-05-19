import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/components/media/audio/mic_audio_recorder.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// On complete run [onUploadSuccess] so that we can save the uploaded file uri to the db.
class AudioUploader extends StatefulWidget {
  final String? audioUri;
  final Size displaySize;
  final void Function()? onUploadStart;
  final void Function(String uploadedUri) onUploadSuccess;
  final void Function() removeAudio;
  final IconData iconData;
  AudioUploader(
      {this.audioUri,
      this.displaySize = const Size(120, 120),
      required this.onUploadSuccess,
      this.onUploadStart,
      this.iconData = CupertinoIcons.waveform,
      required this.removeAudio});

  @override
  _AudioUploaderState createState() => _AudioUploaderState();
}

class _AudioUploaderState extends State<AudioUploader> {
  bool _uploading = false;

  Future<void> _pickAudioFromDevice() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null && result.files.single.path != null) {
      try {
        setState(() => _uploading = true);
        await _uploadFile(File(result.files.single.path!));
        setState(() => _uploading = false);
      } catch (e) {
        await context.showErrorAlert(e.toString());
      } finally {
        setState(() => _uploading = false);
      }
    }
  }

  Future<void> _recordAudioFromDevice() async {
    await openMicAudioRecorder(
        context: context,
        saveAudioRecording: (path) => _uploadFile(File(path)));
  }

  Future<void> _uploadFile(File file) async {
    if (widget.onUploadStart != null) {
      widget.onUploadStart!();
    }
    await GetIt.I<UploadcareService>().uploadFile(
        file: SharedFile(file),
        onComplete: (uri) {
          _resetState();
          widget.onUploadSuccess(uri);
        },
        onFail: (e) => throw new Exception(e));
  }

  Future<void> _listenToAudio() async {
    if (widget.audioUri != null) {
      await context.showBottomSheet(
          expand: true,
          child: FullAudioPlayer(
            audioUri: widget.audioUri!,
            title: 'Preview Audio',
          ));
    }
  }

  void _resetState() => setState(() {
        _uploading = false;
      });

  @override
  Widget build(BuildContext context) {
    final Color primary = context.theme.primary;
    final Color background = context.theme.background;
    final bool hasAudio = Utils.textNotNull(widget.audioUri);
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              if (hasAudio)
                CupertinoActionSheetAction(
                  child: MyText('Listen to audio'),
                  onPressed: () async {
                    await _listenToAudio();
                    context.pop();
                  },
                ),
              CupertinoActionSheetAction(
                child:
                    MyText(hasAudio ? 'Make new recording' : 'Make recording'),
                onPressed: () {
                  context.pop();
                  _recordAudioFromDevice();
                },
              ),
              CupertinoActionSheetAction(
                child: MyText(hasAudio
                    ? 'Choose new from library'
                    : 'Choose from library'),
                onPressed: () async {
                  context.pop();
                  await _pickAudioFromDevice();
                },
              ),
              if (hasAudio)
                CupertinoActionSheetAction(
                  child: MyText(
                    'Remove audio',
                    color: Styles.errorRed,
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    context.pop();
                    context.showConfirmDeleteDialog(
                        itemType: 'Audio', onConfirm: widget.removeAudio);
                  },
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: MyText(
                'Cancel',
              ),
              onPressed: () {
                context.pop();
              },
            )),
      ),
      child: Stack(
        children: [
          Container(
            width: widget.displaySize.width,
            height: widget.displaySize.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: hasAudio ? Styles.colorOne : primary.withOpacity(0.2),
              boxShadow: [Styles.avatarBoxShadow],
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: _uploading
                  ? LoadingCircle(
                      color: background.withOpacity(0.4),
                    )
                  : Icon(
                      widget.iconData,
                      color:
                          hasAudio ? Styles.white : background.withOpacity(0.4),
                      size: widget.displaySize.width / 1.5,
                    ),
            ),
          ),
          if (hasAudio)
            Positioned(
                bottom: 3,
                right: 3,
                child: FadeIn(
                    child: Icon(
                  CupertinoIcons.checkmark_alt_circle,
                  size: 16,
                  color: Styles.white,
                )))
        ],
      ),
    );
  }
}
