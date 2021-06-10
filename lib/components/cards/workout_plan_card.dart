import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/data_vis/waffle_chart.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_enrolments_summary.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_reviews_summary.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  final bool hideBackgroundImage;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final bool withBoxShadow;

  const WorkoutPlanCard(this.workoutPlan,
      {this.hideBackgroundImage = false,
      this.backgroundColor,
      this.withBoxShadow = true,
      this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12)});

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
      backgroundImageUri:
          hideBackgroundImage ? null : workoutPlan.coverImageUri,
      backgroundColor: backgroundColor,
      withBoxShadow: withBoxShadow,
      padding: padding,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyText(
                  'Created by ${workoutPlan.user.displayName}',
                  textAlign: TextAlign.left,
                  size: FONTSIZE.TINY,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 6.0, bottom: 0, left: 3, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (workoutPlan.user.avatarUri != null)
                        UserAvatar(
                          avatarUri: workoutPlan.user.avatarUri!,
                          radius: 34,
                          border: true,
                          borderWidth: 1,
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: MyText(
                            workoutPlan.name,
                            weight: FontWeight.bold,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (workoutPlan.workoutPlanDays.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DifficultyLevelTag(workoutPlan.calcDifficulty),
                  ),
              ],
            ),
          ),
          workoutPlan.workoutPlanDays.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 6, bottom: 6),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Styles.colorOne.withOpacity(0.85)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 8),
                                  child: MyText(
                                    workoutPlan.lengthString,
                                    weight: FontWeight.bold,
                                    color: Styles.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: MyText(
                                  '${workoutPlan.sessionsPerWeek} days / week',
                                  weight: FontWeight.bold,
                                ),
                              ),
                              if (Utils.textNotNull(workoutPlan.description))
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: MyText(
                                    workoutPlan.description!,
                                    maxLines: 4,
                                    textAlign: TextAlign.center,
                                    lineHeight: 1.2,
                                    size: FONTSIZE.SMALL,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      WaffleChart(width: 90, inputs: calcInputs()),
                    ],
                  ),
                )
              : Center(child: MyText('Nothing planned yet')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WorkoutPlanEnrolmentsSummary(
                  enrolments: workoutPlan.enrolments,
                  subtitle: '${workoutPlan.enrolments.length} participants',
                ),
                WorkoutPlanReviewsSummary(
                    reviews: workoutPlan.workoutPlanReviews),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
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
        ],
      ),
    );
  }
}
