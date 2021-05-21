import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
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
  VideoUploader(
      {this.videoUri,
      this.videoThumbUri,
      this.displaySize = const Size(120, 120),
      this.onUploadStart,
      required this.onUploadSuccess,
      required this.removeVideo});

  @override
  _VideoUploaderState createState() => _VideoUploaderState();
}

class _VideoUploaderState extends State<VideoUploader> {
  bool _uploading = false;
  bool _processing = false;
  double _uploadProgress = 0;

  Future<void> _pickVideo(ImageSource source) async {
    PickedFile? pickedFile = await ImagePicker().getVideo(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      final String fileSize =
          '${(file.lengthSync() / 1000000).toStringAsFixed(2)} MB';

      await context.showDialog(
          title: 'Upload video',
          content: MyText('This file is $fileSize in size.'),
          actions: [
            CupertinoDialogAction(
              child: MyText('Yes'),
              onPressed: () {
                _uploadFile(file);
                context.pop();
              },
            ),
            CupertinoDialogAction(
              child: MyText('No'),
              onPressed: context.pop,
            ),
          ]);
    }
  }

  Future<void> _uploadFile(File _file) async {
    if (widget.onUploadStart != null) {
      widget.onUploadStart!();
    }
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
          onFail: (e) => throw new Exception(e));
    } catch (e) {
      print(e.toString());
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
    final Color _primary = context.theme.primary;
    final Color _background = context.theme.background;
    final bool hasVideo = Utils.textNotNull(widget.videoUri);
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              if (hasVideo)
                CupertinoActionSheetAction(
                  child: MyText('Watch video'),
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
                  child: MyText(
                    'Remove video',
                    color: Styles.errorRed,
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    context.pop();
                    context.showConfirmDeleteDialog(
                        itemType: 'Video', onConfirm: widget.removeVideo);
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
      child: Container(
        width: widget.displaySize.width,
        height: widget.displaySize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _primary.withOpacity(0.2),
          boxShadow: [Styles.avatarBoxShadow],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: _uploading
              ? LinearProgressIndicator(
                  width: widget.displaySize.width * 0.8,
                  height: 3,
                  progress: _uploadProgress,
                )
              : _processing
                  ? LoadingCircle(
                      color: _background.withOpacity(0.4),
                    )
                  : hasVideo
                      ? SizedUploadcareImage(widget.videoThumbUri!)
                      : Icon(
                          CupertinoIcons.film,
                          size: widget.displaySize.width / 2.5,
                          color: _background.withOpacity(0.4),
                        ),
        ),
      ),
    );
  }
}
