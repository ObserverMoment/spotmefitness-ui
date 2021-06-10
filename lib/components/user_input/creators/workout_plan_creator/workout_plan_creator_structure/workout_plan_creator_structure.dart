import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_day_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_day_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
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
                workoutPlanDays: workoutPlanDaysByWeekNumber[i] ?? [],
              )),
    );
  }
}

class WorkoutPlanCreatorStructureWeek extends StatefulWidget {
  final List<WorkoutPlanDay> workoutPlanDays;
  final int weekNumber;
  const WorkoutPlanCreatorStructureWeek({
    Key? key,
    required this.workoutPlanDays,
    required this.weekNumber,
  }) : super(key: key);

  @override
  _WorkoutPlanCreatorStructureWeekState createState() =>
      _WorkoutPlanCreatorStructureWeekState();
}

class _WorkoutPlanCreatorStructureWeekState
    extends State<WorkoutPlanCreatorStructureWeek> {
  bool _minimizePlanDayCards = true;

  void _createWorkoutPlanDay(int dayNumber) {
    context.navigateTo(WorkoutFinderRoute(
        selectWorkout: (w) => context
            .read<WorkoutPlanCreatorBloc>()
            .createWorkoutPlanDay(widget.weekNumber * 7 + dayNumber, w)));
  }

  void _addWorkoutToPlanDay(int dayNumber) {
    context.navigateTo(WorkoutFinderRoute(
        selectWorkout: (w) => context
            .read<WorkoutPlanCreatorBloc>()
            .addWorkoutToDay(widget.weekNumber * 7 + dayNumber, w)));
  }

  void _deleteWorkoutPlanDay(int dayNumber) {
    context.showConfirmDialog(
        title: 'Make day ${dayNumber + 1} a rest day?',
        content: MyText(
          'Any workouts on this day will be removed.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () => context
            .read<WorkoutPlanCreatorBloc>()
            .deleteWorkoutPlanDay(widget.weekNumber * 7 + dayNumber));
  }

  void _movePlanDayToAnotherDay(int currentDayNumber) {
    context.push(
        child: WorkoutPlanDaySelector(
            message:
                'Note: This will overwrite anything that is on the day you are moving to.',
            workoutPlan: context.read<WorkoutPlanCreatorBloc>().workoutPlan,
            title: 'Move To Day',
            selectDayNumber: (moveToDayNumber) => print(moveToDayNumber)));
  }

  void _copyPlanDayToAnotherDay(int currentDayNumber) {
    context.push(
        child: WorkoutPlanDaySelector(
            message:
                'Note: This will overwrite anything that is on the day you are copying to.',
            workoutPlan: context.read<WorkoutPlanCreatorBloc>().workoutPlan,
            title: 'Copy To Day',
            selectDayNumber: (moveToDayNumber) => print(moveToDayNumber)));
  }

  bool _hasMultipleWorkouts(WorkoutPlanDay workoutPlanDay) =>
      workoutPlanDay.workoutPlanDayWorkouts.length > 1;

  @override
  Widget build(BuildContext context) {
    /// Must % 7 so that workouts in weeks higher than week 1 will get assigned to the correct day of that week.
    final byDayNumber =
        widget.workoutPlanDays.fold<Map<int, WorkoutPlanDay>>({}, (acum, next) {
      acum[next.dayNumber % 7] = next;
      return acum;
    });

    return Column(
      children: [
        HorizontalLine(),
        // https://stackoverflow.com/questions/51587003/how-to-center-only-one-element-in-a-row-of-2-elements-in-flutter
        Row(
          children: [
            Expanded(
                child: Center(
                    child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: H2('Week ${widget.weekNumber + 1}'),
            ))),
            CupertinoButton(
              onPressed: () => setState(
                  () => _minimizePlanDayCards = !_minimizePlanDayCards),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _minimizePlanDayCards
                  ? Icon(CupertinoIcons.eye)
                  : Icon(CupertinoIcons.eye_slash),
            )
          ],
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
                                  text: 'Move to day',
                                  icon: Icon(CupertinoIcons.calendar_today),
                                  onPressed: () =>
                                      _movePlanDayToAnotherDay(dayIndex)),
                              BottomSheetMenuItem(
                                  text: 'Copy to day',
                                  icon: Icon(CupertinoIcons.doc_on_doc),
                                  onPressed: () =>
                                      _copyPlanDayToAnotherDay(dayIndex)),
                              BottomSheetMenuItem(
                                  text: 'Convert to rest',
                                  icon:
                                      Icon(CupertinoIcons.calendar_badge_minus),
                                  onPressed: () =>
                                      _deleteWorkoutPlanDay(dayIndex)),
                              if (_hasMultipleWorkouts(byDayNumber[dayIndex]!))
                                BottomSheetMenuItem(
                                    text: 'Reorder workouts',
                                    icon: Icon(
                                        CupertinoIcons.arrow_up_arrow_down),
                                    onPressed: () => print('Reorder workouts')),
                              if (_hasMultipleWorkouts(byDayNumber[dayIndex]!))
                                BottomSheetMenuItem(
                                    text: 'Remove a workout',
                                    icon: Icon(
                                        CupertinoIcons.clear_thick_circled),
                                    onPressed: () => print('Remove a workout')),
                            ])),
                        child: WorkoutPlanDayCard(
                          workoutPlanDay: byDayNumber[dayIndex]!,
                          displayDayNumber: dayIndex,
                          minimize: _minimizePlanDayCards,
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
