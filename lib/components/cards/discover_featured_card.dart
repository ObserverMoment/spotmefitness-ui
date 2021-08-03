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
    final padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10);
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
                    borderRadius: 4,
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
              SizedBox(height: 6),
              ContentBox(
                padding: padding,
                borderRadius: 4,
                child: MyText(
                  discoverFeatured.name,
                  maxLines: 2,
                  lineHeight: 1.3,
                  size: FONTSIZE.LARGE,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
