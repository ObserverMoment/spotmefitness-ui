import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/media/images/image_viewer.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/media/images/utils.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/services/uploadcare.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// Displays an image (if it exists).
/// On complete run [onUploadSuccess] so that we can save the uploaded file uri to the db.
class ImageUploader extends StatefulWidget {
  final String? imageUri;
  final Size displaySize;
  final void Function()? onUploadStart;
  final void Function(String uploadedUri) onUploadSuccess;
  final void Function(String uri) removeImage;
  const ImageUploader(
      {Key? key,
      this.imageUri,
      this.displaySize = const Size(120, 120),
      required this.onUploadSuccess,
      this.onUploadStart,
      required this.removeImage})
      : super(key: key);

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  bool _uploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final File croppedFile = await ImageUtils.pickThenCropImage(source);
      setState(() => _uploading = true);
      await _uploadFile(croppedFile);
      setState(() => _uploading = false);
    } on PlatformException catch (e) {
      context.showErrorAlert(e.toString());
    } on Exception catch (_) {
      context.showToast(message: 'Image not selected');
    } finally {
      setState(() => _uploading = false);
    }
  }

  Future<void> _uploadFile(File file) async {
    widget.onUploadStart?.call();

    await GetIt.I<UploadcareService>().uploadFile(
        file: SharedFile(file),
        onComplete: (uri) {
          _resetState();
          widget.onUploadSuccess(uri);
        },
        onFail: (e) => throw Exception(e));
  }

  void _resetState() => setState(() {
        _uploading = false;
      });

  @override
  Widget build(BuildContext context) {
    final Color primary = context.theme.primary;
    final Color cardBackground = context.theme.cardBackground;
    final bool hasImage = Utils.textNotNull(widget.imageUri);

    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              if (hasImage)
                CupertinoActionSheetAction(
                  child: const MyText('View image'),
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
                  isDestructiveAction: true,
                  onPressed: () {
                    context.pop();
                    context.showConfirmDeleteDialog(
                        itemType: 'Image',
                        onConfirm: () => widget.removeImage(widget.imageUri!));
                  },
                  child: const MyText(
                    'Remove image',
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
              ? LoadingCircle(
                  color: primary,
                )
              : hasImage
                  ? SizedUploadcareImage(widget.imageUri!)
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
