import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
                size: FONTSIZE.SMALL,
              ),
              MyText(
                workoutPlanEnrolment.startDate.compactDateString,
                weight: FontWeight.bold,
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
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  StepProgressIndicator(
                    totalSteps: total,
                    currentStep: completed,
                    size: 6,
                    padding: 0,
                    selectedColor: Styles.peachRed,
                    unselectedColor: context.theme.primary.withOpacity(0.3),
                    roundedEdges: Radius.circular(16),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
