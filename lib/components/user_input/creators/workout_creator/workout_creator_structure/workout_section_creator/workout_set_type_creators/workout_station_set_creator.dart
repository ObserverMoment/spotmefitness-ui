import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/dragged_item.dart';
import 'package:spotmefitness_ui/components/menus.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Part of the workout creator suite of components.
/// Displays a workout station (for circuits) set with user interactions cuch as
/// [delete workoutMove], [addWorkoutMove (create superset)], [reorderWorkoutMove] etc.
/// A station can have one or moves moves.
/// If one move: reps are not required
/// If two or more moves: Reps are required and user will loop around them until [workoutSet.duration] has elapsed.
class WorkoutStationSetCreator extends StatefulWidget {
  final Key key;
  final int sectionIndex;
  final int setIndex;
  final bool scrollable;
  final bool allowReorder;
  WorkoutStationSetCreator({
    required this.key,
    required this.sectionIndex,
    required this.setIndex,
    this.scrollable = false,
    this.allowReorder = false,
  });

  @override
  _WorkoutStationSetCreatorState createState() =>
      _WorkoutStationSetCreatorState();
}

class _WorkoutStationSetCreatorState extends State<WorkoutStationSetCreator> {
  late List<WorkoutMove> _sortedWorkoutMoves;
  late WorkoutSet _workoutSet;
  late WorkoutCreatorBloc _bloc;

  void _checkForNewData() {
    // Check that the set has not been deleted. Without this the below updates with throw an invalid index error every time a set is deleted.
    if (_bloc.workout.workoutSections[widget.sectionIndex].workoutSets.length >
        widget.setIndex) {
      final updatedSet = _bloc.workout.workoutSections[widget.sectionIndex]
          .workoutSets[widget.setIndex];
      final updatedWorkoutMoves = updatedSet.workoutMoves;

      if (_workoutSet != updatedSet) {
        setState(() {
          _workoutSet = WorkoutSet.fromJson(updatedSet.toJson());
        });
      }

      if (!_sortedWorkoutMoves.equals(updatedWorkoutMoves))
        setState(() {
          _sortedWorkoutMoves =
              updatedWorkoutMoves.sortedBy<num>((wm) => wm.sortPosition);
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();
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
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: _bloc,
          child: WorkoutMoveCreator(
              pageTitle: 'Set ${widget.setIndex + 1}: Add Move',
              sectionIndex: widget.sectionIndex,
              setIndex: widget.setIndex,
              workoutMoveIndex: _sortedWorkoutMoves.length,
              // When picking a move for a circuit station the number of reps only matters if there is more than one move at that station. Otherwise you need to know how many / much of each you need to be doing (alternating between them).
              ignoreReps: _sortedWorkoutMoves.isEmpty),
        ),
      ),
    );
  }

  void _openEditWorkoutMove(WorkoutMove workoutMove) {
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: _bloc,
          child: WorkoutMoveCreator(
              workoutMove: workoutMove,
              pageTitle: 'Set ${widget.setIndex + 1}: Edit Move',
              sectionIndex: widget.sectionIndex,
              setIndex: widget.setIndex,
              workoutMoveIndex: workoutMove.sortPosition,
              // When picking a move for a circuit station the number of reps only matters if there is more than one move at that station. Otherwise you need to know how many / much of each you need to be doing (alternating between them).
              ignoreReps: _sortedWorkoutMoves.length == 1),
        ),
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
          '_workoutSet.duration should be set when a new station is created. It should never be null at this point.');
    } else {
      final String amount;
      final String unit;
      if (_workoutSet.duration! >= 3600) {
        // Hours
        amount = (_workoutSet.duration! / 3600).stringMyDouble();
        unit = amount == '1' ? 'hour' : 'hours';
      } else if (_workoutSet.duration! >= 60) {
        // Minutes
        amount = (_workoutSet.duration! / 60).stringMyDouble();
        unit = amount == '1' ? 'minute' : 'minutes';
      } else {
        // Seconds
        amount = (_workoutSet.duration!).toString();
        unit = amount == '1' ? 'second' : 'seconds';
      }

      return 'For $amount $unit';
    }
  }

  @override
  void dispose() {
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRest = _sortedWorkoutMoves.length == 1 &&
        _sortedWorkoutMoves[0].move.id == kRestMoveId;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
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
                    SizedBox(
                      width: 10,
                    ),
                    MiniButton(
                        text: _buildStationTimeText(),
                        onPressed: () => context.showBottomSheet(
                            child: DurationPicker(
                                duration: _workoutSet.duration!,
                                updateDuration: (seconds) => context
                                    .read<WorkoutCreatorBloc>()
                                    .editWorkoutSet(
                                        widget.sectionIndex,
                                        widget.setIndex,
                                        {'duration': seconds})))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (isRest)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Tag(
                              tag: 'REST',
                              fontSize: FONTSIZE.SMALL,
                            ),
                          ),
                        if (_sortedWorkoutMoves.length > 3)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Tag(
                              tag: 'GIANTSET',
                              color: Styles.colorThree,
                              textColor: Styles.white,
                            ),
                          )
                        else if (_sortedWorkoutMoves.length == 3)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Tag(
                              tag: 'TRISET',
                              color: Styles.colorThree,
                              textColor: Styles.white,
                            ),
                          )
                        else if (_sortedWorkoutMoves.length == 2)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Tag(
                              tag: 'SUPERSET',
                              color: Styles.colorThree,
                              textColor: Styles.white,
                            ),
                          )
                      ],
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
          if (!isRest)
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: _sortedWorkoutMoves.length * 62,
              child: ReorderableListView.builder(
                  proxyDecorator: (child, index, animation) =>
                      DraggedItem(child: child),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _sortedWorkoutMoves.length,
                  itemBuilder: (context, index) => WorkoutMoveInStationSet(
                        key: Key(
                            '$index-workout_station_set_creator-${_sortedWorkoutMoves[index].id}'),
                        workoutMove: _sortedWorkoutMoves[index],
                        deleteWorkoutMove: _deleteWorkoutMove,
                        duplicateWorkoutMove: _duplicateWorkoutMove,
                        openEditWorkoutMove: _openEditWorkoutMove,
                        isLast: index == _sortedWorkoutMoves.length - 1,
                        showReps: _sortedWorkoutMoves.length > 1,
                      ),
                  onReorder: _reorderWorkoutMoves),
            ),
          if (!isRest)
            CreateTextIconButton(
              text: 'Add move',
              onPressed: _openAddWorkoutMoveToSet,
            ),
        ],
      ),
    );
  }
}

class WorkoutMoveInStationSet extends StatelessWidget {
  final Key key;
  final WorkoutMove workoutMove;
  final void Function(WorkoutMove workoutMove) openEditWorkoutMove;
  final void Function(int index) duplicateWorkoutMove;
  final void Function(int index) deleteWorkoutMove;
  final bool showReps;
  final bool isLast;
  WorkoutMoveInStationSet(
      {required this.key,
      required this.workoutMove,
      required this.openEditWorkoutMove,
      required this.duplicateWorkoutMove,
      required this.deleteWorkoutMove,
      this.showReps = true,
      this.isLast = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openEditWorkoutMove(workoutMove),
      child: AnimatedSlidable(
        key: key,
        index: workoutMove.sortPosition,
        itemType: 'Move',
        removeItem: deleteWorkoutMove,
        secondaryActions: [
          IconSlideAction(
            caption: 'Duplicate',
            color: Styles.infoBlue,
            iconWidget: Icon(
              CupertinoIcons.doc_on_doc,
              size: 20,
            ),
            onTap: () => duplicateWorkoutMove(workoutMove.sortPosition),
          ),
        ],
        child: WorkoutMoveDisplay(
          workoutMove,
          isLast: isLast,
          showReps: showReps,
        ),
      ),
    );
  }
}
