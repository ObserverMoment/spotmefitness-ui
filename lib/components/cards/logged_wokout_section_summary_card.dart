import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_move_minimal_display.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Summary of the list of moves from a logged section, with a smaller footprint.
/// Simple text style list of moves + laptimes if they exist for each set.
/// More like a Wodwell card that the standard SpotMe style.
/// https://wodwell.com/
class LoggedWorkoutSectionSummaryCard extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final void Function(String note)? addNoteToLoggedSection;
  const LoggedWorkoutSectionSummaryCard(
      {Key? key,
      required this.loggedWorkoutSection,
      this.addNoteToLoggedSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedSets = loggedWorkoutSection.loggedWorkoutSets
        .sortedBy<num>((ls) => ls.sortPosition);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  LoggedWorkoutSectionSummaryTag(
                    loggedWorkoutSection,
                    fontsize: FONTSIZE.MAIN,
                  ),
                  if (Utils.textNotNull(loggedWorkoutSection.name))
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: H3('"${loggedWorkoutSection.name!}"'),
                    ),
                ],
              ),
            ),
            if (addNoteToLoggedSection == null &&
                Utils.textNotNull(loggedWorkoutSection.note))
              NoteIconViewerButton(loggedWorkoutSection.note!),
            if (addNoteToLoggedSection != null)
              CupertinoButton(
                  child: AnimatedSwitcher(
                    duration: kStandardAnimationDuration,
                    child: Utils.textNotNull(loggedWorkoutSection.note)
                        ? Icon(CupertinoIcons.doc_plaintext)
                        : MyText(
                            'Add note...',
                            weight: FontWeight.bold,
                          ),
                  ),
                  onPressed: () => context.push(
                      child: FullScreenTextEditing(
                          title: 'Workout Note',
                          initialValue: loggedWorkoutSection.note,
                          onSave: addNoteToLoggedSection!,
                          inputValidation: (t) => true)))
          ],
        ),
        ...List.generate(loggedWorkoutSection.roundsCompleted, (sectionRound) {
          final int sectionRoundTimeMs = loggedWorkoutSection
              .lapTimesMs[sectionRound.toString()]?['lapTimeMs'];

          final roundDuration = Duration(milliseconds: sectionRoundTimeMs);

          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      'Round ${sectionRound + 1}',
                      color: Styles.infoBlue,
                    ),
                    MyText(
                      roundDuration.compactDisplay(),
                      color: Styles.infoBlue,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 2),
                  child: Column(
                    children: sortedSets.map((loggedWorkoutSet) {
                      final int setLapTime = loggedWorkoutSection
                                  .lapTimesMs[sectionRound.toString()]
                              ['setLapTimesMs']
                          [loggedWorkoutSet.sortPosition.toString()];

                      final duration = Duration(milliseconds: setLapTime);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: loggedWorkoutSet.loggedWorkoutMoves
                                .map((m) => LoggedWorkoutMoveMinimalDisplay(
                                    loggedWorkoutMove: m))
                                .toList(),
                          ),
                          MyText(duration.compactDisplay()),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
