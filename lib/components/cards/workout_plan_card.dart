import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const WorkoutPlanCard(this.workoutPlan);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              MyText('avatar'),
              MyText('name'),
              MyText('length'),
              MyText('difficulty level'),
            ],
          ),
        ],
      ),
    );
  }
}
