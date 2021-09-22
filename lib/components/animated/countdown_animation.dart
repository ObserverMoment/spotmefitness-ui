import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountdownAnimation extends StatefulWidget {
  final VoidCallback onCountdownEnd;
  final int startFromSeconds;
  const CountdownAnimation(
      {Key? key, required this.onCountdownEnd, required this.startFromSeconds})
      : super(key: key);

  @override
  _CountdownAnimationState createState() => _CountdownAnimationState();
}

class _CountdownAnimationState extends State<CountdownAnimation> {
  late StopWatchTimer _timer;
  late int _currentSeconds;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.startFromSeconds;
    _timer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: widget.startFromSeconds * 1000,
      onChangeRawSecond: (seconds) => setState(() => _currentSeconds = seconds),
      onEnded: _onCountdownEnd,
    );
    _timer.onExecute.add(StopWatchExecute.start);
  }

  void _onCountdownEnd() {
    widget.onCountdownEnd();
    _timer.onExecute.add(StopWatchExecute.stop);
    _timer.onExecute.add(StopWatchExecute.reset);
  }

  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const MyHeaderText('GET READY!',
                        size: FONTSIZE.five, textAlign: TextAlign.center),
                    SizeFadeIn(
                        key: Key(_currentSeconds.toString()),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: MyHeaderText(
                            (_currentSeconds + 1).toString(),
                            size: FONTSIZE.eleven,
                          ),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
