import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<File> pickThenCropImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) {
      throw Exception('Picking file failed.');
    }

    File? croppedFile = await ImageCropper.cropImage(
      cropStyle: CropStyle.rectangle,
      sourcePath: pickedFile.path,
    );
    if (croppedFile == null) {
      throw Exception('Cropping file failed.');
    }
    return croppedFile;
  }
}
