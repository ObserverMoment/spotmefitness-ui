import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/data_vis/percentage_bar_chart.dart';
import 'package:spotmefitness_ui/components/data_vis/waffle_chart.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_enrolments_summary.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_reviews_summary.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class WorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  final bool hideBackgroundImage;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final bool showEnrolledAndReviews;
  final bool showGoalsBarDisplay;
  final bool showCreatedBy;
  final bool showAccessScope;

  const WorkoutPlanCard(this.workoutPlan,
      {this.hideBackgroundImage = false,
      this.backgroundColor,
      this.withBoxShadow = true,
      this.showEnrolledAndReviews = true,
      this.showGoalsBarDisplay = true,
      this.showCreatedBy = true,
      this.showAccessScope = true,
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
          if (showCreatedBy || showAccessScope)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showCreatedBy)
                    MyText(
                      'By ${workoutPlan.user.displayName}',
                      textAlign: TextAlign.left,
                      size: FONTSIZE.TINY,
                      lineHeight: 1.3,
                    ),
                  if (showCreatedBy && showAccessScope)
                    MyText(
                      ' | ',
                      size: FONTSIZE.TINY,
                      lineHeight: 1.3,
                    ),
                  if (showAccessScope)
                    MyText(
                      workoutPlan.contentAccessScope.display,
                      textAlign: TextAlign.left,
                      size: FONTSIZE.TINY,
                      lineHeight: 1.3,
                      color: Styles.colorTwo,
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
                          size: 34,
                          border: true,
                          borderWidth: 1,
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: MyText(
                            workoutPlan.name,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tag(
                              tag: workoutPlan.lengthString,
                              fontSize: FONTSIZE.SMALL,
                              textColor: Styles.white,
                              color: Styles.colorOne,
                            ),
                            Tag(
                              tag: '${workoutPlan.daysPerWeek} days / week',
                              fontSize: FONTSIZE.SMALL,
                              color: Styles.colorOne,
                              textColor: Styles.white,
                            ),
                          ],
                        ),
                      ),
                      if (Utils.textNotNull(workoutPlan.description))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: MyText(
                            workoutPlan.description!,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            lineHeight: 1.3,
                          ),
                        ),
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyText(
                    'Nothing here...',
                    subtext: true,
                  ),
                )),
          if (showEnrolledAndReviews)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WorkoutPlanEnrolmentsSummary(
                    enrolments: workoutPlan.enrolments,
                    subtitle:
                        '${workoutPlan.enrolments.length} ${workoutPlan.enrolments.length == 1 ? "participant" : "participants"}',
                  ),
                  WorkoutPlanReviewsSummary(
                      reviews: workoutPlan.workoutPlanReviews),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
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
          if (showGoalsBarDisplay && workoutPlan.workoutGoalsInPlan.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PercentageBarChartSingle(
                inputs: calcInputs(),
                barHeight: 12,
              ),
            ),
        ],
      ),
    );
  }
}
