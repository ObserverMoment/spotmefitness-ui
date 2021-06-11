import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_day_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
        child: WorkoutPlanWeekWorkouts(
          workoutPlanDays: daysByWeek[i] ?? [],
          weekNumber: i,
        ),
      ),
      separatorBuilder: (c, i) => HorizontalLine(),
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
  bool _minimizePlanDayCards = true;

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
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
        ),
        HorizontalLine(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (c, i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: byDayNumberInWeek[i] != null
                ? WorkoutPlanDayCard(
                    workoutPlanDay: byDayNumberInWeek[i]!,
                    displayDayNumber: i,
                    minimize: _minimizePlanDayCards,
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
