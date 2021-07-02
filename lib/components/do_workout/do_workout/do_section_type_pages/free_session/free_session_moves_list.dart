import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/free_session_section_controller.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_set_definition.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/load_picker.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class FreeSessionMovesList extends StatelessWidget {
  final FreeSessionSectionController freeSessionController;
  const FreeSessionMovesList({
    Key? key,
    required this.freeSessionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutSets = freeSessionController.workoutSection.workoutSets
        .sortedBy<num>((wSet) => wSet.sortPosition);

    final loggedWorkoutSets =
        freeSessionController.loggedWorkoutSection.loggedWorkoutSets;

    return ListView.builder(
      itemCount: sortedWorkoutSets.length + 2,
      itemBuilder: (c, i) {
        if (i == sortedWorkoutSets.length + 1) {
          return SizedBox(height: kBottomNavBarHeight);
        } else if (i == sortedWorkoutSets.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CreateTextIconButton(
                  text: 'Add Set',
                  onPressed: () => print('create set'),
                ),
              ],
            ),
          );
        } else {
          final setIsMarkedComplete = loggedWorkoutSets.any((lwSet) =>
              lwSet.sortPosition == sortedWorkoutSets[i].sortPosition);

          return SizeFadeIn(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AnimatedOpacity(
              opacity: setIsMarkedComplete ? 0.5 : 1,
              duration: kStandardAnimationDuration,
              child: _WorkoutSetInFreeSession(
                  workoutSet: sortedWorkoutSets[i],
                  setIsMarkedComplete: setIsMarkedComplete,
                  freeSessionController: freeSessionController),
            ),
          ));
        }
      },
    );
  }
}

class _WorkoutSetInFreeSession extends StatelessWidget {
  final WorkoutSet workoutSet;
  final bool setIsMarkedComplete;
  final FreeSessionSectionController freeSessionController;
  _WorkoutSetInFreeSession({
    required this.workoutSet,
    required this.setIsMarkedComplete,
    required this.freeSessionController,
  });

  void _handleMarkSetComplete(BuildContext context) {
    freeSessionController.markWorkoutSetComplete(context, workoutSet);
  }

  void _handleMarkSetInComplete() {
    freeSessionController.markWorkoutSetIncomplete(workoutSet);
  }

  void _updateWorkoutSetRepeats(int repeats) {
    freeSessionController.updateWorkoutSetRepeats(
        workoutSet.sortPosition, repeats);
  }

  void _updateWorkoutMove(WorkoutMove workoutMove) {
    freeSessionController.updateWorkoutMove(
        workoutSet.sortPosition, workoutMove);
  }

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutMoves =
        workoutSet.workoutMoves.sortedBy<num>((wMove) => wMove.sortPosition);
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BorderButton(
                        mini: true,
                        text:
                            'Repeat ${workoutSet.rounds} ${workoutSet.rounds == 1 ? "time" : "times"}',
                        onPressed: () => context.showBottomSheet<int>(
                                child: NumberInputModalInt(
                              value: workoutSet.rounds,
                              saveValue: _updateWorkoutSetRepeats,
                              title: 'How many repeats?',
                            ))),
                    WorkoutSetDefinition(workoutSet),
                  ],
                ),
                AnimatedSwitcher(
                  duration: kStandardAnimationDuration,
                  child: setIsMarkedComplete
                      ? CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _handleMarkSetInComplete,
                          child: Icon(
                            CupertinoIcons.checkmark_alt_circle,
                            size: 34,
                            color: Styles.pink,
                          ),
                        )
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _handleMarkSetComplete(context),
                          child: Icon(
                            CupertinoIcons.add_circled,
                            size: 34,
                          ),
                        ),
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: sortedWorkoutMoves.length,
            itemBuilder: (context, index) => _WorkoutMoveInFreeSession(
              key: Key(
                  '$index-free-session-moves-list-${sortedWorkoutMoves[index].id}'),
              workoutMove: sortedWorkoutMoves[index],
              isLast: index == sortedWorkoutMoves.length - 1,
              updateWorkoutMove: _updateWorkoutMove,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutMoveInFreeSession extends StatelessWidget {
  final Key key;
  final WorkoutMove workoutMove;
  final void Function(WorkoutMove workoutMove) updateWorkoutMove;
  final bool isLast;
  final bool showReps;

  _WorkoutMoveInFreeSession(
      {required this.key,
      required this.workoutMove,
      required this.updateWorkoutMove,
      this.showReps = true,
      this.isLast = false});

  void _updateLoad(double loadAmount, LoadUnit loadUnit) {
    final updated = WorkoutMove.fromJson(workoutMove.toJson());
    updated.loadUnit = loadUnit;
    updated.loadAmount = loadAmount;
    updateWorkoutMove(updated);
  }

  void _updateReps(double reps) {
    final updated = WorkoutMove.fromJson(workoutMove.toJson());
    updated.reps = reps;
    updateWorkoutMove(updated);
  }

  String _repUnitString() {
    switch (workoutMove.repType) {
      case WorkoutMoveRepType.artemisUnknown:
      case WorkoutMoveRepType.reps:
      case WorkoutMoveRepType.calories:
        return '';
      case WorkoutMoveRepType.distance:
        return ' - ${workoutMove.distanceUnit.display}';
      case WorkoutMoveRepType.time:
        return ' - ${workoutMove.timeUnit.display}';
      default:
        throw Exception(
            'Error rendering a rep unit string for ${workoutMove.repType}');
    }
  }

  String _adjustRepTypeString() =>
      '${workoutMove.repType.display}${_repUnitString()} ';

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      actionPane: SlidableDrawerActionPane(),
      closeOnScroll: true,
      actionExtentRatio: 0.20,
      secondaryActions: [
        IconSlideAction(
          caption: workoutMove.repType.display,
          color: Styles.infoBlue,
          iconWidget: Icon(
            CupertinoIcons.plus_slash_minus,
            size: 20,
            color: Styles.white,
          ),
          onTap: () => context.showBottomSheet(
              expand: true,
              child: NumberInputModalDouble(
                  title: _adjustRepTypeString(),
                  value: workoutMove.reps,
                  saveValue: _updateReps)),
        ),
        IconSlideAction(
          caption: 'Load',
          color: Styles.colorThree,
          iconWidget: Icon(
            CupertinoIcons.plus_slash_minus,
            size: 20,
            color: Styles.white,
          ),
          onTap: () => context.showBottomSheet(
              child: LoadPickerModal(
            loadAmount: workoutMove.loadAmount,
            updateLoad: _updateLoad,
            loadUnit: workoutMove.loadUnit,
          )),
        ),
      ],
      child: WorkoutMoveDisplay(
        workoutMove,
        isLast: isLast,
        showReps: showReps,
      ),
    );
  }
}
