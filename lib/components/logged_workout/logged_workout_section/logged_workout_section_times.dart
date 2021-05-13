import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

enum LogTimesPrecision { sectionRounds, setRounds }

class LoggedWorkoutSectionTimes extends StatefulWidget {
  final int sectionIndex;
  LoggedWorkoutSectionTimes(this.sectionIndex);

  @override
  _LoggedWorkoutSectionTimesState createState() =>
      _LoggedWorkoutSectionTimesState();
}

class _LoggedWorkoutSectionTimesState extends State<LoggedWorkoutSectionTimes> {
  LogTimesPrecision _timesPrecision = LogTimesPrecision.sectionRounds;

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[widget.sectionIndex]);

    final loggedWorkoutSets = context
        .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSet>>((b) => b
            .loggedWorkout
            .loggedWorkoutSections[widget.sectionIndex]
            .loggedWorkoutSets)
        .sortedBy<num>((s) => s.setIndex);

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlidingSelect<LogTimesPrecision>(
                      value: _timesPrecision,
                      updateValue: (v) => setState(() => _timesPrecision = v),
                      children: <LogTimesPrecision, Widget>{
                        LogTimesPrecision.sectionRounds: MyText('Section'),
                        LogTimesPrecision.setRounds: MyText('Set'),
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: -8,
                  right: 0,
                  child: InfoPopupButton(
                    pageTitle: 'Lap Times',
                    infoWidget: MyText(
                        'Lap Times explainer + Lap Time Depth selector explainer',
                        maxLines: 4),
                  ))
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: List.generate(loggedWorkoutSection.roundsCompleted,
                  (sectionRound) {
                final sectionLapTime =
                    loggedWorkoutSection.laptimesMs.length > sectionRound
                        ? Duration(
                            milliseconds:
                                loggedWorkoutSection.laptimesMs[sectionRound])
                        : null;

                return Column(
                  children: [
                    TappableRow(
                      onTap: () => context.showBottomSheet(
                          child: DurationPicker(
                              duration: sectionLapTime,
                              updateDuration: (d) => print(d))),
                      title: 'Section Round ${sectionRound + 1}',
                      display: sectionLapTime != null
                          ? MyText(sectionLapTime.compactDisplay())
                          : MyText(
                              'Add time...',
                              subtext: true,
                            ),
                    ),
                    if (_timesPrecision == LogTimesPrecision.setRounds)
                      FadeIn(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: SetRoundsLogTimes(loggedWorkoutSets),
                        ),
                      )
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
  final List<LoggedWorkoutSet> loggedWorkoutSets;
  SetRoundsLogTimes(this.loggedWorkoutSets);

  void _updateSetLapTime() {}

  @override
  Widget build(BuildContext context) {
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
              final setLapTime = workoutSet.laptimesMs.length > setRound
                  ? Duration(milliseconds: workoutSet.laptimesMs[setRound])
                  : null;

              return TappableRow(
                onTap: () => context.showBottomSheet(
                    child: DurationPicker(
                        duration: setLapTime, updateDuration: (d) => print(d))),
                title: 'Set ${workoutSet.setIndex + 1} - Round ${setRound + 1}',
                display: setLapTime != null
                    ? MyText(setLapTime.compactDisplay())
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
