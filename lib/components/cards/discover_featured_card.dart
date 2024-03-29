import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class DiscoverFeaturedCard extends StatelessWidget {
  final DiscoverFeatured discoverFeatured;
  const DiscoverFeaturedCard({Key? key, required this.discoverFeatured})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 5, horizontal: 10);
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
              const SizedBox(height: 6),
              ContentBox(
                padding: padding,
                borderRadius: 4,
                child: MyText(
                  discoverFeatured.name,
                  maxLines: 2,
                  lineHeight: 1.3,
                  size: FONTSIZE.five,
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
