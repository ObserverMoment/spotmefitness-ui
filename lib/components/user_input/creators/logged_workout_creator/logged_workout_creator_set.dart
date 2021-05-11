import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/lists.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/creators/logged_workout_creator/logged_workout_creator_workout_move.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';

/// Displays a workout set with user interactions cuch as
/// For [Free Session], [AMRAP]
/// [delete workoutMove], [addWorkoutMove (create superset)], [reorderWorkoutMove] etc.
class LoggedWorkoutCreatorSet extends StatefulWidget {
  final int sectionIndex;
  final int setIndex;
  final bool scrollable;
  final bool allowReorder;
  LoggedWorkoutCreatorSet({
    required this.sectionIndex,
    required this.setIndex,
    this.scrollable = false,
    this.allowReorder = false,
  });

  @override
  _LoggedWorkoutCreatorSet createState() => _LoggedWorkoutCreatorSet();
}

class _LoggedWorkoutCreatorSet extends State<LoggedWorkoutCreatorSet> {
  late List<LoggedWorkoutMove> _sortedLoggedWorkoutMoves;
  late LoggedWorkoutSet _loggedWorkoutSet;
  late LoggedWorkoutCreatorBloc _bloc;
  late bool _showFullSetInfo;
  bool _shouldRebuild = false;

  void _checkForNewData() {
    if (_showFullSetInfo != _bloc.showFullSetInfo) {
      _showFullSetInfo = _bloc.showFullSetInfo;
      _shouldRebuild = true;
    }

    // Check that the set has not been deleted. Without this the below updates with throw an invalid index error every time a set is deleted.
    if (_bloc.loggedWorkout.loggedWorkoutSections[widget.sectionIndex]
            .loggedWorkoutSets.length >
        widget.setIndex) {
      final updatedSet = _bloc
          .loggedWorkout
          .loggedWorkoutSections[widget.sectionIndex]
          .loggedWorkoutSets[widget.setIndex];
      final updatedLoggedWorkoutMoves = updatedSet.loggedWorkoutMoves;

      if (_loggedWorkoutSet != updatedSet) {
        _shouldRebuild = true;
        _loggedWorkoutSet = LoggedWorkoutSet.fromJson(updatedSet.toJson());
      }

      if (!_sortedLoggedWorkoutMoves.equals(updatedLoggedWorkoutMoves)) {
        _shouldRebuild = true;
        _sortedLoggedWorkoutMoves =
            updatedLoggedWorkoutMoves.sortedBy<num>((wm) => wm.sortPosition);
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
    _bloc = context.read<LoggedWorkoutCreatorBloc>();

    _showFullSetInfo = _bloc.showFullSetInfo;

    _loggedWorkoutSet = LoggedWorkoutSet.fromJson(_bloc
        .loggedWorkout
        .loggedWorkoutSections[widget.sectionIndex]
        .loggedWorkoutSets[widget.setIndex]
        .toJson());

    _sortedLoggedWorkoutMoves = _bloc
        .loggedWorkout
        .loggedWorkoutSections[widget.sectionIndex]
        .loggedWorkoutSets[widget.setIndex]
        .loggedWorkoutMoves
        .sortedBy<num>((wm) => wm.sortPosition);

    _bloc.addListener(_checkForNewData);
  }

  void _deleteLoggedWorkoutSet() {
    context.showConfirmDeleteDialog(
        itemType: 'Set',
        onConfirm: () => context
            .read<LoggedWorkoutCreatorBloc>()
            .deleteLoggedWorkoutSet(widget.sectionIndex, widget.setIndex));
  }

  void _openAddLoggedWorkoutMoveToSet() {
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WorkoutMoveCreator(
          pageTitle: 'Set ${widget.setIndex + 1}: Add Move',
          saveWorkoutMove: (workoutMove) => _bloc.createLoggedWorkoutMove(
              widget.sectionIndex,
              widget.setIndex,
              workoutMoveToLoggedWorkoutMove(workoutMove)),
          workoutMoveIndex: _loggedWorkoutSet.loggedWorkoutMoves.length,
        ),
      ),
    );
  }

  void _updateLoggedWorkoutMove(LoggedWorkoutMove loggedWorkoutMove) {
    _bloc.editLoggedWorkoutMove(
        widget.sectionIndex, widget.setIndex, loggedWorkoutMove);
  }

  void _deleteLoggedWorkoutMove(int loggedWorkoutMoveIndex) {
    _bloc.deleteLoggedWorkoutMove(
        widget.sectionIndex, widget.setIndex, loggedWorkoutMoveIndex);
  }

  Widget _buildSetRepeats() => MiniButton(
      text:
          '${_loggedWorkoutSet.roundsCompleted} ${_loggedWorkoutSet.roundsCompleted == 1 ? "time" : "times"}',
      onPressed: () => context.showBottomSheet<int>(
              child: NumberInputModal<int>(
            value: _loggedWorkoutSet.roundsCompleted,
            // Need to cast to dynamic because of this.
            // https://github.com/dart-lang/sdk/issues/32042
            saveValue: <int>(dynamic r) => print(r),
            title: 'How many repeats?',
          )));

  Widget _buildSetDefinition() {
    final int length = _loggedWorkoutSet.loggedWorkoutMoves.length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: length > 3
          ? MyText(
              'GIANTSET',
              color: Styles.colorTwo,
              size: FONTSIZE.TINY,
              weight: FontWeight.bold,
            )
          : length == 3
              ? MyText(
                  'TRISET',
                  color: Styles.colorTwo,
                  size: FONTSIZE.TINY,
                  weight: FontWeight.bold,
                )
              : length == 2
                  ? MyText(
                      'SUPERSET',
                      color: Styles.colorTwo,
                      size: FONTSIZE.TINY,
                      weight: FontWeight.bold,
                    )
                  : Container(),
    );
  }

  Widget _buildSetTime() => MiniButton(
      text: (_loggedWorkoutSet.timeTakenMs! ~/ 1000).secondsToTimeDisplay(),
      onPressed: () => context.showBottomSheet(
          child: DurationPicker(
              duration: Duration(milliseconds: _loggedWorkoutSet.timeTakenMs!),
              updateDuration: (duration) => print(duration))));

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
                  children: [
                    _buildSetRepeats(),
                    if (_loggedWorkoutSet.timeTakenMs != null) _buildSetTime(),
                    _buildSetDefinition(),
                  ],
                ),
                NavBarEllipsisMenu(ellipsisCircled: false, items: [
                  ContextMenuItem(
                    text: 'Delete',
                    iconData: CupertinoIcons.delete_simple,
                    onTap: _deleteLoggedWorkoutSet,
                    destructive: true,
                  ),
                ])
              ],
            ),
          ),
          if (!_showFullSetInfo)
            CommaSeparatedList(_sortedLoggedWorkoutMoves
                .map((lwm) => lwm.moveSummary.name)
                .toList())
          else
            Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _sortedLoggedWorkoutMoves.length,
                    itemBuilder: (context, index) =>
                        LoggedWorkoutCreatorWorkoutMove(
                      updateLoggedWorkoutMove: _updateLoggedWorkoutMove,
                      deleteLoggedWorkoutMove: _deleteLoggedWorkoutMove,
                      key: Key(
                          '${_loggedWorkoutSet.setIndex} - LoggedWorkoutCreatorSet - $index.'),
                      loggedWorkoutMove: _sortedLoggedWorkoutMoves[index],
                    ),
                  ),
                ),
                CreateTextIconButton(
                  text: 'Add Move',
                  onPressed: _openAddLoggedWorkoutMoveToSet,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
