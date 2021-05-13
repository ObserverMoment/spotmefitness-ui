import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
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

  void _updateSectionLapTime(LoggedWorkoutSection loggedWorkoutSection,
      int roundIndex, Duration duration) {
    final updated =
        LoggedWorkoutSection.fromJson(loggedWorkoutSection.toJson());

    updated.roundTimesMs[roundIndex.toString()] = duration.inMilliseconds;

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
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText('View set times'),
                Row(
                  children: [
                    CupertinoSwitch(
                      value: _showSetlapTimes,
                      onChanged: (b) => setState(() => _showSetlapTimes = b),
                      activeColor: Styles.infoBlue,
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
                final sectionLapTimeMs =
                    loggedWorkoutSection.roundTimesMs[sectionRound.toString()];
                final duration = sectionLapTimeMs != null
                    ? Duration(milliseconds: sectionLapTimeMs)
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
                              loggedWorkoutSection.sectionIndex),
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
  final int sectionIndex;
  SetRoundsLogTimes(this.sectionIndex);

  void _updateSetLapTime(BuildContext context,
      LoggedWorkoutSet loggedWorkoutSet, int roundIndex, Duration duration) {
    final updated = LoggedWorkoutSet.fromJson(loggedWorkoutSet.toJson());

    updated.roundTimesMs[roundIndex.toString()] = duration.inMilliseconds;

    context
        .read<LoggedWorkoutCreatorBloc>()
        .editLoggedWorkoutSet(sectionIndex, loggedWorkoutSet.setIndex, updated);
  }

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSets = context
        .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSet>>((b) => b
            .loggedWorkout
            .loggedWorkoutSections[sectionIndex]
            .loggedWorkoutSets)
        .sortedBy<num>((s) => s.setIndex);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: loggedWorkoutSets.length,
      itemBuilder: (c, i) {
        final workoutSet = loggedWorkoutSets[i];
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            workoutSet.roundsCompleted,
            (setRound) {
              final setLapTimeMs = workoutSet.roundTimesMs[setRound.toString()];
              final duration = setLapTimeMs != null
                  ? Duration(milliseconds: setLapTimeMs)
                  : null;

              return TappableRow(
                onTap: () => context.showBottomSheet(
                    child: DurationPicker(
                        duration: duration,
                        updateDuration: (d) => _updateSetLapTime(
                            context, workoutSet, setRound, d))),
                title: 'Set ${workoutSet.setIndex + 1} - Round ${setRound + 1}',
                display: duration != null
                    ? MyText(duration.compactDisplay())
                    : MyText(
                        'Add time...',
                        subtext: true,
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
