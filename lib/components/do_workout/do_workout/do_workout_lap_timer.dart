import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutLapTimer extends StatelessWidget {
  final WorkoutSectionProgressState state;
  final WorkoutSection workoutSection;
  const DoWorkoutLapTimer(
      {Key? key, required this.state, required this.workoutSection})
      : super(key: key);

  /// currentWorkoutSet.duration should never be null for timed sets.
  int get _currentSetDuration => workoutSection.workoutSets
      .sortedBy<num>((wSet) => wSet.sortPosition)[state.currentSetIndex]
      .duration!;

  @override
  Widget build(BuildContext context) {
    final totalRounds = workoutSection.rounds;
    final totalSetsPerRound = workoutSection.workoutSets.length;
    final remainingSeconds = (state.setTimeRemainingMs! ~/ 1000).toString();

    /// TODO: For the free session this page will be a 'rest timer' (widget that needs building).
    return Padding(
      padding: const EdgeInsets.only(bottom: kBottomNavBarHeight),
      child: GestureDetector(
        onTap: () => print('play / pause'),
        child: LayoutBuilder(
            builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircularPercentIndicator(
                        header: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  H3('Round ${state.currentSectionRound + 1} of $totalRounds'),
                                  H3(' - '),
                                  H3('Set ${state.currentSetIndex + 1} of $totalSetsPerRound'),
                                ],
                              ),
                              H2('Current Move'),
                            ],
                          ),
                        ),
                        center: SizeFadeIn(
                          key: Key(remainingSeconds),
                          child: MyText(
                            remainingSeconds,
                            size: FONTSIZE.GIANT,
                          ),
                        ),
                        footer: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              H2('Up next'),
                              MyText('Tap screen to play / pause')
                            ],
                          ),
                        ),
                        backgroundColor: context.theme.primary.withOpacity(0.1),
                        linearGradient: Styles.pinkGradient,
                        // progressColor: Styles.peachRed,
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: 1 -
                            (state.setTimeRemainingMs! /
                                (_currentSetDuration * 1000)),
                        radius: constraints.maxWidth / 1.4),
                  ],
                )),
      ),
    );
  }
}
