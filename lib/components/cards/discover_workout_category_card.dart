import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
              child: MyText(
                discoverWorkoutCategory.name,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyText(
                  discoverWorkoutCategory.tagline,
                  color: context.theme.brightness == Brightness.dark
                      ? Styles.colorFour
                      : Styles.colorThree,
                  weight: FontWeight.bold,
                ),
              ),
              MyText(
                discoverWorkoutCategory.description,
                maxLines: 3,
                textAlign: TextAlign.center,
                lineHeight: 1.1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
