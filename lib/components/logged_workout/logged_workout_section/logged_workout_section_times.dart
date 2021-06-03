import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutSectionTimes extends StatefulWidget {
  final int sectionIndex;
  LoggedWorkoutSectionTimes(this.sectionIndex);

  @override
  _LoggedWorkoutSectionTimesState createState() =>
      _LoggedWorkoutSectionTimesState();
}

class _LoggedWorkoutSectionTimesState extends State<LoggedWorkoutSectionTimes> {
  bool _showSetlapTimes = false;

  void _updateSectionTimecap(
      LoggedWorkoutSection loggedWorkoutSection, Duration duration) {
    final updated =
        LoggedWorkoutSection.fromJson(loggedWorkoutSection.toJson());

    updated.timecap = duration.inSeconds;

    context
        .read<LoggedWorkoutCreatorBloc>()
        .editLoggedWorkoutSection(widget.sectionIndex, updated);
  }

  void _updateSectionLapTime(LoggedWorkoutSection loggedWorkoutSection,
      int roundIndex, Duration duration) {
    final updated =
        LoggedWorkoutSection.fromJson(loggedWorkoutSection.toJson());

    final prevRoundIndexData =
        updated.roundTimesMs[roundIndex.toString()] ?? {};

    updated.roundTimesMs[roundIndex.toString()] = {
      ...prevRoundIndexData,
      'time': duration.inMilliseconds,
    };

    context
        .read<LoggedWorkoutCreatorBloc>()
        .editLoggedWorkoutSection(widget.sectionIndex, updated);
  }

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[widget.sectionIndex]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          if (loggedWorkoutSection.timecap != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText('Timecap'),
                  DurationPickerDisplay(
                      duration:
                          Duration(seconds: loggedWorkoutSection.timecap!),
                      updateDuration: (d) =>
                          _updateSectionTimecap(loggedWorkoutSection, d)),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText('View set times'),
                Row(
                  children: [
                    MyCupertinoSwitch(
                      value: _showSetlapTimes,
                      onChanged: (b) => setState(() => _showSetlapTimes = b),
                    ),
                    InfoPopupButton(
                      pageTitle: 'Lap Times',
                      infoWidget: MyText(
                          'Lap Times explainer + Lap Time Depth selector explainer',
                          maxLines: 4),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: List.generate(loggedWorkoutSection.roundsCompleted,
                  (sectionRound) {
                final sectionRoundTimeMs = loggedWorkoutSection
                    .roundTimesMs[sectionRound.toString()]?['time'];

                final duration = sectionRoundTimeMs != null
                    ? Duration(milliseconds: sectionRoundTimeMs)
                    : null;

                return Column(
                  children: [
                    TappableRow(
                      onTap: () => context.showBottomSheet(
                          child: DurationPicker(
                              duration: duration,
                              updateDuration: (d) => _updateSectionLapTime(
                                  loggedWorkoutSection, sectionRound, d))),
                      title: 'Round ${sectionRound + 1}',
                      display: duration != null
                          ? MyText(duration.compactDisplay())
                          : MyText(
                              'Add time...',
                              subtext: true,
                            ),
                    ),
                    if (_showSetlapTimes)
                      FadeIn(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: SetRoundsLogTimes(
                              loggedWorkoutSection, sectionRound),
                        ),
                      ),
                    HorizontalLine()
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

class SetRoundsLogTimes extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final int sectionRoundNumber;
  SetRoundsLogTimes(this.loggedWorkoutSection, this.sectionRoundNumber);

  void _updateSetRoundTime(
      BuildContext context, String setId, int roundNumber, Duration duration) {
    final updated =
        LoggedWorkoutSection.fromJson(loggedWorkoutSection.toJson());

    final prevRound = updated.roundTimesMs[sectionRoundNumber.toString()] ?? {};
    final prevSet = prevRound?[setId] ?? {};

    updated.roundTimesMs[sectionRoundNumber.toString()] = {
      ...prevRound,
      setId: {...prevSet, roundNumber.toString(): duration.inMilliseconds}
    };

    updated.roundTimesMs[sectionRoundNumber.toString()][setId]
        [roundNumber.toString()] = duration.inMilliseconds;

    context
        .read<LoggedWorkoutCreatorBloc>()
        .editLoggedWorkoutSection(loggedWorkoutSection.sortPosition, updated);
  }

  @override
  Widget build(BuildContext context) {
    final sortedSets = loggedWorkoutSection.loggedWorkoutSets
        .sortedBy<num>((s) => s.sortPosition);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedSets.length,
      itemBuilder: (c, i) {
        final workoutSet = sortedSets[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText('Set ${workoutSet.sortPosition + 1}'),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  workoutSet.roundsCompleted,
                  (setRound) {
                    final setRoundTimeMs = loggedWorkoutSection
                            .roundTimesMs[sectionRoundNumber.toString()]
                        ?[workoutSet.id]?[setRound.toString()];

                    final duration = setRoundTimeMs != null
                        ? Duration(milliseconds: setRoundTimeMs)
                        : null;

                    return TappableRow(
                      onTap: () => context.showBottomSheet(
                          child: DurationPicker(
                              duration: duration,
                              updateDuration: (d) => _updateSetRoundTime(
                                  context, workoutSet.id, setRound, d))),
                      title: 'Round ${setRound + 1}',
                      display: duration != null
                          ? MyText(duration.compactDisplay())
                          : MyText(
                              'Add time...',
                              subtext: true,
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
