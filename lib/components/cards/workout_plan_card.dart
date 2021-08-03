import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/data_vis/percentage_bar_chart.dart';
import 'package:spotmefitness_ui/components/data_vis/waffle_chart.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_enrolments_summary.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_reviews_summary.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  final Color? backgroundColor;
  final bool withBoxShadow;

  const WorkoutPlanCard(
    this.workoutPlan, {
    this.backgroundColor,
    this.withBoxShadow = true,
  });

  List<WaffleChartInput> calcInputs() {
    final goals = workoutPlan.workoutGoalsInPlan;
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

  @override
  Widget build(BuildContext context) {
    return Card(
        backgroundColor: backgroundColor,
        withBoxShadow: withBoxShadow,
        padding: EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    workoutPlan.coverImageUri != null
                        ? SizedUploadcareImage(workoutPlan.coverImageUri!)
                        : Image.asset(
                            'assets/home_page_images/home_page_plans.jpg',
                            fit: BoxFit.cover,
                          ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.background.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (workoutPlan.workoutPlanDays.isNotEmpty &&
                                  workoutPlan.calcDifficulty != null)
                                DifficultyLevelTag(workoutPlan.calcDifficulty!),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Row(
                                  children: [
                                    Card(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      child: MyText(
                                        workoutPlan.lengthString,
                                        size: FONTSIZE.SMALL,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Card(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: MyText(
                                          '${workoutPlan.daysPerWeek} days / week',
                                          size: FONTSIZE.SMALL,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            child: WorkoutPlanReviewsSummary(
                                reviews: workoutPlan.workoutPlanReviews),
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          runSpacing: 5,
                          children: workoutPlan.workoutTags
                              .map(
                                (workoutTag) => Tag(
                                  tag: workoutTag.tag,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              decoration:
                  BoxDecoration(color: context.theme.primary.withOpacity(0.75)),
              height: 5),
          Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (workoutPlan.user.avatarUri != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: UserAvatar(
                            avatarUri: workoutPlan.user.avatarUri!,
                            size: 34,
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyHeaderText(
                            workoutPlan.name,
                          ),
                          MyText(
                            'By ${workoutPlan.user.displayName}',
                            size: FONTSIZE.TINY,
                            lineHeight: 1.3,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (workoutPlan.workoutPlanDays.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: PercentageBarChartSingle(
                        inputs: calcInputs(),
                        barHeight: 16,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: WorkoutPlanEnrolmentsSummary(
                      enrolments: workoutPlan.enrolments,
                      subtitle:
                          '${workoutPlan.enrolments.length} ${workoutPlan.enrolments.length == 1 ? "participant" : "participants"}',
                    ),
                  ),
                ],
              ))
        ]));
  }
}
