import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_day_card.dart';
import 'package:spotmefitness_ui/components/creators/scheduled_workout_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/toast_request.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:supercharged/supercharged.dart';
import 'package:collection/collection.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutPlanEnrolmentWorkoutsProgress extends StatelessWidget {
  final WorkoutPlanEnrolment workoutPlanEnrolment;
  const WorkoutPlanEnrolmentWorkoutsProgress(
      {Key? key, required this.workoutPlanEnrolment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutPlan = workoutPlanEnrolment.workoutPlan;

    /// Zero index - week '1' is at daysByWeek[0].
    final daysByWeek = workoutPlan.workoutPlanDays
        .groupBy<int, WorkoutPlanDay>((day) => (day.dayNumber / 7).floor());

    return ListView.separated(
      shrinkWrap: true,
      itemCount: workoutPlan.lengthWeeks,
      itemBuilder: (c, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
        child: WorkoutPlanEnrolmentWorkoutsWeek(
            workoutPlanDaysInWeek: daysByWeek[i] ?? [],
            weekNumber: i,
            workoutPlanEnrolment: workoutPlanEnrolment),
      ),
      separatorBuilder: (c, i) => HorizontalLine(),
    );
  }
}

class WorkoutPlanEnrolmentWorkoutsWeek extends StatefulWidget {
  final WorkoutPlanEnrolment workoutPlanEnrolment;
  final int weekNumber;
  final List<WorkoutPlanDay> workoutPlanDaysInWeek;
  const WorkoutPlanEnrolmentWorkoutsWeek(
      {Key? key,
      required this.weekNumber,
      required this.workoutPlanDaysInWeek,
      required this.workoutPlanEnrolment})
      : super(key: key);

  @override
  _WorkoutPlanEnrolmentWorkoutsWeekState createState() =>
      _WorkoutPlanEnrolmentWorkoutsWeekState();
}

class _WorkoutPlanEnrolmentWorkoutsWeekState
    extends State<WorkoutPlanEnrolmentWorkoutsWeek> {
  @override
  Widget build(BuildContext context) {
    /// Must % 7 so that workouts in weeks higher than week 1 will get assigned to the correct day of that week.
    final byDayNumberInWeek = widget.workoutPlanDaysInWeek
        .fold<Map<int, WorkoutPlanDay>>({}, (acum, next) {
      acum[next.dayNumber % 7] = next;
      return acum;
    });

    return Column(
      children: [
        // https://stackoverflow.com/questions/51587003/how-to-center-only-one-element-in-a-row-of-2-elements-in-flutter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3('Week ${widget.weekNumber + 1}'),
            ],
          ),
        ),
        HorizontalLine(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (c, i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: byDayNumberInWeek[i] != null
                ? _WorkoutPlanEnrolmentDayCard(
                    workoutPlanDay: byDayNumberInWeek[i]!,
                    displayDayNumber: i,
                    workoutPlanEnrolment: widget.workoutPlanEnrolment,
                  )
                : Opacity(
                    opacity: 0.35,
                    child: WorkoutPlanRestDayCard(
                      dayNumber: i,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _WorkoutPlanEnrolmentDayCard extends StatelessWidget {
  /// Zero indexed.
  final int displayDayNumber;
  final WorkoutPlanDay workoutPlanDay;
  final WorkoutPlanEnrolment workoutPlanEnrolment;
  const _WorkoutPlanEnrolmentDayCard(
      {Key? key,
      required this.workoutPlanDay,
      required this.displayDayNumber,
      required this.workoutPlanEnrolment})
      : super(key: key);

  Future<void> _openScheduleWorkout(
      BuildContext context, WorkoutPlanDayWorkout workoutPlanDayWorkout) async {
    final result = await context.showBottomSheet(
        showDragHandle: false,
        useRootNavigator: true,
        child: ScheduledWorkoutCreator(
          workout: workoutPlanDayWorkout.workout,
          workoutPlanEnrolmentId: workoutPlanEnrolment.id,
        ));
    if (result is ToastRequest) {
      context.showToast(message: result.message, toastType: result.type);
    }
  }

  Future<void> _handleLogWorkoutProgramWorkout(
      BuildContext context, WorkoutPlanDayWorkout planDayWorkout) async {
    await context
        .pushRoute(LoggedWorkoutCreatorRoute(workout: planDayWorkout.workout));

    /// Note: Currently there is no automated marking of workouts as done.
    /// This is because only the Plan -> Log flow can be implemented in a sensible was at the moment.
    /// The below is disabled pending further research on how to manage these flows.
    /// All Flows
    // Log (Directly from view workout)
    // Do -> Log
    // Schedule -> Log
    // Schedule -> Do -> Log
    // PlanEnrolment -> Log
    // PlanEnrolment -> Do -> Log
    // PlanEnrolment -> Schedule -> Log
    // PlanEnrolment -> Schedule -> Do -> Log

    // if (success != null && success == true) {
    //   if (!workoutPlanEnrolment.completedPlanDayWorkoutIds
    //       .contains(planDayWorkout.id)) {
    //     workoutPlanEnrolment.completedPlanDayWorkoutIds.add(planDayWorkout.id);
    //     _updateCompletedWorkoutIds(
    //         context, workoutPlanEnrolment.completedPlanDayWorkoutIds);
    //   }
    // }
  }

  Future<void> _updateCompletedWorkoutIds(
      BuildContext context, List<String> updatedIds) async {
    final variables = UpdateWorkoutPlanEnrolmentArguments(
        data: UpdateWorkoutPlanEnrolmentInput(id: workoutPlanEnrolment.id));

    final result = await context.graphQLStore.mutate<
            UpdateWorkoutPlanEnrolment$Mutation,
            UpdateWorkoutPlanEnrolmentArguments>(
        mutation: UpdateWorkoutPlanEnrolmentMutation(variables: variables),
        broadcastQueryIds: [
          GQLVarParamKeys.userWorkoutPlanEnrolmentById(workoutPlanEnrolment.id),
          UserWorkoutPlanEnrolmentsQuery().operationName,
        ],
        customVariablesMap: {
          'data': {
            'id': workoutPlanEnrolment.id,
            'completedPlanDayWorkoutIds': updatedIds
          }
        });

    if (result.hasErrors) {
      context.showErrorAlert('Something went wrong, the update did not work.');
    } else {
      context.showToast(message: 'Workout status updated');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutPlanDayWorkouts = workoutPlanDay.workoutPlanDayWorkouts
        .sortedBy<num>((d) => d.sortPosition)
        .toList();

    final completedIds = workoutPlanEnrolment.completedPlanDayWorkoutIds;

    final dayComplete =
        sortedWorkoutPlanDayWorkouts.every((w) => completedIds.contains(w.id));

    return Card(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyHeaderText('Day ${displayDayNumber + 1}'),
                if (dayComplete)
                  FadeIn(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        MyText(
                          'Day Complete',
                          size: FONTSIZE.TINY,
                          color: Styles.peachRed,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          color: Styles.peachRed,
                        )
                      ],
                    ),
                  ))
              ],
            ),
          ),
          if (Utils.textNotNull(workoutPlanDay.note))
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
              child: MyText(
                workoutPlanDay.note!,
                size: FONTSIZE.SMALL,
              ),
            ),
          SizedBox(height: 3),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedWorkoutPlanDayWorkouts.length,
              separatorBuilder: (c, i) => HorizontalLine(),
              itemBuilder: (c, i) {
                final dayWorkout = sortedWorkoutPlanDayWorkouts[i];
                final workoutCompleted = completedIds.contains(dayWorkout.id);
                return GestureDetector(
                  onTap: () => context.showBottomSheet(
                      child: BottomSheetMenu(
                          header: BottomSheetMenuHeader(
                            name: dayWorkout.workout.name,
                            subtitle: 'Day ${displayDayNumber + 1}',
                            imageUri: dayWorkout.workout.coverImageUri,
                          ),
                          items: [
                        workoutCompleted
                            ? BottomSheetMenuItem(
                                text: 'Unmark as done',
                                icon: Icon(CupertinoIcons.clear_thick),
                                onPressed: () => _updateCompletedWorkoutIds(
                                    context,
                                    completedIds.toggleItem(dayWorkout.id)))
                            : BottomSheetMenuItem(
                                text: 'Mark as done',
                                icon: Icon(CupertinoIcons.checkmark_alt),
                                onPressed: () => _updateCompletedWorkoutIds(
                                    context,
                                    completedIds.toggleItem(dayWorkout.id))),
                        if (!workoutCompleted) ...[
                          BottomSheetMenuItem(
                            text: 'Do it',
                            icon: Icon(CupertinoIcons.arrow_right_square),
                            onPressed: () =>
                                context.navigateTo(DoWorkoutWrapperRoute(
                              id: dayWorkout.workout.id,
                            )),
                          ),
                          BottomSheetMenuItem(
                              text: 'Log it',
                              icon: Icon(CupertinoIcons.doc_plaintext),
                              onPressed: () => _handleLogWorkoutProgramWorkout(
                                  context, dayWorkout)),
                          BottomSheetMenuItem(
                              text: 'Schedule it',
                              icon: Icon(CupertinoIcons.calendar_badge_plus),
                              onPressed: () =>
                                  _openScheduleWorkout(context, dayWorkout)),
                        ],
                        BottomSheetMenuItem(
                            text: 'View workout',
                            icon: Icon(CupertinoIcons.eye),
                            onPressed: () => context.navigateTo(
                                WorkoutDetailsRoute(
                                    id: dayWorkout.workout.id))),
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Utils.textNotNull(dayWorkout.note))
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 16, right: 16),
                            child: MyHeaderText(
                              dayWorkout.note!,
                              color: Styles.infoBlue,
                              size: FONTSIZE.SMALL,
                            ),
                          ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            WorkoutCard(
                              dayWorkout.workout,
                              withBoxShadow: false,
                              backgroundColor: context.theme.background,
                            ),
                            if (completedIds.contains(dayWorkout.id))
                              FadeIn(
                                  child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: Styles.peachRed.withOpacity(1),
                                ),
                              )),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
