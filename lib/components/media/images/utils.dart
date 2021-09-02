import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<File> pickThenCropImage(ImageSource source) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) {
        throw Exception('No file selected.');
      }

      File? croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.rectangle,
        sourcePath: pickedFile.path,
      );
      if (croppedFile == null) {
        throw Exception('Cropping did not work.');
      }
      return croppedFile;
    } on PlatformException catch (e) {
      print(e);
      rethrow;
    }
  }
}
