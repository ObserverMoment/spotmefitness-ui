import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

class LoggedWorkoutCard extends StatelessWidget {
  final LoggedWorkout loggedWorkout;

  LoggedWorkoutCard(this.loggedWorkout);

  final kNumSectionTags = 3;
  final kNumBodyAreaTags = 10;
  final kNumMoveTypeTags = 4;

  @override
  Widget build(BuildContext context) {
    Set<BodyArea> bodyAreas = {};
    Set<MoveType> moveTypes = {};

    final sortedSections = loggedWorkout.loggedWorkoutSections
        .sortedBy<num>((s) => s.sortPosition);

    for (final workoutSection in sortedSections) {
      for (final workoutSet in workoutSection.loggedWorkoutSets) {
        for (final workoutMove in workoutSet.loggedWorkoutMoves) {
          bodyAreas.addAll(workoutMove.move.bodyAreaMoveScores
              .map((bams) => bams.bodyArea)
              .toList());
          moveTypes.add(workoutMove.move.moveType);
        }
      }
    }

    final bool sectionTagsOverflow =
        loggedWorkout.loggedWorkoutSections.length > kNumSectionTags;

    final bool moveTypesOverflow = moveTypes.length > kNumMoveTypeTags;

    final bool bodyAreasOverflow = bodyAreas.length > kNumBodyAreaTags;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: MyText(
                    loggedWorkout.name,
                    weight: FontWeight.bold,
                  ),
                ),
                MyText(
                  loggedWorkout.completedOn.compactDateString,
                  color: Styles.colorTwo,
                )
              ],
            ),
          ),
          if (loggedWorkout.loggedWorkoutSections.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        ...moveTypes
                            .take(kNumMoveTypeTags)
                            .map((moveType) => Tag(
                                  tag: moveType.name,
                                  color: context.theme.background,
                                  textColor: context.theme.primary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                ))
                            .toList(),
                        if (moveTypesOverflow) MyText(' ... more')
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        ...loggedWorkout.loggedWorkoutSections
                            .take(kNumSectionTags)
                            .map((section) =>
                                LoggedWorkoutSectionSummaryTag(section))
                            .toList(),
                        if (sectionTagsOverflow) MyText(' ... more')
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        ...bodyAreas
                            .take(kNumBodyAreaTags)
                            .map((bodyArea) => Tag(
                                tag: bodyArea.name,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4)))
                            .toList(),
                        if (bodyAreasOverflow) MyText(' ... more')
                      ]),
                ),
              ],
            )
          else
            MyText('No sections logged...')
        ],
      ),
    );
  }
}
