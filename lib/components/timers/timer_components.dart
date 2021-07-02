import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class TimerDisplayText extends StatelessWidget {
  final int milliseconds;
  final double size;
  final bool bold;
  final showMilliseconds;
  final showHours;
  const TimerDisplayText(
      {Key? key,
      required this.size,
      required this.milliseconds,
      this.bold = false,
      this.showMilliseconds = false,
      this.showHours = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        StopWatchTimer.getDisplayTime(milliseconds,
            hours: showHours, milliSecond: showMilliseconds),
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: context.theme.primary,
                fontSize: size,
                height: 1,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)));
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
            size: FONTSIZE.LARGE,
            color: Styles.white,
          ),
        ),
      ),
    );
  }
}
