import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/dragged_item.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/menus.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

/// Part of the workout creator suite of components.
/// Displays a workout set with user interactions cuch as
/// [delete workoutMove], [addWorkoutMove (create superset)], [reorderWorkoutMove] etc.
class WorkoutSetCreator extends StatefulWidget {
  final Key key;
  final int sectionIndex;
  final int setIndex;
  final bool scrollable;
  final bool allowReorder;
  WorkoutSetCreator({
    required this.key,
    required this.sectionIndex,
    required this.setIndex,
    this.scrollable = false,
    this.allowReorder = false,
  });

  @override
  _WorkoutSetCreatorState createState() => _WorkoutSetCreatorState();
}

class _WorkoutSetCreatorState extends State<WorkoutSetCreator> {
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

      if (_workoutSet != updatedSet)
        setState(() {
          _workoutSet = WorkoutSet.fromJson(updatedSet.toJson());
        });

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
          ),
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
          ),
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

  @override
  void dispose() {
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MiniButton(
                        text:
                            'Repeat ${_workoutSet.rounds} ${_workoutSet.rounds == 1 ? "time" : "times"}',
                        onPressed: () => context.showBottomSheet<int>(
                                child: NumberInputModal<int>(
                              value: _workoutSet.rounds,
                              // Need to cast to dynamic because of this.
                              // https://github.com/dart-lang/sdk/issues/32042
                              saveValue: <int>(dynamic r) => context
                                  .read<WorkoutCreatorBloc>()
                                  .editWorkoutSet(widget.sectionIndex,
                                      widget.setIndex, {'rounds': r}),
                              title: 'How many repeats?',
                            ))),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.allowReorder)
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _moveWorkoutSetUpOne,
                          child: Icon(CupertinoIcons.up_arrow)),
                    if (widget.allowReorder)
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _moveWorkoutSetDownOne,
                          child: Icon(CupertinoIcons.down_arrow)),
                    NavBarEllipsisMenu(ellipsisCircled: false, items: [
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
                )
              ],
            ),
          ),
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
                itemBuilder: (context, index) => WorkoutMoveInSet(
                      key: Key(
                          '$index-workout_set_creator-${_sortedWorkoutMoves[index].id}'),
                      workoutMove: _sortedWorkoutMoves[index],
                      deleteWorkoutMove: _deleteWorkoutMove,
                      duplicateWorkoutMove: _duplicateWorkoutMove,
                      openEditWorkoutMove: _openEditWorkoutMove,
                      isLast: index == _sortedWorkoutMoves.length - 1,
                    ),
                onReorder: _reorderWorkoutMoves),
          ),
          CreateTextIconButton(
            text: 'Add move',
            onPressed: _openAddWorkoutMoveToSet,
          ),
        ],
      ),
    );
  }
}

class WorkoutMoveInSet extends StatelessWidget {
  final Key key;
  final WorkoutMove workoutMove;
  final void Function(WorkoutMove workoutMove) openEditWorkoutMove;
  final void Function(int index) duplicateWorkoutMove;
  final void Function(int index) deleteWorkoutMove;
  final bool isLast;
  WorkoutMoveInSet(
      {required this.key,
      required this.workoutMove,
      required this.openEditWorkoutMove,
      required this.duplicateWorkoutMove,
      required this.deleteWorkoutMove,
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
        ),
      ),
    );
  }
}
