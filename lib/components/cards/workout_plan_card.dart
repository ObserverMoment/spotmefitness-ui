import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/data_vis/percentage_bar_chart.dart';
import 'package:spotmefitness_ui/components/data_vis/waffle_chart.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/users_group_summary.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_reviews_summary.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
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
    final allTags = workoutPlan.workoutTags;

    return Card(
        backgroundColor: backgroundColor,
        withBoxShadow: withBoxShadow,
        padding: EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kCardBorderRadiusValue),
                  topRight: Radius.circular(kCardBorderRadiusValue)),
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
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Card(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  borderRadius: BorderRadius.circular(4),
                                  child: MyText(
                                    workoutPlan.lengthString,
                                    size: FONTSIZE.SMALL,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Card(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    borderRadius: BorderRadius.circular(4),
                                    child: MyText(
                                      '${workoutPlan.daysPerWeek} days / week',
                                      size: FONTSIZE.SMALL,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (allTags.isNotEmpty)
                              SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: allTags.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Tag(
                                      tag: allTags[i].tag,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        )),
                    Positioned(
                        right: 8,
                        top: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              borderRadius: BorderRadius.circular(5),
                              child: WorkoutPlanReviewsSummary(
                                  reviews: workoutPlan.workoutPlanReviews),
                            ),
                            if (workoutPlan.workoutPlanDays.isNotEmpty &&
                                workoutPlan.calcDifficulty != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: DifficultyLevelTag(
                                  workoutPlan.calcDifficulty!,
                                  fontSize: FONTSIZE.TINY,
                                ),
                              ),
                          ],
                        ))
                  ],
                ),
              )),
          Container(
              decoration:
                  BoxDecoration(color: context.theme.primary.withOpacity(0.75)),
              height: 5),
          Container(
              padding: const EdgeInsets.only(
                  top: 16, left: 12, right: 12, bottom: 8),
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
                    padding: const EdgeInsets.only(top: 8.0),
                    child: UsersGroupSummary(
                      users: workoutPlan.enrolments.map((e) => e.user).toList(),
                      subtitle:
                          '${workoutPlan.enrolments.length} ${workoutPlan.enrolments.length == 1 ? "participant" : "participants"}',
                    ),
                  ),
                ],
              ))
        ]));
  }
}
