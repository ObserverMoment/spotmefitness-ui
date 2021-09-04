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
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutCard extends StatelessWidget {
  final LoggedWorkout loggedWorkout;

  LoggedWorkoutCard(this.loggedWorkout);

  @override
  Widget build(BuildContext context) {
    Set<MoveType> moveTypes = {};

    final sortedSections = loggedWorkout.loggedWorkoutSections
        .sortedBy<num>((s) => s.sortPosition);

    for (final workoutSection in sortedSections) {
      for (final workoutSet in workoutSection.loggedWorkoutSets) {
        for (final workoutMove in workoutSet.loggedWorkoutMoves) {
          moveTypes.add(workoutMove.move.moveType);
        }
      }
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                MyHeaderText(
                  loggedWorkout.name,
                  weight: FontWeight.normal,
                ),
              ],
            ),
          ),
          if (Utils.textNotNull(loggedWorkout.note))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6.0),
              child: MyText(
                loggedWorkout.note!,
                maxLines: 3,
                subtext: true,
                lineHeight: 1.3,
              ),
            ),
          HorizontalLine(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
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
                              color: Styles.colorOne,
                              textColor: Styles.white,
                            ))
                        .toList(),
                ]),
          ),
        ],
      ),
    );
  }
}
