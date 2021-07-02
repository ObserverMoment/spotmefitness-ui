import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DiscoverWorkoutPlanCategoryCard extends StatelessWidget {
  final DiscoverWorkoutPlanCategory discoverWorkoutPlanCategory;
  const DiscoverWorkoutPlanCategoryCard(
      {Key? key, required this.discoverWorkoutPlanCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      height: 180,
      backgroundImageUri: discoverWorkoutPlanCategory.coverImageUri,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                discoverWorkoutPlanCategory.name,
                size: FONTSIZE.BIG,
                weight: FontWeight.bold,
              ),
              MyText(
                discoverWorkoutPlanCategory.tagline,
                color: context.theme.brightness == Brightness.dark
                    ? Styles.colorFour
                    : Styles.colorThree,
                weight: FontWeight.bold,
              ),
            ],
          ),
          MyText(
            discoverWorkoutPlanCategory.description,
            maxLines: 3,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
