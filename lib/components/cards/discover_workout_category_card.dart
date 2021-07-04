import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
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
    return Card(
      height: 180,
      backgroundImageUri: discoverWorkoutCategory.coverImageUri,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                discoverWorkoutCategory.name,
                size: FONTSIZE.BIG,
                weight: FontWeight.bold,
              ),
              MyText(
                discoverWorkoutCategory.tagline,
                color: context.theme.brightness == Brightness.dark
                    ? Styles.colorFour
                    : Styles.colorThree,
                weight: FontWeight.bold,
              ),
            ],
          ),
          MyText(
            discoverWorkoutCategory.description,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
