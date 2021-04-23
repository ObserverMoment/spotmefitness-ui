import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/close_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class TimecapPicker extends StatelessWidget {
  final Duration? timecap;
  final Function(Duration?) saveTimecap;
  TimecapPicker({required this.timecap, required this.saveTimecap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CupertinoButton(
          onPressed: () async {
            Duration? _newTimecap = await context.openBlurModalPopup(
                TimecapPopup(timecap: timecap),
                height: 400);
            saveTimecap(_newTimecap);
          },
          padding: const EdgeInsets.all(8),
          child: CompactTimerIcon(
            timecap,
            alignment: Axis.vertical,
          ),
        ),
      ],
    );
  }
}

class TimecapPopup extends StatefulWidget {
  final Duration? timecap;
  TimecapPopup({required this.timecap});
  @override
  _TimecapPopupState createState() => _TimecapPopupState();
}

class _TimecapPopupState extends State<TimecapPopup> {
  late Duration _activeTimecap;
  late bool _isOn;

  @override
  void initState() {
    _activeTimecap = widget.timecap ?? Duration(minutes: 1);
    _isOn = widget.timecap != null;
    super.initState();
  }

  void _handleClose() {
    context.pop(result: _isOn ? _activeTimecap : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 360,
        child: Column(
          children: <Widget>[
            ClosePicker(onClose: _handleClose),
            SizedBox(height: 15),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  H3('Time limit'),
                  SizedBox(
                    width: 20,
                  ),
                  SlidingSelect<bool>(
                      value: _isOn,
                      children: {
                        true: Padding(
                            padding: const EdgeInsets.all(4),
                            child: MyText('On')),
                        false: Padding(
                            padding: const EdgeInsets.all(4),
                            child: MyText('Off')),
                      },
                      updateValue: (bool? isOn) =>
                          setState(() => _isOn = isOn ?? false)),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: _isOn ? 1 : 0,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 400),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 260,
                    child: CupertinoTimerPicker(
                        initialTimerDuration: _activeTimecap,
                        onTimerDurationChanged: (newDuration) {
                          // Don't let the user enter zero. Use a toggle or some other switch
                          // if they want to enter a zero type value.
                          if (newDuration.inSeconds > 0)
                            setState(() => _activeTimecap = newDuration);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
