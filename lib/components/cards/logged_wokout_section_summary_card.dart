import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
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
import 'package:supercharged/supercharged.dart';

/// Summary of the list of moves from a logged section, with a smaller footprint.
/// Simple text style list of moves + laptimes if they exist for each set.
/// More like a Wodwell card that the standard SpotMe style.
/// https://wodwell.com/
class LoggedWorkoutSectionSummaryCard extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final void Function(String note)? addNoteToLoggedSection;
  final bool showSectionName;
  const LoggedWorkoutSectionSummaryCard(
      {Key? key,
      required this.loggedWorkoutSection,
      this.addNoteToLoggedSection,
      this.showSectionName = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSetsBySectionRound = loggedWorkoutSection
        .loggedWorkoutSets
        .groupBy<int, LoggedWorkoutSet>((lwSet) => lwSet.roundNumber);

    final multipleRounds = loggedWorkoutSetsBySectionRound.keys.length > 1;

    return Column(
      children: [
        if (showSectionName && Utils.textNotNull(loggedWorkoutSection.name))
          MyText(
            '"${loggedWorkoutSection.name!}"',
            weight: FontWeight.bold,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: LoggedWorkoutSectionSummaryTag(
                loggedWorkoutSection,
              ),
            ),
            if (addNoteToLoggedSection != null)
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: AnimatedSwitcher(
                    duration: kStandardAnimationDuration,
                    child: Utils.textNotNull(loggedWorkoutSection.note)
                        ? MyText(
                            'Edit note',
                            weight: FontWeight.bold,
                          )
                        : MyText(
                            'Add note',
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
        if (Utils.textNotNull(loggedWorkoutSection.note))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: MyText(
                  loggedWorkoutSection.note!,
                  size: FONTSIZE.SMALL,
                  maxLines: 3,
                  lineHeight: 1.4,
                ),
                onPressed: () => context.showBottomSheet(
                    expand: true,
                    child: TextViewer(loggedWorkoutSection.note!, 'Note'))),
          ),

        /// Similar to [LoggedWorkout > LoggedWorkoutSectionTimes] logic.
        loggedWorkoutSection.loggedWorkoutSets.isEmpty
            ? Center(child: MyText('Nothing here...'))
            : Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: loggedWorkoutSetsBySectionRound.keys
                      .sortedBy<num>((roundNumber) => roundNumber)
                      .map((roundNumber) {
                    final int? sectionRoundTimeMs = loggedWorkoutSection
                        .lapTimesMs[roundNumber.toString()]?['lapTimeMs'];

                    final sortedSetsInSectionRound =
                        loggedWorkoutSetsBySectionRound[roundNumber]!
                            .sortedBy<num>((s) => s.sortPosition);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          if (multipleRounds)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  'Round ${roundNumber + 1}',
                                  color: Styles.infoBlue,
                                ),
                                if (sectionRoundTimeMs != null)
                                  MyText(
                                    Duration(milliseconds: sectionRoundTimeMs)
                                        .compactDisplay(),
                                    color: Styles.infoBlue,
                                  )
                              ],
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 6, top: 5, bottom: 5),
                            child: Column(
                              children: sortedSetsInSectionRound
                                  .map((loggedWorkoutSet) {
                                final int? setLapTime = loggedWorkoutSection
                                            .lapTimesMs[roundNumber.toString()]
                                        ?['setLapTimesMs']
                                    [loggedWorkoutSet.sortPosition.toString()];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (loggedWorkoutSet.roundsCompleted > 1)
                                      MyText(
                                        '${loggedWorkoutSet.roundsCompleted} rounds',
                                        color: Styles.infoBlue,
                                        size: FONTSIZE.SMALL,
                                        lineHeight: 1.5,
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: loggedWorkoutSet
                                              .loggedWorkoutMoves
                                              .map((m) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4.0,
                                                            top: 4),
                                                    child:
                                                        LoggedWorkoutMoveMinimalDisplay(
                                                      loggedWorkoutMove: m,
                                                      showReps: ![
                                                        kTabataName,
                                                        kHIITCircuitName
                                                      ].contains(
                                                          loggedWorkoutSection
                                                              .workoutSectionType
                                                              .name),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                        if (setLapTime != null)
                                          MyText(
                                            Duration(milliseconds: setLapTime)
                                                .compactDisplay(),
                                            lineHeight: 1.5,
                                          ),
                                      ],
                                    ),
                                    HorizontalLine()
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
      ],
    );
  }
}
