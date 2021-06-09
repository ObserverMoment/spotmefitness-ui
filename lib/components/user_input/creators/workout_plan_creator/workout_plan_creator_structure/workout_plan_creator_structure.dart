import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_day_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:supercharged/supercharged.dart';

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

class WorkoutPlanCreatorStructureWeek extends StatelessWidget {
  final List<WorkoutPlanDay> workoutPlanDays;
  final int weekNumber;
  const WorkoutPlanCreatorStructureWeek(
      {Key? key, required this.workoutPlanDays, required this.weekNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Must % 7 so that workouts in weeks higher than week 1 will get assigned to the correct day of that week.
    final byDayNumber =
        workoutPlanDays.fold<Map<int, WorkoutPlanDay>>({}, (acum, next) {
      acum[next.dayNumber % 7] = next;
      return acum;
    });

    return Column(
      children: [
        HorizontalLine(),
        H2('Week ${weekNumber + 1}'),
        HorizontalLine(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (c, dayIndex) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: AnimatedSwitcher(
                duration: kStandardAnimationDuration,
                transitionBuilder: (widget, animation) => ScaleTransition(
                  scale: animation,
                  child: widget,
                ),
                child: byDayNumber[dayIndex] != null
                    ? GestureDetector(
                        onTap: () => print(
                            'remove, swap, add notes (notes opens up note taker page for the day note and also individual workout notes'),
                        child: WorkoutPlanDayCard(
                          workoutPlanDay: byDayNumber[dayIndex]!,
                          displayDayNumber: dayIndex,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => context.navigateTo(WorkoutFinderRoute(
                            selectWorkout: (w) => context
                                .read<WorkoutPlanCreatorBloc>()
                                .createWorkoutPlanDay(
                                    weekNumber * 7 + dayIndex, w))),
                        child: WorkoutPlanRestDayCard(
                          dayNumber: dayIndex,
                        ),
                      ),
              )),
        ),
      ],
    );
  }
}
