import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class RepPickerDisplay extends StatelessWidget {
  final double reps;
  final void Function(double reps) updateReps;
  final WorkoutMoveRepType repType;
  final void Function(WorkoutMoveRepType repType) updateRepType;
  final DistanceUnit distanceUnit;
  final void Function(DistanceUnit distanceUnit) updateDistanceUnit;
  final TimeUnit timeUnit;
  final void Function(TimeUnit timeUnit) updateTimeUnit;
  RepPickerDisplay({
    required this.reps,
    required this.updateReps,
    required this.repType,
    required this.updateRepType,
    required this.distanceUnit,
    required this.updateDistanceUnit,
    required this.timeUnit,
    required this.updateTimeUnit,
  });

  Widget _buildRepTypeDisplay() {
    switch (repType) {
      case WorkoutMoveRepType.distance:
        return MyText(
          describeEnum(distanceUnit),
          size: FONTSIZE.LARGE,
        );
      case WorkoutMoveRepType.time:
        return MyText(
          describeEnum(timeUnit),
          size: FONTSIZE.LARGE,
        );
      default:
        return MyText(
          describeEnum(repType),
          size: FONTSIZE.LARGE,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.showBottomSheet(
          child: RepPickerModal(
        reps: reps,
        updateReps: updateReps,
        repType: repType,
        updateRepType: updateRepType,
        distanceUnit: distanceUnit,
        updateDistanceUnit: updateDistanceUnit,
        timeUnit: timeUnit,
        updateTimeUnit: updateTimeUnit,
      )),
      child: ContentBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              reps.stringMyDouble(),
              size: FONTSIZE.DISPLAY,
            ),
            SizedBox(
              width: 4,
            ),
            _buildRepTypeDisplay(),
          ],
        ),
      ),
    );
  }
}

class RepPickerModal extends StatefulWidget {
  final double reps;
  final void Function(double reps) updateReps;
  final WorkoutMoveRepType repType;
  final void Function(WorkoutMoveRepType repType) updateRepType;
  final DistanceUnit distanceUnit;
  final void Function(DistanceUnit distanceUnit) updateDistanceUnit;
  final TimeUnit timeUnit;
  final void Function(TimeUnit timeUnit) updateTimeUnit;
  RepPickerModal({
    required this.reps,
    required this.updateReps,
    required this.repType,
    required this.updateRepType,
    required this.distanceUnit,
    required this.updateDistanceUnit,
    required this.timeUnit,
    required this.updateTimeUnit,
  });

  @override
  _RepPickerModalState createState() => _RepPickerModalState();
}

class _RepPickerModalState extends State<RepPickerModal> {
  late TextEditingController _repsController;
  late double _activeReps;
  late WorkoutMoveRepType _activeRepType;
  late DistanceUnit _activeDistanceUnit;
  late TimeUnit _activeTimeUnit;

  @override
  void initState() {
    _activeReps = widget.reps;
    _activeRepType = widget.repType;
    _activeDistanceUnit = widget.distanceUnit;
    _activeTimeUnit = widget.timeUnit;
    _repsController = TextEditingController(text: widget.reps.stringMyDouble());
    _repsController.addListener(() {
      if (Utils.textNotNull(_repsController.text)) {
        setState(() => _activeReps = double.parse(_repsController.text));
      }
    });
    super.initState();
  }

  void _saveChanges() {
    if (_activeReps != widget.reps) {
      widget.updateReps(_activeReps);
    }
    if (_activeRepType != widget.repType) {
      widget.updateRepType(_activeRepType);
    }
    if (_activeDistanceUnit != widget.distanceUnit) {
      widget.updateDistanceUnit(_activeDistanceUnit);
    }
    if (_activeTimeUnit != widget.timeUnit) {
      widget.updateTimeUnit(_activeTimeUnit);
    }
    context.pop();
  }

  @override
  void dispose() {
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalCupertinoPageScaffold(
      cancel: context.pop,
      save: _saveChanges,
      validToSave: Utils.textNotNull(_repsController.text),
      title: 'Reps',
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSlidingSegmentedControl<WorkoutMoveRepType>(
                    groupValue: _activeRepType,
                    thumbColor: Styles.colorOne,
                    children: {
                      for (final v in WorkoutMoveRepType.values
                          .where((v) => v != WorkoutMoveRepType.artemisUnknown))
                        v: MyText(v.display)
                    },
                    onValueChanged: (repType) {
                      if (repType != null) {
                        setState(() => _activeRepType = repType);
                      }
                    }),
              ],
            ),
            if (_activeRepType != WorkoutMoveRepType.time)
              FadeIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: MyNumberInput(
                    _repsController,
                    autoFocus: false,
                  ),
                ),
              ),
            if (_activeRepType == WorkoutMoveRepType.time)
              FadeIn(
                  child: RepTimePicker(
                      reps: _activeReps,
                      updateReps: (reps) => setState(() => _activeReps = reps),
                      timeUnit: _activeTimeUnit,
                      updateTimeUnit: (timeUnit) =>
                          setState(() => _activeTimeUnit = timeUnit))),
            if ([WorkoutMoveRepType.calories, WorkoutMoveRepType.reps]
                .contains(_activeRepType))
              FadeIn(child: MyText(_activeRepType.display)),
            if (_activeRepType == WorkoutMoveRepType.distance)
              FadeIn(
                child: CupertinoSlidingSegmentedControl<DistanceUnit>(
                    groupValue: _activeDistanceUnit,
                    thumbColor: Styles.colorOne,
                    children: {
                      for (final v in DistanceUnit.values
                          .where((v) => v != DistanceUnit.artemisUnknown))
                        v: MyText(v.display)
                    },
                    onValueChanged: (distanceUnit) {
                      if (distanceUnit != null) {
                        setState(() => _activeDistanceUnit = distanceUnit);
                      }
                    }),
              )
          ],
        ),
      ),
    );
  }
}

/// User can pick from hours, minutes or seconds and dial in the number they want to work for.
class RepTimePicker extends StatelessWidget {
  final double reps;
  final void Function(double reps) updateReps;
  final TimeUnit timeUnit;
  final void Function(TimeUnit timeUnit) updateTimeUnit;
  RepTimePicker(
      {required this.reps,
      required this.updateReps,
      required this.timeUnit,
      required this.updateTimeUnit});

  final maxInput = 500;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            height: 180,
            width: 200,
            child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: min(reps.toInt(), maxInput) - 1),
                itemExtent: 35,
                onSelectedItemChanged: (index) => updateReps(index + 1),
                children: List<Widget>.generate(maxInput - 1,
                    (i) => Center(child: H3((i + 1).toString()))))),
        CupertinoSlidingSegmentedControl<TimeUnit>(
            groupValue: timeUnit,
            thumbColor: Styles.colorOne,
            children: {
              for (final v
                  in TimeUnit.values.where((v) => v != TimeUnit.artemisUnknown))
                v: MyText(describeEnum(v))
            },
            onValueChanged: (timeUnit) {
              if (timeUnit != null) {
                updateTimeUnit(timeUnit);
              }
            }),
      ],
    );
  }
}
