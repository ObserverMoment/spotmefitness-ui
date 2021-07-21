import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_day_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_day_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:supercharged/supercharged.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutPlanCreatorStructure extends StatelessWidget {
  const WorkoutPlanCreatorStructure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numWeeks = context
        .select<WorkoutPlanCreatorBloc, int>((b) => b.workoutPlan.lengthWeeks);

    final workoutPlanDays =
        context.select<WorkoutPlanCreatorBloc, List<WorkoutPlanDay>>(
            (b) => b.workoutPlan.workoutPlanDays);

    final workoutPlanDaysByWeekNumber =
        workoutPlanDays.groupBy<int, WorkoutPlanDay>((d) => d.dayNumber ~/ 7);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView.builder(
          itemCount: numWeeks,
          itemBuilder: (c, i) => WorkoutPlanCreatorStructureWeek(
                weekNumber: i,
                workoutPlanDaysInWeek: workoutPlanDaysByWeekNumber[i] ?? [],
              )),
    );
  }
}

class WorkoutPlanCreatorStructureWeek extends StatefulWidget {
  final List<WorkoutPlanDay> workoutPlanDaysInWeek;
  final int weekNumber;
  const WorkoutPlanCreatorStructureWeek({
    Key? key,
    required this.workoutPlanDaysInWeek,
    required this.weekNumber,
  }) : super(key: key);

  @override
  _WorkoutPlanCreatorStructureWeekState createState() =>
      _WorkoutPlanCreatorStructureWeekState();
}

class _WorkoutPlanCreatorStructureWeekState
    extends State<WorkoutPlanCreatorStructureWeek> {
  bool _minimizePlanDayCards = true;

  int dayNumberFromDayIndex(int dayIndex) => widget.weekNumber * 7 + dayIndex;

  WorkoutPlanCreatorBloc get bloc => context.read<WorkoutPlanCreatorBloc>();

  void _createWorkoutPlanDay(int dayIndex) {
    context.navigateTo(WorkoutFinderRoute(
        selectWorkout: (w) => bloc.createWorkoutPlanDayWithWorkout(
            dayNumberFromDayIndex(dayIndex), w)));
  }

  void _addNoteToWorkoutPlanDay(int dayIndex, String note) {
    bloc.addNoteToWorkoutPlanDay(dayNumberFromDayIndex(dayIndex), note);
  }

  void _addWorkoutToPlanDay(int dayIndex) {
    context.navigateTo(WorkoutFinderRoute(
        selectWorkout: (w) => bloc.createWorkoutPlanDayWorkout(
            dayNumberFromDayIndex(dayIndex), w)));
  }

  /// Removes a [WorkoutPlanDayWorkout] from a [WorkoutPlanDay].
  void _deleteWorkoutPlanDayWorkout(
      int dayIndex, WorkoutPlanDayWorkout workoutPlanDayWorkout) {
    bloc.deleteWorkoutPlanDayWorkout(
        dayNumberFromDayIndex(dayIndex), workoutPlanDayWorkout);
  }

  /// Reordering [WorkoutPlanDayWorkouts] within a [WorkoutPlanDay].
  void _reorderPlanDayWorkoutsWithinDay(
      int dayIndex, int planDayWorkoutFromIndex, int planDayWorkoutToIndex) {
    bloc.reorderWorkoutPlanWorkoutsInDay(dayNumberFromDayIndex(dayIndex),
        planDayWorkoutFromIndex, planDayWorkoutToIndex);
  }

  void _addNoteToWorkoutPlanWorkout(
      int dayIndex, String note, WorkoutPlanDayWorkout workoutPlanDayWorkout) {
    bloc.addNoteToWorkoutPlanDayWorkout(
        dayNumberFromDayIndex(dayIndex), note, workoutPlanDayWorkout);
  }

  void _deleteWorkoutPlanDay(int dayIndex) {
    context.showConfirmDialog(
        title: 'Week ${widget.weekNumber + 1} day ${dayIndex + 1} -> Rest day?',
        content: MyText(
          'Any workouts on this day will be removed.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () =>
            bloc.deleteWorkoutPlanDay(dayNumberFromDayIndex(dayIndex)));
  }

  void _movePlanDayToAnotherDay(int dayIndex) {
    final currentDayNumber = dayNumberFromDayIndex(dayIndex);
    context.push(
        child: WorkoutPlanDaySelector(
            prevSelectedDay: currentDayNumber,
            message:
                'Move all from week ${widget.weekNumber + 1} day ${dayIndex + 1}. This will overwrite anything that is on the day you are moving to.',
            workoutPlan: bloc.workoutPlan,
            title: 'Move from Day ${currentDayNumber + 1}',
            selectDayNumber: (moveToDayNumber) =>
                bloc.moveWorkoutPlanDay(currentDayNumber, moveToDayNumber)));
  }

  void _copyPlanDayToAnotherDay(int dayIndex) {
    final currentDayNumber = dayNumberFromDayIndex(dayIndex);
    context.push(
        child: WorkoutPlanDaySelector(
            prevSelectedDay: currentDayNumber,
            message:
                'Copy all from week ${widget.weekNumber + 1} day ${dayIndex + 1}. This will overwrite anything that is on the day you are copying to.',
            workoutPlan: bloc.workoutPlan,
            title: 'Copy from Day ${currentDayNumber + 1}',
            selectDayNumber: (moveToDayNumber) =>
                bloc.copyWorkoutPlanDay(currentDayNumber, moveToDayNumber)));
  }

  @override
  Widget build(BuildContext context) {
    /// Must % 7 so that workouts in weeks higher than week 1 will get assigned to the correct day of their own week.
    final byDayNumber = widget.workoutPlanDaysInWeek
        .fold<Map<int, WorkoutPlanDay>>({}, (acum, next) {
      acum[next.dayNumber % 7] = next;
      return acum;
    });

    return Column(
      children: [
        HorizontalLine(),
        // https://stackoverflow.com/questions/51587003/how-to-center-only-one-element-in-a-row-of-2-elements-in-flutter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3('Week ${widget.weekNumber + 1}'),
              ShowHideDetailsButton(
                  onPressed: () => setState(
                      () => _minimizePlanDayCards = !_minimizePlanDayCards),
                  showDetails: !_minimizePlanDayCards)
            ],
          ),
        ),
        HorizontalLine(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (c, dayIndex) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: AnimatedSwitcher(
                duration: kStandardAnimationDuration,
                transitionBuilder: (widget, animation) => ScaleTransition(
                  scale: animation,
                  child: widget,
                ),
                child: byDayNumber[dayIndex] != null
                    ? GestureDetector(
                        onTap: () => context.showBottomSheet(
                            child: BottomSheetMenu(
                                header: BottomSheetMenuHeader(
                                  name: 'Workout Day ${dayIndex + 1}',
                                  subtitle: 'Week ${widget.weekNumber + 1}',
                                ),
                                items: [
                              BottomSheetMenuItem(
                                  text: 'Add workout',
                                  icon: Icon(CupertinoIcons.add_circled),
                                  onPressed: () =>
                                      _addWorkoutToPlanDay(dayIndex)),
                              BottomSheetMenuItem(
                                text: Utils.textNotNull(
                                        byDayNumber[dayIndex]!.note)
                                    ? 'Edit day note'
                                    : 'Add day note',
                                icon: Icon(CupertinoIcons.doc_plaintext),
                                onPressed: () => context.push(
                                    child: FullScreenTextEditing(
                                        title: 'Note',
                                        initialValue:
                                            byDayNumber[dayIndex]!.note,
                                        maxChars: 200,
                                        onSave: (note) =>
                                            _addNoteToWorkoutPlanDay(
                                                dayIndex, note),
                                        inputValidation: (t) => true)),
                              ),
                              BottomSheetMenuItem(
                                  text: 'Move to another day',
                                  icon: Icon(CupertinoIcons.calendar_today),
                                  onPressed: () =>
                                      _movePlanDayToAnotherDay(dayIndex)),
                              BottomSheetMenuItem(
                                  text: 'Copy to another day',
                                  icon: Icon(CupertinoIcons.doc_on_doc),
                                  onPressed: () =>
                                      _copyPlanDayToAnotherDay(dayIndex)),
                              BottomSheetMenuItem(
                                  text: 'Convert to rest day',
                                  icon:
                                      Icon(CupertinoIcons.calendar_badge_minus),
                                  onPressed: () =>
                                      _deleteWorkoutPlanDay(dayIndex)),
                            ])),
                        child: EditableWorkoutPlanDayCard(
                          workoutPlanDay: byDayNumber[dayIndex]!,
                          displayDayNumber: dayIndex,
                          minimize: _minimizePlanDayCards,
                          addNoteToWorkoutPlanDayWorkout:
                              (note, workoutPlanDayWorkout) =>
                                  _addNoteToWorkoutPlanWorkout(
                                      dayIndex, note, workoutPlanDayWorkout),
                          removeWorkoutPlanDayWorkout: (workoutPlanDayWorkout) {
                            _deleteWorkoutPlanDayWorkout(
                                dayIndex, workoutPlanDayWorkout);
                          },
                          reorderWorkoutPlanDayWorkouts: (from, to) =>
                              _reorderPlanDayWorkoutsWithinDay(
                                  dayIndex, from, to),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => _createWorkoutPlanDay(dayIndex),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            WorkoutPlanRestDayCard(
                              dayNumber: dayIndex,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.plus,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                MyText(
                                  'Workout',
                                  weight: FontWeight.bold,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
              )),
        ),
      ],
    );
  }
}
