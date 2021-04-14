import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutSetDisplay extends StatelessWidget {
  final WorkoutSet workoutSet;
  final bool scrollable;
  WorkoutSetDisplay(this.workoutSet, {this.scrollable = false});
  @override
  Widget build(BuildContext context) {
    final List<WorkoutMove> _sortedMoves =
        workoutSet.workoutMoves.sortedBy<num>((wm) => wm.sortPosition);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (workoutSet.rounds > 1)
                MyText('Repeat ${workoutSet.rounds} times'),
            ],
          ),
          ListView.builder(
              physics: scrollable ? null : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _sortedMoves.length,
              itemBuilder: (context, index) => WorkoutMoveDisplay(
                    _sortedMoves[index],
                    isLast: index == _sortedMoves.length - 1,
                  ))
        ],
      ),
    );
  }
}
