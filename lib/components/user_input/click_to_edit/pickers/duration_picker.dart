import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/close_picker.dart';
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
      prefix: Icon(CupertinoIcons.stopwatch, size: 13),
      onPressed: () => context.showBottomSheet(
          child: DurationPicker(
        duration: duration,
        updateDuration: updateDuration,
        title: modalTitle,
      )),
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
      padding: const EdgeInsets.only(bottom: 16.0),
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
