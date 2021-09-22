import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/utils.dart';

class LoggedWorkoutCard extends StatelessWidget {
  final LoggedWorkout loggedWorkout;

  const LoggedWorkoutCard({Key? key, required this.loggedWorkout})
      : super(key: key);

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
                size: FONTSIZE.two,
                maxLines: 3,
                lineHeight: 1.3,
              ),
            ),
          const HorizontalLine(),
          if (sortedSections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 4),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: sortedSections
                    .map((s) => LoggedWorkoutSectionSummaryTag(
                          s,
                        ))
                    .toList(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 4),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: loggedWorkout.workoutGoals
                  .map((g) => Tag(
                        tag: g.name,
                        fontSize: FONTSIZE.one,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
