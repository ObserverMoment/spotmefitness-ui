import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/data_vis/waffle_chart.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';

class WorkoutPlanGoals extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const WorkoutPlanGoals({Key? key, required this.workoutPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Zero index - week '1' is at daysByWeek[0].
    final daysByWeek = workoutPlan.workoutPlanDays
        .groupBy<int, WorkoutPlanDay>((day) => (day.dayNumber / 7).floor());

    return Container(
      child: ListView.builder(
        itemCount: workoutPlan.lengthWeeks,
        itemBuilder: (c, i) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: WorkoutPlanWeek(
            workoutPlanDays: daysByWeek[i] ?? [],
            weekNumber: i + 1,
          ),
        ),
      ),
    );
  }
}

class WorkoutPlanWeek extends StatelessWidget {
  final int weekNumber;
  final List<WorkoutPlanDay> workoutPlanDays;
  const WorkoutPlanWeek(
      {Key? key, required this.workoutPlanDays, required this.weekNumber})
      : super(key: key);

  List<WaffleChartInput> calcInputs(List<WorkoutGoal> goals) {
    final data = goals.fold<Map<WorkoutGoal, int>>({}, (acum, next) {
      if (acum[next] != null) {
        acum[next] = acum[next]! + 1;
      } else {
        acum[next] = 1;
      }
      return acum;
    });

    return data.entries
        .map((e) => WaffleChartInput(
            fraction: e.value / goals.length,
            color: HexColor.fromHex(e.key.hexColor),
            name: e.key.name))
        .toList();
  }

  List<WorkoutGoal> getAllGoals() {
    return workoutPlanDays.fold<List<WorkoutGoal>>(
        [],
        (acum1, nextDay) => [
              ...acum1,
              ...nextDay.workoutPlanDayWorkouts.fold(
                  [],
                  (acum2, nextDayWorkout) =>
                      nextDayWorkout.workout.workoutGoals)
            ]);
  }

  List<WorkoutTag> getAllTags() {
    return workoutPlanDays
        .fold<List<WorkoutTag>>(
            [],
            (acum1, nextDay) => [
                  ...acum1,
                  ...nextDay.workoutPlanDayWorkouts.fold(
                      [],
                      (acum2, nextDayWorkout) =>
                          nextDayWorkout.workout.workoutTags)
                ])
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final allGoals = getAllGoals();
    final allTags = getAllTags();

    return Card(
      child: Column(
        children: [
          H3('Week $weekNumber'),
          SizedBox(height: 8),
          allGoals.isEmpty
              ? Center(child: MyText('No goals specified...'))
              : WaffleChartRow(inputs: calcInputs(allGoals), height: 60),
          if (allTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 6),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: allTags
                    .map(
                      (tag) => Tag(
                        tag: tag.tag,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
