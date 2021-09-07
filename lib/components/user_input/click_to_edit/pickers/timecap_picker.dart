import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/close_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class TimecapPicker extends StatelessWidget {
  final Duration? timecap;
  final Function(Duration? duration) saveTimecap;

  /// Defaults to true. Hides the on / off switch in the [TimecapPicker] if false. And will not render the widget if [timecap] is null.
  final bool allowNoTimecap;

  /// Let the user click outside of the modal to close it without doing anything.
  /// set false if input is required.
  final bool allowPopupDismiss;
  final String popupTitle;
  TimecapPicker(
      {required this.timecap,
      required this.saveTimecap,
      this.allowNoTimecap = true,
      this.allowPopupDismiss = true,
      this.popupTitle = 'Time Limit'})
      : assert(allowNoTimecap || timecap != null,
            'timecap must not be null if you are not allowing no timecap to be set.');

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        await context.showBottomSheet(
          expand: false,
          showDragHandle: false,
          child: TimecapPopup(
              timecap: timecap,
              allowNoTimecap: allowNoTimecap,
              saveTimecap: saveTimecap),
        );
      },
      padding: const EdgeInsets.all(8),
      child: CompactTimerIcon(
        timecap,
      ),
    );
  }
}

class TimecapPopup extends StatefulWidget {
  final Duration? timecap;
  final Function(Duration? duration) saveTimecap;

  /// Defaults to true. Hides the on / off switch if false. And will not render the widget if [timecap] is null.
  final bool allowNoTimecap;
  final String title;
  TimecapPopup(
      {required this.timecap,
      required this.saveTimecap,
      this.allowNoTimecap = true,
      this.title = 'Time Limit'})
      : assert(allowNoTimecap || timecap != null,
            'timecap must not be null if you are not allowing no timecap to be set.');

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

  void _handleSave() {
    widget.saveTimecap(_isOn ? _activeTimecap : null);
    context.pop(result: _isOn ? _activeTimecap : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClosePicker(onClose: _handleSave),
            SizedBox(height: 15),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  H3(widget.title),
                  if (widget.allowNoTimecap)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SlidingSelect<bool>(
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
                    ),
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
