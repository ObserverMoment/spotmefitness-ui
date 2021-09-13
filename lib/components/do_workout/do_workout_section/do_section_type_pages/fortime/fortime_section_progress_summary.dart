import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/utils.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_minimal_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ForTimeSectionProgressSummary extends StatefulWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const ForTimeSectionProgressSummary(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  @override
  ForTimeSectionProgressSummaryState createState() =>
      ForTimeSectionProgressSummaryState();
}

class ForTimeSectionProgressSummaryState
    extends State<ForTimeSectionProgressSummary> {
  /// Logic is similar to that found in [DoWorkoutMovesList] but with no user interaction.
  /// It also needs to take into account the start line (and finish line) which are also in the scroll_to_index list. Start line has an index of 0 so everything else is pushed up one index vs the start calculation which is found in [DoWorkoutMovesList] logic.
  /// This list scrolls with progress. There is no need for the user to search it. View only.
  late AutoScrollController _autoScrollController;

  /// This list will auto scroll downwards as the workout progresses, with the current set at the top of the visible list.
  /// When the user interacts we start a ?? second timer. During this time autoscroll is disabled, allowing the user to check whichever part of the workout they need to.
  /// After ?? seconds we re-enable autoscroll and rejoin the flow of the workout.
  bool _disableAutoScroll = false;
  Timer? _enableAutoScrollTimer;

  late int _finishLineIndex;

  @override
  void initState() {
    super.initState();
    _autoScrollController = AutoScrollController();

    _finishLineIndex = (widget.workoutSection.rounds *
            widget.workoutSection.workoutSets.length) +
        1;
  }

  @override
  void didUpdateWidget(ForTimeSectionProgressSummary oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// When reaching the end of the section [state.currentSectionRound] will be greater than the total [workoutSection.rounds] and will cause [AutoScrollController] to throw an error.
    if (!!_disableAutoScroll) {
      if (widget.state.currentSectionRound < widget.workoutSection.rounds) {
        _autoScrollController.scrollToIndex(
            _calcCurrentSetIndex(
                widget.state.currentSectionRound, widget.state.currentSetIndex),
            preferPosition: AutoScrollPosition.begin);
      } else {
        /// Go to the finish line.
        _autoScrollController.scrollToIndex(
            _calcCurrentSetIndex(
                widget.state.currentSectionRound, widget.state.currentSetIndex),
            preferPosition: AutoScrollPosition.begin);
      }
    }
  }

  void _handleUserScroll() {
    setState(() => _disableAutoScroll = true);
    _enableAutoScrollTimer = Timer(Duration(seconds: 10), () {
      setState(() => _disableAutoScroll = false);
      _enableAutoScrollTimer!.cancel();
    });
  }

  /// Need to add 1 because the start line is also an index in this list.
  int _calcCurrentSetIndex(int roundNumber, int workoutSetIndex) =>
      (roundNumber * widget.workoutSection.workoutSets.length +
          workoutSetIndex) +
      1;

  List<Widget> _movesList(int roundNumber) => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              MyText(
                'Round ${roundNumber + 1}',
                subtext: widget.state.currentSectionRound > roundNumber,
              ),
              if (widget.state.currentSectionRound > roundNumber)
                FadeIn(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Icon(
                    CupertinoIcons.checkmark_alt,
                    color: Styles.peachRed,
                    size: 20,
                  ),
                ))
            ],
          ),
        ),
        ...widget.workoutSection.workoutSets
            .sortedBy<num>((workoutSet) => workoutSet.sortPosition)
            .map((workoutSet) {
          final listItemIndex =
              _calcCurrentSetIndex(roundNumber, workoutSet.sortPosition);

          return AutoScrollTag(
            controller: _autoScrollController,
            index: listItemIndex,
            key: Key(listItemIndex.toString()),
            child: _ForTimeWorkoutSetDisplay(
                roundNumber: roundNumber,
                state: widget.state,
                workoutSet: workoutSet,
                showReps: ![kTabataName, kHIITCircuitName]
                    .contains(widget.workoutSection.workoutSectionType.name)),
          );
        }).toList(),
      ];

  @override
  void dispose() {
    _autoScrollController.dispose();
    _enableAutoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // https://stackoverflow.com/questions/57841166/how-to-detect-if-the-user-started-scrolling-the-listview-builder-vertically
              // https://api.flutter.dev/flutter/widgets/ScrollStartNotification-class.html
              if (notification is ScrollStartNotification &&
                  notification.dragDetails != null) {
                // Disable the auto scroll to stop bouncing the user around as they search the workout.
                _handleUserScroll();
              }
              // Returning false to
              // "allow the notification to continue to be dispatched to further ancestors".
              return false;
            },
            child: ListView(
              padding: const EdgeInsets.all(6),
              controller: _autoScrollController,
              children: [
                AutoScrollTag(
                  controller: _autoScrollController,
                  index: 0,
                  key: Key(0.toString()),
                  child: Column(
                    children: [
                      MyText('Start'),
                      HorizontalLine(),
                    ],
                  ),
                ),
                ...List.generate(widget.workoutSection.rounds,
                        (roundNumber) => _movesList(roundNumber))
                    .expand((x) => x)
                    .toList(),
                AutoScrollTag(
                  controller: _autoScrollController,
                  index: _finishLineIndex,
                  key: Key(_finishLineIndex.toString()),
                  child: Column(
                    children: [
                      HorizontalLine(),
                      MyText('Finish'),
                      HorizontalLine(),
                      SizedBox(height: EnvironmentConfig.bottomNavBarHeight)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ForTimeWorkoutSetDisplay extends StatelessWidget {
  final int roundNumber;
  final WorkoutSet workoutSet;
  final WorkoutSectionProgressState state;
  final bool showReps;
  const _ForTimeWorkoutSetDisplay(
      {Key? key,
      required this.workoutSet,
      required this.state,
      required this.roundNumber,
      this.showReps = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = state.currentSectionRound == roundNumber &&
        state.currentSetIndex == workoutSet.sortPosition;

    // final int? lapTimeMs = state.lapTimesMs[roundNumber.toString()]
    //     ?['setLapTimesMs'][workoutSet.sortPosition.toString()];

    return AnimatedOpacity(
      opacity: DoWorkoutUtils.moveIsCompleted(
              state, roundNumber, workoutSet.sortPosition)
          ? 0.6
          : 1,
      duration: kStandardAnimationDuration,
      child: AnimatedContainer(
        duration: kStandardAnimationDuration,
        decoration: isActive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: context.theme.primary),
              )
            : null,
        child: MyText('_ForTimeWorkoutSetDisplay'),
        // child: Padding(
        //   padding: const EdgeInsets.all(6.0),
        //   child: Row(
        //     mainAxisAlignment: lapTimeMs != null
        //         ? MainAxisAlignment.spaceBetween
        //         : MainAxisAlignment.center,
        //     children: [
        //       Wrap(
        //         alignment: WrapAlignment.center,
        //         runAlignment: WrapAlignment.center,
        //         spacing: 12,
        //         runSpacing: 6,
        //         children: workoutSet.workoutMoves
        //             .map((workoutMove) => ContentBox(
        //                   child: WorkoutMoveMinimalDisplay(
        //                     workoutMove: workoutMove,
        //                     showReps: showReps,
        //                   ),
        //                 ))
        //             .toList(),
        //       ),
        //       // if (lapTimeMs != null)
        //       //   SizeFadeIn(
        //       //       child: MyText(
        //       //           Duration(milliseconds: lapTimeMs).compactDisplay()))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
