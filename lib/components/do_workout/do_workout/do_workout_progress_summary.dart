import 'package:flutter/cupertino.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/utils.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_minimal_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutProgressSummary extends StatefulWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  const DoWorkoutProgressSummary(
      {Key? key, required this.workoutSection, required this.state})
      : super(key: key);

  @override
  _DoWorkoutProgressSummaryState createState() =>
      _DoWorkoutProgressSummaryState();
}

class _DoWorkoutProgressSummaryState extends State<DoWorkoutProgressSummary> {
  /// Logic is similar to that found in [DoWorkoutMovesList] but with no user interaction.
  /// It also needs to take into account the start line (and finish line) which are also in the scroll_to_index list. Start line has an index of 0 so everything else is pushed up one index vs the start calculation which is found in [DoWorkoutMovesList] logic.
  /// This list scrolls with progress. There is no need for the user to search it. View only.
  late AutoScrollController _autoScrollController;

  late bool _hasFinishLine;
  late int _finishLineIndex;

  @override
  void initState() {
    super.initState();
    _autoScrollController = AutoScrollController();

    _hasFinishLine = kSectionTypesWithFinishLine
        .contains(widget.workoutSection.workoutSectionType.name);
    _finishLineIndex = (widget.workoutSection.rounds *
            widget.workoutSection.workoutSets.length) +
        1;
  }

  @override
  void didUpdateWidget(DoWorkoutProgressSummary oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// When reaching the end of the section [state.currentSectionRound] will be greater than the total [workoutSection.rounds] and will cause [AutoScrollController] to throw an error.
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
            child: _TimedWorkoutSetDisplay(
              roundNumber: roundNumber,
              state: widget.state,
              workoutSet: workoutSet,
            ),
          );
        }).toList(),
      ];

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(6),

      /// TODO: Uncomment when done.
      // physics: NeverScrollableScrollPhysics(),
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
            (roundNumber) => _movesList(roundNumber)).expand((x) => x).toList(),
        if (_hasFinishLine)
          AutoScrollTag(
            controller: _autoScrollController,
            index: _finishLineIndex,
            key: Key(_finishLineIndex.toString()),
            child: Column(
              children: [
                HorizontalLine(),
                MyText('Finish'),
                HorizontalLine(),
                SizedBox(height: kBottomNavBarHeight)
              ],
            ),
          )
      ],
    );
  }
}

class _TimedWorkoutSetDisplay extends StatelessWidget {
  final int roundNumber;
  final WorkoutSet workoutSet;
  final WorkoutSectionProgressState state;
  const _TimedWorkoutSetDisplay(
      {Key? key,
      required this.workoutSet,
      required this.state,
      required this.roundNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = state.currentSectionRound == roundNumber &&
        state.currentSetIndex == workoutSet.sortPosition;

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
        child: Padding(
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
        ),
      ),
    );
  }
}
