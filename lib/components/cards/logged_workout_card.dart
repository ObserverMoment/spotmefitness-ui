import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
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

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                MyText(
                  loggedWorkout.completedOn.compactDateString,
                  color: Styles.infoBlue,
                  size: FONTSIZE.SMALL,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                MyText(
                  loggedWorkout.name,
                ),
              ],
            ),
          ),
          HorizontalLine(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 12,
                children: [
                  ...loggedWorkout.loggedWorkoutSections
                      .map((section) => LoggedWorkoutSectionSummaryTag(
                            section,
                            fontsize: FONTSIZE.TINY,
                            fontWeight: FontWeight.bold,
                          ))
                      .toList(),
                  if (loggedWorkout.loggedWorkoutSections.isNotEmpty)
                    ...moveTypes
                        .map((moveType) => Tag(
                              tag: moveType.name,
                              color: context.theme.background,
                              textColor: context.theme.primary,
                            ))
                        .toList(),
                  ...bodyAreas
                      // .take(kNumBodyAreaTags)
                      .map((bodyArea) => Tag(
                            tag: bodyArea.name,
                          ))
                      .toList(),
                  // if (bodyAreasOverflow) MyText(' ... more')
                ]),
          ),
        ],
      ),
    );
  }
}
