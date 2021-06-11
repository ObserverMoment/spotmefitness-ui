import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/lists.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_in_set.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:flutter/material.dart' as material;
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/dragged_item.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// For [Tabata Style] workouts.
class WorkoutTabataSetCreator extends StatefulWidget {
  final Key key;
  final int sectionIndex;
  final int setIndex;
  final bool scrollable;
  final bool allowReorder;
  final Move restMove;
  WorkoutTabataSetCreator({
    required this.key,
    required this.sectionIndex,
    required this.setIndex,
    required this.restMove,
    this.scrollable = false,
    this.allowReorder = false,
  });

  @override
  _WorkoutTabataSetCreatorState createState() =>
      _WorkoutTabataSetCreatorState();
}

class _WorkoutTabataSetCreatorState extends State<WorkoutTabataSetCreator> {
  late List<WorkoutMove> _sortedWorkoutMoves;
  late WorkoutSet _workoutSet;
  late WorkoutCreatorBloc _bloc;
  late bool _showFullSetInfo;
  bool _shouldRebuild = false;

  void _checkForNewData() {
    if (_showFullSetInfo != _bloc.showFullSetInfo) {
      _showFullSetInfo = _bloc.showFullSetInfo;
      _shouldRebuild = true;
    }
    // Check that the set has not been deleted. Without this the below updates with throw an invalid index error every time a set is deleted.
    if (_bloc.workout.workoutSections[widget.sectionIndex].workoutSets.length >
        widget.setIndex) {
      final updatedSet = _bloc.workout.workoutSections[widget.sectionIndex]
          .workoutSets[widget.setIndex];
      final updatedWorkoutMoves = updatedSet.workoutMoves;

      if (_workoutSet != updatedSet) {
        _shouldRebuild = true;
        _workoutSet = WorkoutSet.fromJson(updatedSet.toJson());
      }

      if (!_sortedWorkoutMoves.equals(updatedWorkoutMoves)) {
        _shouldRebuild = true;
        _sortedWorkoutMoves =
            updatedWorkoutMoves.sortedBy<num>((wm) => wm.sortPosition);
      }
    }

    if (_shouldRebuild) {
      setState(() {});
    }
    _shouldRebuild = false;
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();

    _showFullSetInfo = _bloc.showFullSetInfo;

    _workoutSet = WorkoutSet.fromJson(_bloc.workout
        .workoutSections[widget.sectionIndex].workoutSets[widget.setIndex]
        .toJson());

    _sortedWorkoutMoves = _bloc.workout.workoutSections[widget.sectionIndex]
        .workoutSets[widget.setIndex].workoutMoves
        .sortedBy<num>((wm) => wm.sortPosition);

    _bloc.addListener(_checkForNewData);
  }

  void _deleteWorkoutSet() {
    context.showConfirmDeleteDialog(
        itemType: 'Set',
        onConfirm: () => context
            .read<WorkoutCreatorBloc>()
            .deleteWorkoutSet(widget.sectionIndex, widget.setIndex));
  }

  void _duplicateWorkoutSet() {
    _bloc.duplicateWorkoutSet(widget.sectionIndex, widget.setIndex);
  }

  void _moveWorkoutSetUpOne() {
    _bloc.reorderWorkoutSets(
        widget.sectionIndex, widget.setIndex, widget.setIndex - 1);
  }

  void _moveWorkoutSetDownOne() {
    _bloc.reorderWorkoutSets(
        widget.sectionIndex, widget.setIndex, widget.setIndex + 1);
  }

  void _openAddWorkoutMoveToSet() {
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WorkoutMoveCreator(
          pageTitle: 'Set ${widget.setIndex + 1}: Add Move',
          saveWorkoutMove: (workoutMove) => _bloc.createWorkoutMove(
              widget.sectionIndex, widget.setIndex, workoutMove),
          workoutMoveIndex: _sortedWorkoutMoves.length,
          fixedTimeReps: FixedTimeReps(reps: 20),
        ),
      ),
    );
  }

  void _addRestMoveToSet() {
    _bloc.createWorkoutMove(
        widget.sectionIndex,
        widget.setIndex,
        DefaultObjectfactory.defaultRestWorkoutMove(
            move: widget.restMove,
            sortPosition: _sortedWorkoutMoves.length,
            timeAmount: 10,
            timeUnit: TimeUnit.seconds));
  }

  void _openEditWorkoutMove(WorkoutMove workoutMove) {
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WorkoutMoveCreator(
            workoutMove: workoutMove,
            pageTitle: 'Set ${widget.setIndex + 1}: Edit Move',
            saveWorkoutMove: (workoutMove) => _bloc.editWorkoutMove(
                widget.sectionIndex, widget.setIndex, workoutMove),
            workoutMoveIndex: workoutMove.sortPosition,
            // When picking a move for a circuit station the number of reps only matters if there is more than one move at that station. Otherwise you need to know how many / much of each you need to be doing (alternating between them).
            ignoreReps: _sortedWorkoutMoves.length == 1),
      ),
    );
  }

  void _deleteWorkoutMove(int workoutMoveIndex) {
    _bloc.deleteWorkoutMove(
        widget.sectionIndex, widget.setIndex, workoutMoveIndex);
  }

  void _duplicateWorkoutMove(int workoutMoveIndex) {
    _bloc.duplicateWorkoutMove(
        widget.sectionIndex, widget.setIndex, workoutMoveIndex);
  }

  void _reorderWorkoutMoves(int from, int to) {
    _bloc.reorderWorkoutMoves(widget.sectionIndex, widget.setIndex, from, to);
  }

  String _buildStationTimeText() {
    if (_workoutSet.duration == null) {
      throw Exception(
          '_workoutSet.duration should be set when a new station (workoutSet) is created. It should never be null at this point.');
    } else {
      return _workoutSet.duration!.secondsToTimeDisplay();
    }
  }

  @override
  void dispose() {
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRestSet = _sortedWorkoutMoves.length == 1 &&
        _sortedWorkoutMoves[0].move.id == kRestMoveId;

    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircularBox(
                      child: MyText(
                        '${widget.setIndex + 1}',
                        color: Styles.white,
                        weight: FontWeight.bold,
                      ),
                      color: Styles.colorOne,
                      padding: const EdgeInsets.all(9),
                    ),
                    if (isRestSet)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            BorderButton(
                                mini: true,
                                text: _buildStationTimeText(),
                                onPressed: () => context.showBottomSheet(
                                    child: DurationPicker(
                                        duration: Duration(
                                            seconds: _workoutSet.duration!),
                                        updateDuration: (duration) => context
                                                .read<WorkoutCreatorBloc>()
                                                .editWorkoutSet(
                                                    widget.sectionIndex,
                                                    widget.setIndex, {
                                              'duration': duration.inSeconds
                                            })))),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Tag(
                                tag: 'REST',
                                fontSize: FONTSIZE.SMALL,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: BorderButton(
                            mini: true,
                            text:
                                'Repeat ${_workoutSet.rounds} ${_workoutSet.rounds == 1 ? "time" : "times"}',
                            onPressed: () => context.showBottomSheet<int>(
                                    child: NumberInputModalInt(
                                  value: _workoutSet.rounds,
                                  saveValue: (r) => context
                                      .read<WorkoutCreatorBloc>()
                                      .editWorkoutSet(widget.sectionIndex,
                                          widget.setIndex, {'rounds': r}),
                                  title: 'How many repeats?',
                                ))),
                      ),
                  ],
                ),
                NavBarEllipsisMenu(ellipsisCircled: false, items: [
                  if (widget.allowReorder)
                    ContextMenuItem(
                        text: 'Move Up',
                        iconData: CupertinoIcons.up_arrow,
                        onTap: _moveWorkoutSetUpOne),
                  if (widget.allowReorder)
                    ContextMenuItem(
                        text: 'Move Down',
                        iconData: CupertinoIcons.down_arrow,
                        onTap: _moveWorkoutSetDownOne),
                  ContextMenuItem(
                      text: 'Duplicate',
                      iconData: CupertinoIcons.doc_on_doc,
                      onTap: _duplicateWorkoutSet),
                  ContextMenuItem(
                    text: 'Delete',
                    iconData: CupertinoIcons.delete_simple,
                    onTap: _deleteWorkoutSet,
                    destructive: true,
                  ),
                ])
              ],
            ),
          ),
          if (!isRestSet)
            Column(
              children: [
                if (!_showFullSetInfo)
                  CommaSeparatedList(
                      _sortedWorkoutMoves.map((wm) => wm.move.name).toList())
                else
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: _sortedWorkoutMoves.length *
                            kWorkoutMoveListItemHeight,
                        child: material.ReorderableListView.builder(
                            proxyDecorator: (child, index, animation) =>
                                DraggedItem(child: child),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _sortedWorkoutMoves.length,
                            itemBuilder: (context, index) => WorkoutMoveInSet(
                                  key: Key(
                                      '$index-workout_tabata_set_creator-${_sortedWorkoutMoves[index].id}'),
                                  workoutMove: _sortedWorkoutMoves[index],
                                  deleteWorkoutMove: _deleteWorkoutMove,
                                  duplicateWorkoutMove: _duplicateWorkoutMove,
                                  openEditWorkoutMove: _openEditWorkoutMove,
                                  isLast:
                                      index == _sortedWorkoutMoves.length - 1,
                                  showReps: _sortedWorkoutMoves.length > 1,
                                ),
                            onReorder: _reorderWorkoutMoves),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CreateTextIconButton(
                            text: 'Add Move',
                            onPressed: _openAddWorkoutMoveToSet,
                          ),
                          if (_sortedWorkoutMoves.isNotEmpty)
                            CreateTextIconButton(
                              text: 'Add Rest',
                              onPressed: _addRestMoveToSet,
                            ),
                        ],
                      ),
                    ],
                  )
              ],
            )
        ],
      ),
    );
  }
}
