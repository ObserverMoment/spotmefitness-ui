import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class UserIntroVideoUploader extends StatefulWidget {
  final String? introVideoUri;
  final String? introVideoThumbUri;
  final Size displaySize;
  final Function(String uploadedVideoUri, String uploadedVideoThumbUri)?
      onUploadSuccess;
  UserIntroVideoUploader(
      {this.introVideoUri,
      this.introVideoThumbUri,
      this.displaySize = const Size(120, 120),
      this.onUploadSuccess});

  @override
  _UserIntroVideoUploaderState createState() => _UserIntroVideoUploaderState();
}

class _UserIntroVideoUploaderState extends State<UserIntroVideoUploader> {
  bool _uploading = false;
  bool _processing = false;
  double _uploadProgress = 0;

  Future<void> _pickVideo(ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickVideo(source: source);
    if (_pickedFile != null) {
      final _file = File(_pickedFile.path);

      final String _fileSize =
          '${(_file.lengthSync() / 1000000).toStringAsFixed(2)} MB';

      await context.showDialog(
          title: 'Upload video',
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              'This file is $_fileSize in size.',
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: MyText('Yes'),
              onPressed: () {
                _uploadFile(_file);
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
          onComplete: (String videoUri, String videoThumbUri) =>
              _saveUrisToDB(videoUri, videoThumbUri),
          onFail: (e) => throw new Exception(e));
    } catch (e) {
      print(e.toString());
      await context.showErrorAlert(e.toString());
      _resetState();
    }
  }

  Future<void> _saveUrisToDB(String? videoUri, String? videoThumbUri) async {
    try {
      final input = UpdateUserInput()
        ..introVideoUri = videoUri
        ..introVideoThumbUri = videoThumbUri;
      final variables = UpdateUserArguments(data: input);
      final Map<String, dynamic> varsMap = {
        'introVideoUri': videoUri,
        'introVideoThumbUri': videoThumbUri
      };

      await context.graphQLStore.mutate(
          mutation: UpdateUserMutation(variables: variables),
          customVariablesMap: {
            'data': varsMap
          },
          broadcastQueryIds: [
            AuthedUserQuery().operationName
          ],
          optimisticData: {
            '__typename': 'User',
            'id': GetIt.I<AuthBloc>().authedUser!.id,
            ...varsMap
          });
    } catch (e) {
      print(e.toString());
      await context.showErrorAlert(e.toString());
    } finally {
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
    final bool hasVideo = Utils.textNotNull(widget.introVideoUri);

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
                      videoUri: widget.introVideoUri!,
                    );
                    context.pop();
                  },
                ),
              CupertinoActionSheetAction(
                child: MyText('Take video'),
                onPressed: () {
                  context.pop();
                  _pickVideo(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: MyText('Choose from library'),
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
                        itemType: 'Video',
                        onConfirm: () => _saveUrisToDB(null, null));
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
            shape: BoxShape.circle,
            color: _primary.withOpacity(0.7),
            boxShadow: [Styles.avatarBoxShadow]),
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
                  : Utils.textNotNull(widget.introVideoThumbUri)
                      ? SizedUploadcareImage(widget.introVideoThumbUri!)
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
