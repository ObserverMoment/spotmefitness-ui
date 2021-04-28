import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class CommaSeparatedMovesList extends StatelessWidget {
  final List<WorkoutMove> workoutMoves;
  CommaSeparatedMovesList(this.workoutMoves);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1,
      runSpacing: 1,
      children: workoutMoves
          .asMap()
          .map((index, wm) => MapEntry(
              index,
              MyText(
                index == workoutMoves.length - 1
                    ? '${wm.move.name}.'
                    : '${wm.move.name}, ',
                size: FONTSIZE.SMALL,
              )))
          .values
          .toList(),
    );
  }
}
