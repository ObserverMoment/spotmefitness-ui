import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// Use for standard image viewing - no pan, scroll zoom.
class ImageViewer extends StatelessWidget {
  final String uri;
  final BoxFit fit;
  final Alignment alignment;
  final Size? displaySize;
  ImageViewer(
      {required this.uri,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.center,
      this.displaySize});

  @override
  Widget build(BuildContext context) {
    return SizedUploadcareImage(
      uri,
      displaySize: displaySize ?? MediaQuery.of(context).size,
      fit: fit,
      alignment: alignment,
    );
  }
}

Future<void> openFullScreenImageViewer(
  BuildContext context,
  String uri, {
  Alignment alignment = Alignment.center,
  String? title,
}) async {
  await context.push(
    child: FullScreenImageViewer(uri: uri, title: title),
    fullscreenDialog: true,
  );
}

/// Also has sharing button / functionality.
/// Hero animates the image from the previous route into place in the new one.
/// By default assumes file is coming from network.
/// Icludes pan, scroll, zoom functionality via [photo_view] package.
class FullScreenImageViewer extends StatelessWidget {
  final String uri;
  final String? title;
  FullScreenImageViewer({
    required this.uri,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          heroTag: 'FullScreenImageViewer',
          middle: title != null ? NavBarTitle(title!) : null,
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => print('share flow'),
            child: Icon(
              CupertinoIcons.share_up,
              size: 24,
            ),
          ),
        ),
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: context.theme.background),
          imageProvider: UploadcareImageProvider(uri),
        ));
  }
}
