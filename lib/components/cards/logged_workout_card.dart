import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutCard extends StatelessWidget {
  final LoggedWorkout loggedWorkout;

  LoggedWorkoutCard(this.loggedWorkout);

  @override
  Widget build(BuildContext context) {
    final sortedSections = loggedWorkout.loggedWorkoutSections
        .sortedBy<num>((s) => s.sortPosition);

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
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: MyHeaderText(
                    loggedWorkout.name,
                    weight: FontWeight.normal,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          if (Utils.textNotNull(loggedWorkout.note))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6.0),
              child: MyText(
                loggedWorkout.note!,
                size: FONTSIZE.SMALL,
                maxLines: 3,
                lineHeight: 1.3,
              ),
            ),
          HorizontalLine(),
          if (sortedSections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 4),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: sortedSections
                    .map((s) => LoggedWorkoutSectionSummaryTag(s))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
