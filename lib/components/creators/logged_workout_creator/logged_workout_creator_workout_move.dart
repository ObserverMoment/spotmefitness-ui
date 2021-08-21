import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_move_display.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/load_picker.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

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

  void _updateLoad(double loadAmount, LoadUnit loadUnit) {
    final updated = LoggedWorkoutMove.fromJson(loggedWorkoutMove.toJson());
    updated.loadUnit = loadUnit;
    updated.loadAmount = loadAmount;
    updateLoggedWorkoutMove(updated);
  }

  void _updateReps(double reps) {
    final updated = LoggedWorkoutMove.fromJson(loggedWorkoutMove.toJson());
    updated.reps = reps;
    updateLoggedWorkoutMove(updated);
  }

  String _repUnitString() {
    switch (loggedWorkoutMove.repType) {
      case WorkoutMoveRepType.artemisUnknown:
      case WorkoutMoveRepType.reps:
      case WorkoutMoveRepType.calories:
        return '';
      case WorkoutMoveRepType.distance:
        return ' - ${loggedWorkoutMove.distanceUnit.display}';
      case WorkoutMoveRepType.time:
        return ' - ${loggedWorkoutMove.timeUnit.display}';
      default:
        throw Exception(
            'Error rendering a rep unit string for ${loggedWorkoutMove.repType}');
    }
  }

  String _adjustRepTypeString() =>
      '${loggedWorkoutMove.repType.display}${_repUnitString()} ';

  @override
  Widget build(BuildContext context) {
    return AnimatedSlidable(
      key: key,
      index: loggedWorkoutMove.sortPosition,
      itemType: 'Move',
      removeItem: deleteLoggedWorkoutMove,
      secondaryActions: [
        IconSlideAction(
          caption: loggedWorkoutMove.repType.display,
          color: Styles.infoBlue,
          iconWidget: Icon(
            CupertinoIcons.plus_slash_minus,
            size: 20,
            color: Styles.white,
          ),
          onTap: () => context.showBottomSheet(
              child: NumberInputModalDouble(
                  title: _adjustRepTypeString(),
                  value: loggedWorkoutMove.reps,
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
            loadAmount: loggedWorkoutMove.loadAmount ?? 0,
            updateLoad: _updateLoad,
            loadUnit: loggedWorkoutMove.loadUnit,
          )),
        ),
      ],
      child: LoggedWorkoutMoveDisplay(
        loggedWorkoutMove,
        isLast: isLast,
      ),
    );
  }
}
