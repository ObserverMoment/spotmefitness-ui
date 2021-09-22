import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerDisplayText extends StatelessWidget {
  final int milliseconds;
  final FONTSIZE fontSize;
  final bool bold;
  final bool showMilliseconds;
  final bool showHours;
  const TimerDisplayText(
      {Key? key,
      required this.fontSize,
      required this.milliseconds,
      this.bold = false,
      this.showMilliseconds = false,
      this.showHours = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyText(
      StopWatchTimer.getDisplayTime(milliseconds,
          hours: showHours, milliSecond: showMilliseconds),
      size: fontSize,
    );
  }
}

class StopwatchButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final Color color;
  final double size;
  const StopwatchButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.color,
      this.size = 80.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      onPressed: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: MyText(
            label,
            size: FONTSIZE.five,
            color: Styles.white,
          ),
        ),
      ),
    );
  }
}
