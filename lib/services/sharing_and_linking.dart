import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:path_provider/path_provider.dart';

class SharingAndLinking {
  static Future<void> shareImageRenderOfWidget(
      {required BuildContext context,
      String? text,
      String? subject,
      EdgeInsets padding = EdgeInsets.zero,
      required Widget widgetForImageCapture}) async {
    try {
      context.showLoadingAlert(
        'Loading...',
      );

      /// Renders an image of the workout.coverImageUri or a placeholder image.
      final capturedImage = await ScreenshotController().captureFromWidget(
          ChangeNotifierProvider<ThemeBloc>.value(
            value: context.readTheme,
            child: Container(
                padding: padding,
                color: context.readTheme.background,
                child: widgetForImageCapture),
          ),
          delay: Duration(seconds: 2),
          context: context);

      // https://github.com/SachinGanesh/screenshot/issues/41
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/${kTempShareImageFileName}').create();
      final Uint8List pngBytes = capturedImage.buffer.asUint8List();
      await imagePath.writeAsBytes(pngBytes);

      context.pop(); // Loading alert modal.

      await Share.shareFiles([imagePath.path], text: text, subject: subject);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> shareClubInviteLink(
    String token,
  ) async {
    try {
      final String link = '${kDeepLinkSchema}club-invite/$token';
      await Share.share(link, subject: 'You have been invited to join a Club!');
    } catch (e) {
      throw Exception(e);
    }
  }
}
