import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class FreeSessionMovesList extends StatelessWidget {
  final WorkoutSection workoutSection;
  const FreeSessionMovesList({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText('Moves list'),
    );
  }
}
