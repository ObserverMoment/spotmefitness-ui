import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutSectionCard extends StatelessWidget {
  final WorkoutSection workoutSection;
  const WorkoutSectionCard({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkoutSectionTypeTag(
          workoutSection: workoutSection,
          fontSize: FONTSIZE.BIG,
          withBorder: false,
        ),
      ],
    );
  }
}
