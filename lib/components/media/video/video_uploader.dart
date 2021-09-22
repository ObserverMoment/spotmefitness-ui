import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/media/video/uploadcare_video_player.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/services/uploadcare.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// Displays a video thumbnail (if it exists).
/// OnTap starts pick video then upload flow.
/// On complete run [onUploadSuccess] so that we can save the uploaded file uri to the db.
class VideoUploader extends StatefulWidget {
  final String? videoUri;
  final String? videoThumbUri;
  final Size displaySize;
  final void Function()? onUploadStart;
  final void Function(String videoUri, String videoThumbUri) onUploadSuccess;
  final void Function() removeVideo;
  const VideoUploader(
      {Key? key,
      this.videoUri,
      this.videoThumbUri,
      this.displaySize = const Size(120, 120),
      this.onUploadStart,
      required this.onUploadSuccess,
      required this.removeVideo})
      : super(key: key);

  @override
  _VideoUploaderState createState() => _VideoUploaderState();
}

class _VideoUploaderState extends State<VideoUploader> {
  bool _uploading = false;
  bool _processing = false;
  double _uploadProgress = 0;

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? pickedFile = await ImagePicker().pickVideo(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      final String fileSize =
          '${(file.lengthSync() / 1000000).toStringAsFixed(2)} MB';

      await context.showDialog(
          useRootNavigator: false,
          title: 'Upload video',
          content: MyText(
            'This file is $fileSize in size.',
            textAlign: TextAlign.center,
          ),
          actions: [
            CupertinoDialogAction(
              child: const MyText('Yes'),
              onPressed: () {
                context.pop();
                _uploadFile(file);
              },
            ),
            CupertinoDialogAction(
              onPressed: context.pop,
              child: const MyText('No'),
            ),
          ]);
    }
  }

  Future<void> _uploadFile(File _file) async {
    widget.onUploadStart?.call();
    try {
      setState(() => _uploading = true);
      await GetIt.I<UploadcareService>().uploadVideo(
          file: SharedFile(_file),
          onProgress: (progress) =>
              setState(() => _uploadProgress = progress.value),
          onUploaded: () => setState(() {
                _uploading = false;
                _processing = true;
              }),
          onComplete: (videoUri, videoThumbUri) {
            _resetState();
            widget.onUploadSuccess(videoUri, videoThumbUri);
          },
          onFail: (e) => throw Exception(e));
    } catch (e) {
      printLog(e.toString());
      await context.showErrorAlert(e.toString());
      _resetState();
    }
  }

  void _resetState() => setState(() {
        _uploading = false;
        _processing = false;
        _uploadProgress = 0;
      });

  @override
  Widget build(BuildContext context) {
    final Color primary = context.theme.primary;
    final Color cardBackground = context.theme.cardBackground;
    final bool hasVideo = Utils.textNotNull(widget.videoUri);

    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              if (hasVideo)
                CupertinoActionSheetAction(
                  child: const MyText('Watch video'),
                  onPressed: () async {
                    await VideoSetupManager.openFullScreenVideoPlayer(
                      context: context,
                      videoUri: widget.videoUri!,
                    );
                    context.pop();
                  },
                ),
              CupertinoActionSheetAction(
                child: MyText(hasVideo ? 'Take new video' : 'Take video'),
                onPressed: () {
                  context.pop();
                  _pickVideo(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: MyText(hasVideo
                    ? 'Choose new from library'
                    : 'Choose from library'),
                onPressed: () {
                  context.pop();
                  _pickVideo(ImageSource.gallery);
                },
              ),
              if (hasVideo)
                CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    context.pop();
                    context.showConfirmDeleteDialog(
                        itemType: 'Video', onConfirm: widget.removeVideo);
                  },
                  child: const MyText(
                    'Remove video',
                    color: Styles.errorRed,
                  ),
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const MyText(
                'Cancel',
              ),
              onPressed: () {
                context.pop();
              },
            )),
      ),
      child: Container(
        width: widget.displaySize.width,
        height: widget.displaySize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: cardBackground,
          boxShadow: [Styles.avatarBoxShadow],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _uploading
              ? LinearProgressIndicator(
                  width: widget.displaySize.width * 0.8,
                  height: 3,
                  progress: _uploadProgress,
                )
              : _processing
                  ? LoadingCircle(
                      color: primary,
                    )
                  : hasVideo
                      ? SizedUploadcareImage(widget.videoThumbUri!)
                      : Icon(
                          CupertinoIcons.film,
                          size: widget.displaySize.width / 2.5,
                          color: primary.withOpacity(0.3),
                        ),
        ),
      ),
    );
  }
}
