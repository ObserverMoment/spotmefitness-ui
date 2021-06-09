import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_day_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:supercharged/supercharged.dart';
import 'package:collection/collection.dart';

class WorkoutPlanWorkoutSchedule extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const WorkoutPlanWorkoutSchedule({Key? key, required this.workoutPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Zero index - week '1' is at daysByWeek[0].
    final daysByWeek = workoutPlan.workoutPlanDays
        .groupBy<int, WorkoutPlanDay>((day) => (day.dayNumber / 7).floor());

    return ListView.separated(
      shrinkWrap: true,
      itemCount: workoutPlan.lengthWeeks,
      itemBuilder: (c, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
        child: WorkoutPlanWeekWorkouts(
          workoutPlanDays: daysByWeek[i] ?? [],
          weekNumber: i + 1,
        ),
      ),
      separatorBuilder: (c, i) => HorizontalLine(),
    );
  }
}

class WorkoutPlanWeekWorkouts extends StatelessWidget {
  final int weekNumber;
  final List<WorkoutPlanDay> workoutPlanDays;
  const WorkoutPlanWeekWorkouts(
      {Key? key, required this.weekNumber, required this.workoutPlanDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Must % 7 so that workouts in weeks higher than week 1 will get assigned to the correct day of that week.
    final byDayNumberInWeek =
        workoutPlanDays.fold<Map<int, WorkoutPlanDay>>({}, (acum, next) {
      acum[next.dayNumber % 7] = next;
      return acum;
    });

    return Column(
      children: [
        H2('Week $weekNumber'),
        HorizontalLine(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (c, i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
            child: byDayNumberInWeek[i] != null
                ? WorkoutPlanDayCard(
                    workoutPlanDay: byDayNumberInWeek[i]!,
                    displayDayNumber: i,
                  )
                : WorkoutPlanRestDayCard(
                    dayNumber: i,
                  ),
          ),
        ),
      ],
    );
  }
}
