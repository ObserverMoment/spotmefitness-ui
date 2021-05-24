import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// Displays an image (if it exists).
/// On complete run [onUploadSuccess] so that we can save the uploaded file uri to the db.
class ImageUploader extends StatefulWidget {
  final String? imageUri;
  final Size displaySize;
  final void Function()? onUploadStart;
  final void Function(String uploadedUri) onUploadSuccess;
  final void Function(String uri) removeImage;
  ImageUploader(
      {this.imageUri,
      this.displaySize = const Size(120, 120),
      required this.onUploadSuccess,
      this.onUploadStart,
      required this.removeImage});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  bool _uploading = false;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile? pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.rectangle,
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

  void _resetState() => setState(() {
        _uploading = false;
      });

  @override
  Widget build(BuildContext context) {
    final Color primary = context.theme.primary;
    final Color background = context.theme.background;
    final bool hasImage = Utils.textNotNull(widget.imageUri);

    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              if (hasImage)
                CupertinoActionSheetAction(
                  child: MyText('View image'),
                  onPressed: () async {
                    context.pop();
                    await openFullScreenImageViewer(context, widget.imageUri!);
                  },
                ),
              CupertinoActionSheetAction(
                child: MyText(hasImage ? 'Take new photo' : 'Take photo'),
                onPressed: () {
                  context.pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: MyText(hasImage
                    ? 'Choose new from library'
                    : 'Choose from library'),
                onPressed: () {
                  context.pop();
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
                        itemType: 'Image',
                        onConfirm: () => widget.removeImage(widget.imageUri!));
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
          color: primary.withOpacity(0.2),
          boxShadow: [Styles.avatarBoxShadow],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: _uploading
              ? LoadingCircle(
                  color: background.withOpacity(0.4),
                )
              : hasImage
                  ? SizedUploadcareImage(widget.imageUri!)
                  : Icon(
                      CupertinoIcons.photo,
                      size: widget.displaySize.width / 2.5,
                      color: background.withOpacity(0.4),
                    ),
        ),
      ),
    );
  }
}
