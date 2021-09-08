import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutSetWorkoutMove extends StatelessWidget {
  final Key key;
  final double height;
  final WorkoutMove workoutMove;
  final void Function(WorkoutMove workoutMove) openEditWorkoutMove;
  final void Function(int index) duplicateWorkoutMove;
  final void Function(int index) deleteWorkoutMove;
  final bool isLast;
  final bool showReps;
  WorkoutSetWorkoutMove(
      {required this.key,
      required this.workoutMove,
      required this.openEditWorkoutMove,
      required this.duplicateWorkoutMove,
      required this.deleteWorkoutMove,
      this.height = kWorkoutMoveListItemHeight,
      this.showReps = true,
      this.isLast = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openEditWorkoutMove(workoutMove),
      child: SizedBox(
        height: height,
        child: AnimatedSlidable(
          key: key,
          index: workoutMove.sortPosition,
          itemType: 'Move',
          removeItem: deleteWorkoutMove,
          secondaryActions: [
            IconSlideAction(
              caption: 'Duplicate',
              color: Styles.infoBlue,
              iconWidget: Icon(
                CupertinoIcons.doc_on_doc,
                size: 20,
              ),
              onTap: () => duplicateWorkoutMove(workoutMove.sortPosition),
            ),
          ],
          child: WorkoutMoveDisplay(
            workoutMove,
            isLast: isLast,
            showReps: showReps,
          ),
        ),
      ),
    );
  }
}
