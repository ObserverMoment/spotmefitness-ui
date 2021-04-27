import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/close_picker.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DurationPicker extends StatefulWidget {
  /// in seconds
  final int duration;
  final void Function(int duration) updateDuration;
  final String? title;
  DurationPicker(
      {required this.duration, required this.updateDuration, this.title});

  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late Duration _activeDuration;

  @override
  void initState() {
    super.initState();
    _activeDuration = Duration(seconds: widget.duration);
  }

  void _saveAndClose() {
    widget.updateDuration(_activeDuration.inSeconds);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) H2(widget.title!),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClosePicker(onClose: _saveAndClose),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTimerPicker(
              initialTimerDuration: _activeDuration,
              mode: CupertinoTimerPickerMode.hms,
              onTimerDurationChanged: (duration) =>
                  setState(() => _activeDuration = duration)),
        ),
      ],
    );
  }
}
