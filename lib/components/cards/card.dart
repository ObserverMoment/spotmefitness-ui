import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class Card extends StatelessWidget {
  final Widget child;
  final double? height;
  final String? backgroundImageUri;
  Card({this.height, this.backgroundImageUri, required this.child});
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: height,
      decoration: BoxDecoration(
          color: context.theme.cardBackground,
          boxShadow: [Styles.cardBoxShadow],
          borderRadius: BorderRadius.circular(4),
          image: backgroundImageUri != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      context.theme.cardBackground.withOpacity(0.2),
                      BlendMode.dstATop),
                  image: UploadcareImageProvider(backgroundImageUri!,
                      transformations: [PreviewTransformation(dimensions)]))
              : null),
      child: child,
    );
  }
}