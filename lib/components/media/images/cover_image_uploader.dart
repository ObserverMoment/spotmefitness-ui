import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/utils.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// Displays an image (if it exists) - across the full width of the screen.
/// Vs the [ImageUploader] which displays the image and picker as a thumbnail.
/// Vs the [ImageUploader] there is no option to 'view' this image in the bottom sheet menu that opens on click.
/// On complete run [onUploadSuccess] so that we can save the uploaded file uri to the db.
class CoverImageUploader extends StatefulWidget {
  final String? imageUri;
  final double displayHeight;
  final void Function()? onUploadStart;
  final void Function(String uploadedUri) onUploadSuccess;
  final void Function(String uri) removeImage;
  CoverImageUploader(
      {this.imageUri,
      this.displayHeight = 160.0,
      required this.onUploadSuccess,
      this.onUploadStart,
      required this.removeImage});

  @override
  _CoverImageUploaderState createState() => _CoverImageUploaderState();
}

class _CoverImageUploaderState extends State<CoverImageUploader> {
  bool _uploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      File croppedFile = await ImageUtils.pickThenCropImage(source);
      setState(() => _uploading = true);
      await _uploadFile(croppedFile);
      setState(() => _uploading = false);
    } catch (e) {
      await context.showErrorAlert(e.toString());
    } finally {
      setState(() => _uploading = false);
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
    final bool hasImage = Utils.textNotNull(widget.imageUri);

    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: widget.displayHeight,
            child: ContentBox(
              padding: EdgeInsets.zero,
              child: AnimatedSwitcher(
                duration: kStandardAnimationDuration,
                child: _uploading
                    ? Center(child: LoadingCircle(color: primary))
                    : hasImage
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedUploadcareImage(widget.imageUri!))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.photo,
                                    size: 40,
                                    color: primary.withOpacity(0.3),
                                  ),
                                  SizedBox(height: 8),
                                  MyText(
                                    'Add cover image',
                                    size: FONTSIZE.SMALL,
                                    subtext: true,
                                  )
                                ],
                              ),
                            ],
                          ),
              ),
            ),
          ),
          if (hasImage)
            Positioned(
                top: 8,
                right: 8,
                child: ContentBox(child: Icon(CupertinoIcons.pencil)))
        ],
      ),
    );
  }
}
