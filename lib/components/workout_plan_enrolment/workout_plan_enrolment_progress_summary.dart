import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutPlanEnrolmentProgressSummary extends StatelessWidget {
  final WorkoutPlanEnrolment workoutPlanEnrolment;
  const WorkoutPlanEnrolmentProgressSummary(
      {Key? key, required this.workoutPlanEnrolment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = workoutPlanEnrolment.workoutPlan.workoutPlanDays.fold<int>(
        0, (acum, nextDay) => acum + nextDay.workoutPlanDayWorkouts.length);

    final completed = workoutPlanEnrolment.completedPlanDayWorkoutIds.length;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                'Started on',
                size: FONTSIZE.TINY,
                lineHeight: 1.5,
              ),
              MyText(
                workoutPlanEnrolment.startDate.compactDateString,
              ),
            ],
          ),
        ),
        if (total > 0)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyText(
                        '$completed of $total workouts complete',
                        size: FONTSIZE.SMALL,
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  LinearPercentIndicator(
                    percent: completed / total,
                    lineHeight: 4,
                    padding: const EdgeInsets.only(left: 8),
                    backgroundColor: context.theme.primary.withOpacity(0.3),
                    progressColor: Styles.peachRed,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
