import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/extensions.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class UserAvatarUploader extends StatefulWidget {
  final String? avatarUri;
  final Size displaySize;
  final Function(String uploadedUri)? onUploadSuccess;
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
    PickedFile? _pickedFile = await ImagePicker().getImage(source: source);
    if (_pickedFile != null) {
      File? _croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: _pickedFile.path,
      );
      if (_croppedFile != null) {
        try {
          setState(() => _uploading = true);
          await _uploadFile(_croppedFile);
          setState(() => _uploading = false);
        } catch (e) {
          await context.showAlert(
            title: 'Sorry, something went wrong.',
            content: MyText(
              e.toString(),
              color: Styles.errorRed,
            ),
            actions: [
              CupertinoDialogAction(
                child: MyText('Ok'),
                onPressed: () => context.pop,
              ),
            ],
          );
        }
      }
    }
  }

  Future<void> _uploadFile(File _croppedFile) async {
    await GetIt.I<UploadcareService>().uploadImage(
        file: SharedFile(_croppedFile),
        onComplete: (String uri) => _saveUriToDB(uri),
        onFail: (e) => throw new Exception(e));
  }

  Future<void> _saveUriToDB(String uri) async {
    await GraphQL().client.mutate(
          MutationOptions(
            document: UpdateUserMutation().document,
            variables: {
              'data': {'avatarUri': uri}
            },
            onCompleted: (_) => widget.onUploadSuccess != null
                ? widget.onUploadSuccess!(uri)
                : null,
            onError: (e) => throw new Exception(e),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final Color _primary = context.theme.primary;
    final Color _background = context.theme.background;
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
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
      child: Stack(
        children: [
          Container(
            width: widget.displaySize.width,
            height: widget.displaySize.height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primary.withOpacity(0.7),
              boxShadow: [
                BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.5),
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      1.0, // Move to right horizontally
                      1.0, // Move to bottom Vertically
                    )),
              ],
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: _uploading
                  ? LoadingCircle(
                      color: _background.withOpacity(0.4),
                    )
                  : widget.avatarUri != null
                      ? SizedUploadcareImage(widget.avatarUri!)
                      : Icon(
                          CupertinoIcons.photo,
                          size: widget.displaySize.width / 2.5,
                          color: _background.withOpacity(0.4),
                        ),
            ),
          ),
          Positioned(
            bottom: widget.displaySize.width / 25,
            right: widget.displaySize.width / 25,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: _primary),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Icon(CupertinoIcons.plus_circle,
                  size: widget.displaySize.width / 4.5,
                  color: _background.withOpacity(0.7)),
            ),
          )
        ],
      ),
    );
  }
}
