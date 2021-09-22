import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/cards/workout_plan_day_card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/generated/api/graphql_api.graphql.dart';
import 'package:supercharged/supercharged.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4),
        child: WorkoutPlanWeekWorkouts(
          workoutPlanDays: daysByWeek[i] ?? [],
          weekNumber: i,
        ),
      ),
      separatorBuilder: (c, i) => const HorizontalLine(),
    );
  }
}

class WorkoutPlanWeekWorkouts extends StatefulWidget {
  final int weekNumber;
  final List<WorkoutPlanDay> workoutPlanDays;
  const WorkoutPlanWeekWorkouts(
      {Key? key, required this.weekNumber, required this.workoutPlanDays})
      : super(key: key);

  @override
  _WorkoutPlanWeekWorkoutsState createState() =>
      _WorkoutPlanWeekWorkoutsState();
}

class _WorkoutPlanWeekWorkoutsState extends State<WorkoutPlanWeekWorkouts> {
  @override
  Widget build(BuildContext context) {
    /// Must % 7 so that workouts in weeks higher than week 1 will get assigned to the correct day of that week.
    final byDayNumberInWeek =
        widget.workoutPlanDays.fold<Map<int, WorkoutPlanDay>>({}, (acum, next) {
      acum[next.dayNumber % 7] = next;
      return acum;
    });

    return Column(
      children: [
        // https://stackoverflow.com/questions/51587003/how-to-center-only-one-element-in-a-row-of-2-elements-in-flutter
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: H3('Week ${widget.weekNumber + 1}')),
            ],
          ),
        ),
        const HorizontalLine(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (c, i) => byDayNumberInWeek[i] != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: WorkoutPlanDayCard(
                    workoutPlanDay: byDayNumberInWeek[i]!,
                    displayDayNumber: i,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Opacity(
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
