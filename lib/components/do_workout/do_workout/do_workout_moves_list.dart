import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/utils.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DoWorkoutMovesList extends StatefulWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const DoWorkoutMovesList(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  @override
  _DoWorkoutMovesListState createState() => _DoWorkoutMovesListState();
}

class _DoWorkoutMovesListState extends State<DoWorkoutMovesList> {
  late AutoScrollController _autoScrollController;

  /// This list will auto scroll downwards as the workout progresses, with the current set at the top of the visible list.
  /// When the user interacts we start a ?? second timer. During this time autoscroll is disabled, allowing the user to check whichever part of the workout they need to.
  /// After ?? seconds we re-enable autoscroll and rejoin the flow of the workout.
  bool _disableAutoScroll = false;
  Timer? _enableAutoScrollTimer;

  @override
  void initState() {
    super.initState();
    _autoScrollController = AutoScrollController();
  }

  @override
  void didUpdateWidget(DoWorkoutMovesList oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// When reaching the end of the section [state.currentSectionRound] will be greater than the total [workoutSection.rounds] and will cause [AutoScrollController] to throw an error.
    if (!_disableAutoScroll &&
        widget.state.currentSectionRound < widget.workoutSection.rounds) {
      _autoScrollController.scrollToIndex(
          _calcCurrentSetIndex(
              widget.state.currentSectionRound, widget.state.currentSetIndex),
          preferPosition: AutoScrollPosition.begin);
    }
  }

  void _handleUserScroll() {
    setState(() => _disableAutoScroll = true);
    _enableAutoScrollTimer = Timer(Duration(seconds: 10), () {
      setState(() => _disableAutoScroll = false);
      _enableAutoScrollTimer!.cancel();
    });
  }

  int _calcCurrentSetIndex(int roundNumber, int workoutSetIndex) =>
      roundNumber * widget.workoutSection.workoutSets.length + workoutSetIndex;

  @override
  void dispose() {
    _enableAutoScrollTimer?.cancel();
    _autoScrollController.dispose();
    super.dispose();
  }

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
            child: _WorkoutSetInMovesList(
              roundNumber: roundNumber,
              state: widget.state,
              workoutSectionType: widget.workoutSection.workoutSectionType,
              workoutSet: workoutSet,
            ),
          );
        }).toList(),
      ];

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
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
          shrinkWrap: true,
          controller: _autoScrollController,
          padding: const EdgeInsets.only(bottom: kBottomNavBarHeight),
          children: List.generate(widget.workoutSection.rounds,
                  (roundNumber) => _movesList(roundNumber))
              .expand((x) => x)
              .toList()),
    );
  }
}

class _WorkoutSetInMovesList extends StatelessWidget {
  final WorkoutSectionType workoutSectionType;
  final WorkoutSectionProgressState state;
  final int roundNumber;
  final WorkoutSet workoutSet;
  const _WorkoutSetInMovesList(
      {Key? key,
      required this.state,
      required this.roundNumber,
      required this.workoutSet,
      required this.workoutSectionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCurrentActiveSet = state.currentSectionRound == roundNumber &&
        state.currentSetIndex == workoutSet.sortPosition;

    return AnimatedOpacity(
      opacity: DoWorkoutUtils.moveIsCompleted(
              state, roundNumber, workoutSet.sortPosition)
          ? 0.6
          : 1,
      duration: kStandardAnimationDuration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            WorkoutSetDisplay(
                workoutSet: workoutSet, workoutSectionType: workoutSectionType),
            if (state.setTimeRemainingMs != null && workoutSet.duration != null)
              GrowInOut(
                  show: isCurrentActiveSet,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: LinearPercentIndicator(
                      percent: isCurrentActiveSet
                          ? 1 -
                              (state.setTimeRemainingMs! /
                                  (workoutSet.duration! * 1000))
                          : 0,
                      linearGradient: Styles.pinkGradient,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      lineHeight: 4,
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
