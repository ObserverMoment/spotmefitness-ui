import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_minimal_display.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class AMRAPSectionProgressSummary extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;

  const AMRAPSectionProgressSummary(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutSets =
        workoutSection.workoutSets.sortedBy<num>((wSet) => wSet.sortPosition);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            lineHeight: 6,
            percent: state.percentComplete,
            backgroundColor: context.theme.primary.withOpacity(0.07),
            linearGradient: Styles.pinkGradient,
            linearStrokeCap: LinearStrokeCap.roundAll,
          ),
        ),
        state.lapTimesMs.keys.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    MyText('No sets completed yet...', subtext: true),
                    H1("Let's go!"),
                  ],
                ),
              )
            : Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      bottom: EnvironmentConfig.bottomNavBarHeight,
                      top: 12,
                      left: 16,
                      right: 16),
                  children: state.lapTimesMs.keys
                      .map<Widget>((i) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              H3('Round ${int.parse(i) + 1}'),
                              Column(
                                children: (state.lapTimesMs[i]!['setLapTimesMs']
                                        as Map)
                                    .keys
                                    .map((j) => SizeFadeIn(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _CompletedAMRAPSet(
                                                workoutSet: sortedWorkoutSets[
                                                    int.parse(j)],
                                              ),
                                              MyText(Duration(
                                                      milliseconds: state
                                                              .lapTimesMs[i]![
                                                          'setLapTimesMs'][j])
                                                  .compactDisplay()),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              )
                            ],
                          ))
                      .toList(),
                ),
              ),
      ],
    );
  }
}

class _CompletedAMRAPSet extends StatelessWidget {
  final WorkoutSet workoutSet;
  const _CompletedAMRAPSet({
    Key? key,
    required this.workoutSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 6,
        children: workoutSet.workoutMoves
            .map((workoutMove) => ContentBox(
                  child: WorkoutMoveMinimalDisplay(
                    workoutMove: workoutMove,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
