import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class DiscoverWorkoutCategoryCard extends StatelessWidget {
  final DiscoverWorkoutCategory discoverWorkoutCategory;
  const DiscoverWorkoutCategoryCard(
      {Key? key, required this.discoverWorkoutCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          height: 180,
          opaqueBackgroundImage: false,
          backgroundImageUri: discoverWorkoutCategory.coverImageUri,
          child: Align(
            alignment: Alignment.topLeft,
            child: ContentBox(
              borderRadius: 100,
              child: H2(
                discoverWorkoutCategory.name,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: MyText(
                  discoverWorkoutCategory.tagline,
                  textAlign: TextAlign.left,
                  color: context.theme.brightness == Brightness.dark
                      ? Styles.colorFour
                      : Styles.colorThree,
                  weight: FontWeight.bold,
                ),
              ),
              MyText(
                discoverWorkoutCategory.description,
                maxLines: 3,
                textAlign: TextAlign.left,
                lineHeight: 1.4,
                size: FONTSIZE.two,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
