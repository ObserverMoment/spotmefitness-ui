import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutPlanDayCard extends StatelessWidget {
  /// Can be either the abolute day = i.e. day 15 of the workout, or the relative day, i.e. day 2 or of the week.
  /// Zero indexed.
  final int displayDayNumber;
  final WorkoutPlanDay workoutPlanDay;
  final bool openWorkoutDetailsOnTap;
  const WorkoutPlanDayCard(
      {Key? key,
      required this.workoutPlanDay,
      required this.displayDayNumber,
      this.openWorkoutDetailsOnTap = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutPlanDayWorkouts = workoutPlanDay.workoutPlanDayWorkouts
        .sortedBy<num>((d) => d.sortPosition)
        .toList();

    return Card(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 9.0, right: 9, top: 9, bottom: 6),
            child: MyHeaderText(
              'Day ${displayDayNumber + 1}',
            ),
          ),
          if (Utils.textNotNull(workoutPlanDay.note))
            Padding(
              padding: const EdgeInsets.only(left: 9, right: 9, bottom: 8),
              child: MyText(
                workoutPlanDay.note!,
                size: FONTSIZE.SMALL,
              ),
            ),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedWorkoutPlanDayWorkouts.length,
              separatorBuilder: (c, i) => HorizontalLine(),
              itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: openWorkoutDetailsOnTap
                          ? () => context.navigateTo(WorkoutDetailsRoute(
                              id: sortedWorkoutPlanDayWorkouts[i].workout.id))
                          : null,
                      child: MinimalWorkoutCard(
                        sortedWorkoutPlanDayWorkouts[i].workout,
                        withBoxShadow: false,
                        padding: EdgeInsets.zero,
                        backgroundColor: context.theme.background,
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}

/// Allows the [workoutPlanDayWorkouts] within the [WorkoutPlanDay] to be edited.
/// They can be removed, reordered or have notes added to them.
/// Clicking a workout does not navigator or the [WorkoutDetailsRoute], unlike the standard [WorkoutPlanDayCard].
class EditableWorkoutPlanDayCard extends StatelessWidget {
  /// Can be either the abolute day = i.e. day 15 of the workout, or the relative day, i.e. day 2 or of the week.
  /// Zero indexed.
  final int displayDayNumber;
  final WorkoutPlanDay workoutPlanDay;
  final void Function(WorkoutPlanDayWorkout w) removeWorkoutPlanDayWorkout;
  final void Function(int from, int to) reorderWorkoutPlanDayWorkouts;
  final void Function(String note, WorkoutPlanDayWorkout w)
      addNoteToWorkoutPlanDayWorkout;

  const EditableWorkoutPlanDayCard(
      {Key? key,
      required this.workoutPlanDay,
      required this.displayDayNumber,
      required this.removeWorkoutPlanDayWorkout,
      required this.reorderWorkoutPlanDayWorkouts,
      required this.addNoteToWorkoutPlanDayWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutPlanDayWorkouts = workoutPlanDay.workoutPlanDayWorkouts
        .sortedBy<num>((d) => d.sortPosition)
        .toList();

    return Card(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 9.0, right: 9, top: 9, bottom: 6),
            child: MyHeaderText('Day ${displayDayNumber + 1}'),
          ),
          if (Utils.textNotNull(workoutPlanDay.note))
            Padding(
              padding: const EdgeInsets.only(left: 9, right: 9, bottom: 8),
              child: MyText(
                workoutPlanDay.note!,
                subtext: true,
                lineHeight: 1.4,
                maxLines: 3,
              ),
            ),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedWorkoutPlanDayWorkouts.length,
              separatorBuilder: (c, i) => HorizontalLine(
                    verticalPadding: 10,
                  ),
              itemBuilder: (c, i) => AnimatedSlidable(
                    key: Key(
                        'EditableWorkoutPlanDayCard - ${sortedWorkoutPlanDayWorkouts[i].id}'),
                    index: i,
                    itemType: 'Workout',
                    verb: 'Remove',
                    removeItem: (removeAtIndex) => removeWorkoutPlanDayWorkout(
                        sortedWorkoutPlanDayWorkouts[removeAtIndex]),
                    secondaryActions: [
                      if (i != 0)
                        IconSlideAction(
                          caption: 'Move up',
                          icon: CupertinoIcons.arrow_up_circle,
                          onTap: () => reorderWorkoutPlanDayWorkouts(i, i - 1),
                        ),
                      if (i != sortedWorkoutPlanDayWorkouts.length - 1)
                        IconSlideAction(
                          caption: 'Move down',
                          icon: CupertinoIcons.arrow_down_circle,
                          onTap: () => reorderWorkoutPlanDayWorkouts(i, i + 1),
                        ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: MinimalWorkoutCard(
                        sortedWorkoutPlanDayWorkouts[i].workout,
                        withBoxShadow: false,
                        padding: EdgeInsets.zero,
                        backgroundColor: context.theme.background,
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}

class WorkoutPlanRestDayCard extends StatelessWidget {
  /// Zero indexed.
  final int dayNumber;
  const WorkoutPlanRestDayCard({Key? key, required this.dayNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      withBoxShadow: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            ' Day ${dayNumber + 1}',
            size: FONTSIZE.SMALL,
          ),
          MyText(
            'Rest',
            size: FONTSIZE.SMALL,
          ),
        ],
      ),
    );
  }
}
