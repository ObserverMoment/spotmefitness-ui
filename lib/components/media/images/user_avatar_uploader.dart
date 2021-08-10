import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class UserAvatarUploader extends StatefulWidget {
  final String? avatarUri;
  final Size displaySize;
  final Function(String? uploadedUri)? onUploadSuccess;
  UserAvatarUploader(
      {this.avatarUri,
      this.displaySize = const Size(120, 120),
      this.onUploadSuccess});

  @override
  _UserAvatarUploaderState createState() => _UserAvatarUploaderState();
}

class _UserAvatarUploaderState extends State<UserAvatarUploader> {
  bool _uploading = false;

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: pickedFile.path,
      );
      if (croppedFile != null) {
        try {
          setState(() => _uploading = true);
          await _uploadFile(croppedFile);
          setState(() => _uploading = false);
        } catch (e) {
          await context.showErrorAlert(e.toString());
        } finally {
          setState(() => _uploading = false);
        }
      }
    }
  }

  Future<void> _uploadFile(File file) async {
    await GetIt.I<UploadcareService>().uploadFile(
        file: SharedFile(file),
        onComplete: (String uri) => _saveUriToDB(uri),
        onFail: (e) => throw new Exception(e));
  }

  /// Pass [null] to delete.
  Future<void> _saveUriToDB(String? uri) async {
    try {
      final variables =
          UpdateUserArguments(data: UpdateUserInput(avatarUri: uri));
      final Map<String, dynamic> varsMap = {'avatarUri': uri};

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

      if (widget.onUploadSuccess != null) {
        widget.onUploadSuccess!(uri);
      }
    } catch (e) {
      print(e.toString());
      await context.showErrorAlert(e.toString());
    } finally {
      _resetState();
    }
  }

  void _resetState() => setState(() {
        _uploading = false;
      });

  @override
  Widget build(BuildContext context) {
    final Color primary = context.theme.primary;
    final Color cardBackground = context.theme.cardBackground;
    final bool hasImage = Utils.textNotNull(widget.avatarUri);

    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        useRootNavigator: true,
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              if (hasImage)
                CupertinoActionSheetAction(
                  child: MyText('View image'),
                  onPressed: () async {
                    context.pop();
                    await openFullScreenImageViewer(context, widget.avatarUri!);
                  },
                ),
              CupertinoActionSheetAction(
                child: MyText('Take photo'),
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: MyText('Choose from library'),
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (hasImage)
                CupertinoActionSheetAction(
                  child: MyText(
                    'Remove image',
                    color: Styles.errorRed,
                  ),
                  isDestructiveAction: true,
                  onPressed: () {
                    context.pop();
                    context.showConfirmDeleteDialog(
                        itemType: 'Image', onConfirm: () => _saveUriToDB(null));
                  },
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: MyText(
                'Cancel',
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
      child: Container(
        width: widget.displaySize.width,
        height: widget.displaySize.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cardBackground,
          boxShadow: [Styles.avatarBoxShadow],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: _uploading
              ? LoadingCircle(color: primary)
              : widget.avatarUri != null
                  ? SizedUploadcareImage(widget.avatarUri!)
                  : Icon(
                      CupertinoIcons.photo,
                      size: widget.displaySize.width / 2.5,
                      color: primary.withOpacity(0.3),
                    ),
        ),
      ),
    );
  }
}
