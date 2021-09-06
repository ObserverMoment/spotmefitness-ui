import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class Card extends StatelessWidget {
  final Widget child;
  final double? height;
  final String? backgroundImageUri;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final EdgeInsets padding;

  // When true the image will be faded into the background of the card. When false it will display normally
  final bool opaqueBackgroundImage;
  Card(
      {this.height,
      this.backgroundImageUri,
      required this.child,
      this.backgroundColor,
      this.withBoxShadow = true,
      this.padding = kStandardCardPadding,
      this.opaqueBackgroundImage = true});
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = const Dimensions(500, 500);
    if (backgroundImageUri != null) {
      // Calc the ideal image size based on the display size.
      // Cards usually take up the full width.
      // // Making the raw requested image larger than the display space - otherwise it seems to appear blurred. More investigation required.
      final double width = MediaQuery.of(context).size.width;
      dimensions =
          Dimensions((width * 1.5).toInt(), ((height ?? 800) * 1.5).toInt());
    }

    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor ?? context.theme.cardBackground,
          boxShadow: withBoxShadow ? [Styles.cardBoxShadow] : null,
          borderRadius: kStandardCardBorderRadius,
          image: backgroundImageUri != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: opaqueBackgroundImage
                      ? ColorFilter.mode(context.theme.primary.withOpacity(0.3),
                          BlendMode.dstATop)
                      : null,
                  image: UploadcareImageProvider(backgroundImageUri!,
                      transformations: [PreviewTransformation(dimensions)]))
              : null),
      child: child,
    );
  }
}
