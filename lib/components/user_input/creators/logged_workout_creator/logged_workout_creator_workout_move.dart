import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_move_display.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/load_picker.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutCreatorWorkoutMove extends StatelessWidget {
  final Key key;
  final LoggedWorkoutMove loggedWorkoutMove;
  final void Function(int index) deleteLoggedWorkoutMove;
  final void Function(LoggedWorkoutMove loggedWorkoutMove)
      updateLoggedWorkoutMove;
  final bool isLast;
  LoggedWorkoutCreatorWorkoutMove(
      {required this.key,
      required this.deleteLoggedWorkoutMove,
      required this.updateLoggedWorkoutMove,
      required this.loggedWorkoutMove,
      this.isLast = false});

  void _updateLoadUnit(LoadUnit loadUnit) {
    final updated = LoggedWorkoutMove.fromJson(loggedWorkoutMove.toJson());
    updated.loadUnit = loadUnit;
    updateLoggedWorkoutMove(updated);
  }

  void _updateLoadAmount(double loadAmount) {
    final updated = LoggedWorkoutMove.fromJson(loggedWorkoutMove.toJson());
    updated.loadAmount = loadAmount;
    updateLoggedWorkoutMove(updated);
  }

  void _updateReps(double reps) {
    final updated = LoggedWorkoutMove.fromJson(loggedWorkoutMove.toJson());
    updated.reps = reps;
    updateLoggedWorkoutMove(updated);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlidable(
      key: key,
      index: loggedWorkoutMove.sortPosition,
      itemType: 'Move',
      removeItem: deleteLoggedWorkoutMove,
      secondaryActions: [
        IconSlideAction(
          caption: 'Adjust reps',
          color: Styles.infoBlue,
          iconWidget: Icon(
            CupertinoIcons.arrow_2_circlepath,
            size: 20,
          ),
          onTap: () => print(
              'open adjust reps - need new simplified picker that just lets you adjust the rp type that is selected - not change between rep types etc.'),
        ),
        IconSlideAction(
          caption: 'Adjust load',
          color: Styles.colorThree,
          iconWidget: Icon(
            CupertinoIcons.arrow_up_arrow_down,
            size: 20,
          ),
          onTap: () => context.showBottomSheet(
              child: LoadPickerModal(
                  loadAmount: loggedWorkoutMove.loadAmount ?? 0,
                  updateLoadAmount: _updateLoadAmount,
                  loadUnit: loggedWorkoutMove.loadUnit,
                  updateLoadUnit: _updateLoadUnit)),
        ),
      ],
      child: LoggedWorkoutMoveDisplay(loggedWorkoutMove),
    );
  }
}
