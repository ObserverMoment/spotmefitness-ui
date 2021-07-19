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
    final padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 6);
    return Column(
      children: [
        Card(
          height: 240,
          opaqueBackgroundImage: false,
          backgroundImageUri: discoverFeatured.coverImageUri,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ContentBox(
                    padding: padding,
                    borderRadius: 0,
                    child: MyText(
                      discoverFeatured.tag,
                      color: context.theme.brightness == Brightness.dark
                          ? Styles.colorFour
                          : Styles.colorThree,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ContentBox(
                padding: padding,
                borderRadius: 0,
                child: MyText(
                  discoverFeatured.name,
                  size: FONTSIZE.LARGE,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: MyText(
            discoverFeatured.description,
            maxLines: 4,
            textAlign: TextAlign.center,
            lineHeight: 1.1,
          ),
        ),
      ],
    );
  }
}
