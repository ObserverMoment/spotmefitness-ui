import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
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
  final bool minimize;
  final bool openWorkoutDetailsOnTap;
  const WorkoutPlanDayCard(
      {Key? key,
      required this.workoutPlanDay,
      required this.displayDayNumber,
      this.minimize = false,
      this.openWorkoutDetailsOnTap = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutPlanDayWorkouts = workoutPlanDay.workoutPlanDayWorkouts
        .sortedBy<num>((d) => d.sortPosition)
        .toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3(' Day ${displayDayNumber + 1}'),
          if (Utils.textNotNull(workoutPlanDay.note))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: MyText(
                workoutPlanDay.note!,
                subtext: true,
              ),
            ),
          SizedBox(height: 3),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedWorkoutPlanDayWorkouts.length,
              separatorBuilder: (c, i) => HorizontalLine(),
              itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Utils.textNotNull(
                            sortedWorkoutPlanDayWorkouts[i].note))
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: MyText(
                              sortedWorkoutPlanDayWorkouts[i].note!,
                              color: Styles.infoBlue,
                            ),
                          ),
                        GestureDetector(
                          onTap: openWorkoutDetailsOnTap
                              ? () => context.navigateTo(WorkoutDetailsRoute(
                                  id: sortedWorkoutPlanDayWorkouts[i]
                                      .workout
                                      .id))
                              : null,
                          child: WorkoutCard(
                            sortedWorkoutPlanDayWorkouts[i].workout,
                            withBoxShadow: false,
                            hideBackgroundImage: true,
                            padding: const EdgeInsets.all(0),
                            showCreatedBy: false,
                            showEquipment: !minimize,
                            showMoves: !minimize,
                            showTags: !minimize,
                            showDescription: !minimize,
                          ),
                        ),
                      ],
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
  final bool minimize;
  final void Function(WorkoutPlanDayWorkout w) removeWorkoutPlanDayWorkout;
  final void Function(int from, int to) reorderWorkoutPlanDayWorkouts;
  final void Function(String note, WorkoutPlanDayWorkout w)
      addNoteToWorkoutPlanDayWorkout;

  const EditableWorkoutPlanDayCard(
      {Key? key,
      required this.workoutPlanDay,
      required this.displayDayNumber,
      this.minimize = false,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3(' Day ${displayDayNumber + 1}'),
          if (Utils.textNotNull(workoutPlanDay.note))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: MyText(
                workoutPlanDay.note!,
                subtext: true,
              ),
            ),
          SizedBox(height: 3),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedWorkoutPlanDayWorkouts.length,
              separatorBuilder: (c, i) => HorizontalLine(),
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
                      IconSlideAction(
                        caption: 'Note',
                        icon: CupertinoIcons.doc_plaintext,
                        onTap: () => context.push(
                            child: FullScreenTextEditing(
                                title: 'Note',
                                initialValue:
                                    sortedWorkoutPlanDayWorkouts[i].note,
                                onSave: (note) =>
                                    addNoteToWorkoutPlanDayWorkout(
                                        note, sortedWorkoutPlanDayWorkouts[i]),
                                maxChars: 200,
                                inputValidation: (t) => true)),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Utils.textNotNull(
                              sortedWorkoutPlanDayWorkouts[i].note))
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: MyText(
                                sortedWorkoutPlanDayWorkouts[i].note!,
                                color: Styles.infoBlue,
                              ),
                            ),
                          WorkoutCard(
                            sortedWorkoutPlanDayWorkouts[i].workout,
                            withBoxShadow: false,
                            hideBackgroundImage: true,
                            padding: const EdgeInsets.all(0),
                            showCreatedBy: false,
                            showEquipment: !minimize,
                            showMoves: !minimize,
                            showTags: !minimize,
                            showDescription: !minimize,
                          ),
                        ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          H3(' Day ${dayNumber + 1}'),
          H3('Rest'),
        ],
      ),
    );
  }
}
