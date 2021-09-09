import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/close_picker.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DurationPickerDisplay extends StatelessWidget {
  final String modalTitle;
  final Duration? duration;
  final void Function(Duration duration) updateDuration;
  DurationPickerDisplay(
      {required this.updateDuration,
      this.duration,
      this.modalTitle = 'Enter duration'});

  @override
  Widget build(BuildContext context) {
    return BorderButton(
      mini: true,
      text: duration != null ? duration!.compactDisplay() : 'Duration...',
      prefix: Icon(CupertinoIcons.stopwatch, size: 18),
      onPressed: () => context.showBottomSheet(
          child: DurationPicker(
        duration: duration,
        updateDuration: updateDuration,
        title: modalTitle,
      )),
    );
  }
}

class DurationPickerRowDisplay extends StatelessWidget {
  final Duration? duration;
  final void Function(Duration duration) updateDuration;
  const DurationPickerRowDisplay(
      {Key? key, required this.duration, required this.updateDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasDuration = duration != null;
    return UserInputContainer(
      child: Column(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.showBottomSheet(
                expand: false,
                child: DurationPicker(
                  duration: duration,
                  mode: CupertinoTimerPickerMode.hm,
                  minuteInterval: 5,
                  updateDuration: updateDuration,
                  title: 'Workout Duration',
                )),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Row(
                    children: [
                      MyText(
                        'Duration',
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        CupertinoIcons.clock,
                        size: 18,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: MyText(
                    hasDuration ? duration!.displayString : 'Add... (optional)',
                    subtext: !hasDuration,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              MyText(
                'How long this workout should take in total.',
                size: FONTSIZE.SMALL,
                maxLines: 3,
                subtext: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkoutSetDurationPicker extends StatefulWidget {
  final Duration? duration;
  final void Function(Duration duration, bool copyToAll) updateDuration;
  final String? title;
  final String switchTitle;
  final CupertinoTimerPickerMode mode;
  final int minuteInterval;
  final int secondInterval;
  WorkoutSetDurationPicker(
      {required this.duration,
      required this.updateDuration,
      this.title,
      this.minuteInterval = 1,
      this.secondInterval = 5,
      this.mode = CupertinoTimerPickerMode.ms,
      this.switchTitle = 'Copy to all sets'});

  @override
  _WorkoutSetDurationPickerState createState() =>
      _WorkoutSetDurationPickerState();
}

class _WorkoutSetDurationPickerState extends State<WorkoutSetDurationPicker> {
  late Duration? _activeDuration;

  /// Allows the user to bulk update the duration on all / a group of sets.
  bool _copyToAll = false;

  @override
  void initState() {
    super.initState();
    _activeDuration = widget.duration;
  }

  void _saveAndClose() {
    if (_activeDuration != null) {
      widget.updateDuration(_activeDuration!, _copyToAll);
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: H2(widget.title!),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClosePicker(onClose: _saveAndClose),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CupertinoSwitchRow(
                title: widget.switchTitle,
                updateValue: (v) => setState(() => _copyToAll = v),
                value: _copyToAll),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoTimerPicker(
                initialTimerDuration: _activeDuration ?? Duration.zero,
                mode: widget.mode,
                minuteInterval: widget.minuteInterval,
                secondInterval: widget.secondInterval,
                onTimerDurationChanged: (duration) =>
                    setState(() => _activeDuration = duration)),
          ),
        ],
      ),
    );
  }
}

class DurationPicker extends StatefulWidget {
  final Duration? duration;
  final void Function(Duration duration) updateDuration;
  final String? title;
  final CupertinoTimerPickerMode mode;
  final int minuteInterval;
  final int secondInterval;
  DurationPicker(
      {required this.duration,
      required this.updateDuration,
      this.title,
      this.minuteInterval = 1,
      this.secondInterval = 1,
      this.mode = CupertinoTimerPickerMode.hms});

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late Duration? _activeDuration;

  @override
  void initState() {
    super.initState();
    _activeDuration = widget.duration;
  }

  void _saveAndClose() {
    if (_activeDuration != null) {
      widget.updateDuration(_activeDuration!);
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: H2(widget.title!),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClosePicker(onClose: _saveAndClose),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoTimerPicker(
                initialTimerDuration: _activeDuration ?? Duration.zero,
                mode: widget.mode,
                minuteInterval: widget.minuteInterval,
                secondInterval: widget.secondInterval,
                onTimerDurationChanged: (duration) =>
                    setState(() => _activeDuration = duration)),
          ),
        ],
      ),
    );
  }
}
