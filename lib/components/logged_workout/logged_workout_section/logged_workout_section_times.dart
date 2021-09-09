import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:supercharged/supercharged.dart';

class LoggedWorkoutSectionTimes extends StatefulWidget {
  final int sectionIndex;
  LoggedWorkoutSectionTimes(this.sectionIndex);

  @override
  _LoggedWorkoutSectionTimesState createState() =>
      _LoggedWorkoutSectionTimesState();
}

class _LoggedWorkoutSectionTimesState extends State<LoggedWorkoutSectionTimes> {
  bool _showSetLapTimes = false;

  void _updateSectionTimecap(
      LoggedWorkoutSection loggedWorkoutSection, Duration duration) {
    context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
        widget.sectionIndex, {'timecap': duration.inSeconds});
  }

  void _updateSectionLapTime(LoggedWorkoutSection loggedWorkoutSection,
      int roundIndex, Duration duration) {
    final updated =
        LoggedWorkoutSection.fromJson(loggedWorkoutSection.toJson());

    final prevRoundData = updated.lapTimesMs[roundIndex.toString()] ?? {};

    final updatedLapTimesMs = {
      ...updated.lapTimesMs,
      roundIndex.toString(): {
        ...prevRoundData,
        'lapTimeMs': duration.inMilliseconds
      }
    };

    context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
        widget.sectionIndex, {'lapTimesMs': updatedLapTimesMs});
  }

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[widget.sectionIndex]);

    final loggedWorkoutSetsBySectionRound = loggedWorkoutSection
        .loggedWorkoutSets
        .groupBy<int, LoggedWorkoutSet>((lwSet) => lwSet.roundNumber);

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
                      value: _showSetLapTimes,
                      onChanged: (b) => setState(() => _showSetLapTimes = b),
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
            children: loggedWorkoutSetsBySectionRound.keys
                .sortedBy<num>((roundNumber) => roundNumber)
                .map((roundNumber) {
              final sectionRoundTimeMs = loggedWorkoutSection
                  .lapTimesMs[roundNumber.toString()]?['lapTimeMs'];

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
                                loggedWorkoutSection, roundNumber, d))),
                    title: 'Round ${roundNumber + 1}',
                    display: duration != null
                        ? MyText(duration.compactDisplay())
                        : MyText(
                            'Add time...',
                            subtext: true,
                          ),
                  ),
                  if (_showSetLapTimes)
                    FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: SetLapTimes(
                            loggedWorkoutSection: loggedWorkoutSection,
                            loggedWorkoutSets:
                                loggedWorkoutSetsBySectionRound[roundNumber]!,
                            sectionRoundNumber: roundNumber),
                      ),
                    ),
                  HorizontalLine()
                ],
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}

class SetLapTimes extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final List<LoggedWorkoutSet> loggedWorkoutSets;
  final int sectionRoundNumber;
  SetLapTimes(
      {required this.loggedWorkoutSection,
      required this.sectionRoundNumber,
      required this.loggedWorkoutSets});

  void _updateSetLapTime(
      BuildContext context, int setSortPosition, Duration duration) {
    final updated =
        LoggedWorkoutSection.fromJson(loggedWorkoutSection.toJson());

    final roundData = updated.lapTimesMs[sectionRoundNumber.toString()] ?? {};
    final setData = roundData?['setLapTimesMs'] ?? {};

    final updatedLapTimesMs = {
      ...updated.lapTimesMs,
      sectionRoundNumber.toString(): {
        ...roundData,
        'setLapTimesMs': {
          ...setData,
          setSortPosition.toString(): duration.inMilliseconds
        }
      }
    };

    context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
        loggedWorkoutSection.sortPosition, {'lapTimesMs': updatedLapTimesMs});
  }

  @override
  Widget build(BuildContext context) {
    final sortedSets = loggedWorkoutSets.sortedBy<num>((s) => s.sortPosition);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedSets.length,
      itemBuilder: (c, i) {
        final workoutSet = sortedSets[i];
        final setLapTime =
            loggedWorkoutSection.lapTimesMs[sectionRoundNumber.toString()]
                ?['setLapTimesMs']?[workoutSet.sortPosition.toString()];

        final duration =
            setLapTime != null ? Duration(milliseconds: setLapTime) : null;

        return TappableRow(
          onTap: () => context.showBottomSheet(
              child: DurationPicker(
                  duration: duration,
                  updateDuration: (d) =>
                      _updateSetLapTime(context, workoutSet.sortPosition, d))),
          title: 'Set ${workoutSet.sortPosition + 1}',
          display: duration != null
              ? MyText(duration.compactDisplay())
              : MyText(
                  'Add time...',
                  subtext: true,
                ),
        );
      },
    );
  }
}
