import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:uploadcare_client/uploadcare_client.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

/// Pass a list of Uploadcare file IDs.
/// Uses the photo_view component gallery which allow for pinch, scrool and zoom gestures.
class FullScreenImageGallery extends StatefulWidget {
  final int initialPageIndex;
  final List<String> fileIds;
  final String pageTitle;
  final Axis scrollDirection;

  FullScreenImageGallery(this.fileIds,
      {this.pageTitle = 'Gallery',
      this.scrollDirection = Axis.vertical,
      this.initialPageIndex = 0});

  @override
  _FullScreenImageGalleryState createState() => _FullScreenImageGalleryState();
}

class _FullScreenImageGalleryState extends State<FullScreenImageGallery> {
  late PageController _pageController;
  late int _activeIndex;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _activeIndex = widget.initialPageIndex;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size * 2;
    final width = size.width;
    final height = size.height;
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          customLeading: NavBarCloseButton(context.pop),
          middle: NavBarTitle(widget.pageTitle),
        ),
        child: Column(
          children: [
            Expanded(
              child: PhotoViewGallery.builder(
                pageController: _pageController,
                onPageChanged: (newIndex) =>
                    setState(() => _activeIndex = newIndex),
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration:
                    BoxDecoration(color: context.theme.background),
                gaplessPlayback: true,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: UploadcareImageProvider(
                        widget.fileIds[index],
                        transformations: [
                          PreviewTransformation(
                              Dimensions(width.toInt(), height.toInt()))
                        ]),
                    initialScale: PhotoViewComputedScale.contained,
                  );
                },
                itemCount: widget.fileIds.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: LoadingCircle(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: BasicProgressDots(
                numDots: widget.fileIds.length,
                currentIndex: _activeIndex,
                dotSize: 16,
              ),
            )
          ],
        ));
  }
}
