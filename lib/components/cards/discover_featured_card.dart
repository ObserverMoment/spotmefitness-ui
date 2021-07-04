import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DiscoverFeaturedCard extends StatelessWidget {
  final DiscoverFeatured discoverFeatured;
  const DiscoverFeaturedCard({Key? key, required this.discoverFeatured})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textBackgroundColor = context.theme.background.withOpacity(0.6);
    final padding = const EdgeInsets.symmetric(vertical: 0.5, horizontal: 3);
    return Card(
      height: 180,
      opaqueBackgroundImage: false,
      backgroundImageUri: discoverFeatured.coverImageUri,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentBox(
                padding: padding,
                backgroundColor: textBackgroundColor,
                child: MyText(
                  discoverFeatured.tag,
                  color: context.theme.brightness == Brightness.dark
                      ? Styles.colorFour
                      : Styles.colorThree,
                  weight: FontWeight.bold,
                ),
              ),
              ContentBox(
                padding: padding,
                backgroundColor: textBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      discoverFeatured.name,
                      size: FONTSIZE.BIG,
                      weight: FontWeight.bold,
                    ),
                    MyText(
                      discoverFeatured.tagline,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ContentBox(
            padding: padding,
            backgroundColor: textBackgroundColor,
            child: MyText(
              discoverFeatured.description,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
