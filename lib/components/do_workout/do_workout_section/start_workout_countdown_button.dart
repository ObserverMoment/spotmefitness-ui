import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StartWorkoutCountdownButton extends StatefulWidget {
  final void Function() startSectionAfterCountdown;
  const StartWorkoutCountdownButton(
      {Key? key, required this.startSectionAfterCountdown})
      : super(key: key);

  @override
  _StartWorkoutCountdownButtonState createState() =>
      _StartWorkoutCountdownButtonState();
}

class _StartWorkoutCountdownButtonState
    extends State<StartWorkoutCountdownButton> {
  bool _counting = false;
  final int _countdownFromMs = 4000;
  late int _currentSeconds;
  late StopWatchTimer _timer;

  @override
  void initState() {
    super.initState();
    _timer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: _countdownFromMs,
      onEnded: widget.startSectionAfterCountdown,
    );

    _currentSeconds = _countdownFromMs ~/ 1000;

    _timer.secondTime.listen((seconds) {
      setState(() => _currentSeconds = seconds);
    });
  }

  void _startCountdown() {
    setState(() => _counting = true);
    _timer.onExecute.add(StopWatchExecute.start);
  }

  void _cancelCountdown() {
    setState(() => _counting = false);
    _timer.onExecute.add(StopWatchExecute.reset);
  }

  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displaySeconds =
        _currentSeconds == 0 ? 'GO!' : _currentSeconds.toString();
    return Container(
      alignment: Alignment.center,
      height: 120,
      child: AnimatedSwitcher(
          duration: kStandardAnimationDuration,
          child: _counting
              ? GestureDetector(
                  onTap: _cancelCountdown,
                  child: SizeFadeIn(
                    key: Key(displaySeconds),
                    child: MyText(
                      displaySeconds,
                      size: FONTSIZE.eleven,
                      lineHeight: 1,
                    ),
                  ),
                )
              : PrimaryButton(
                  suffixIconData: CupertinoIcons.arrow_right_circle,
                  text: 'Get Started',
                  onPressed: _startCountdown)),
    );
  }
}
