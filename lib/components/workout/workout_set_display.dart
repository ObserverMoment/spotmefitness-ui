import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/workout/move_details.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display_header.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

class WorkoutSetDisplay extends StatelessWidget {
  final WorkoutSet workoutSet;
  final WorkoutSectionType workoutSectionType;
  final bool scrollable;
  WorkoutSetDisplay(
      {required this.workoutSet,
      required this.workoutSectionType,
      this.scrollable = false});
  @override
  Widget build(BuildContext context) {
    final List<WorkoutMove> sortedMoves =
        workoutSet.workoutMoves.sortedBy<num>((wm) => wm.sortPosition);

    /// Don't show reps if it is a tabata, or if it is a HIIT Circuit with only one move in the set ('station')
    /// If HIIT Circuit has more than one move in the station then we need to show reps as as the user will loop around these moves for the time specified.
    final showReps = !((workoutSectionType.name == kTabataName) ||
        (workoutSectionType.name == kHIITCircuitName &&
            workoutSet.workoutMoves.length == 1));

    return Card(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: WorkoutSetDisplayHeader(
              workoutSet: workoutSet,
              workoutSectionType: workoutSectionType,
            ),
          ),
          if (sortedMoves.isNotEmpty && !workoutSet.isRestSet)
            Flexible(
              child: ListView(
                physics: scrollable ? null : NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: sortedMoves
                    .map((wm) => GestureDetector(
                          onTap: () => context.push(
                              fullscreenDialog: true,
                              child: MoveDetails(wm.move)),
                          child: WorkoutMoveDisplay(
                            wm,
                            isLast: wm.sortPosition == sortedMoves.length - 1,
                            showReps: showReps,
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
