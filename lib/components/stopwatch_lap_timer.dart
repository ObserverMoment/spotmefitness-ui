import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Like the Stopwatch tab in iOS clock.
/// Does lap timing.
class StopwatchLapTimer extends StatefulWidget {
  const StopwatchLapTimer({Key? key}) : super(key: key);

  @override
  _StopwatchLapTimerState createState() => _StopwatchLapTimerState();
}

class _StopwatchLapTimerState extends State<StopwatchLapTimer> {
  late StopWatchTimer _stopWatchTimer;
  final kButtonSize = 50.0;

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(isLapHours: false);
    super.initState();
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<int>(
              initialData: 0,
              stream: _stopWatchTimer.rawTime,
              builder: (context, AsyncSnapshot<int> snapshot) {
                return TimerDisplayText(
                  milliseconds: snapshot.data!,
                  size: 60,
                  showMilliseconds: true,
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<StopWatchExecute>(
              initialData: StopWatchExecute.stop,
              stream: _stopWatchTimer.execute,
              builder: (context, AsyncSnapshot<StopWatchExecute> snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedSwitcher(
                        duration: kStandardAnimationDuration,
                        child: snapshot.data! == StopWatchExecute.stop
                            ? StopwatchButton(
                                onPressed: () {
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.reset);
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.stop);
                                },
                                color: Styles.colorThree,
                                label: 'Reset')
                            : StopwatchButton(
                                onPressed: () => _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.lap),
                                color: Styles.colorTwo,
                                label: 'Lap',
                              )),
                    AnimatedSwitcher(
                        duration: kStandardAnimationDuration,
                        child: snapshot.data! == StopWatchExecute.stop
                            ? StopwatchButton(
                                onPressed: () => _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.start),
                                color: Styles.colorOne,
                                label: 'Start',
                              )
                            : StopwatchButton(
                                onPressed: () => _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop),
                                color: Styles.errorRed,
                                label: 'Stop',
                              )),
                  ],
                );
              }),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<List<StopWatchRecord>>(
                initialData: <StopWatchRecord>[],
                stream: _stopWatchTimer.records,
                builder:
                    (context, AsyncSnapshot<List<StopWatchRecord>> snapshot) {
                  final records = snapshot.data!;

                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (c, i) => SizeFadeIn(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: MyText('Lap ${i + 1}'),
                          ),
                          if (records[i].displayTime != null)
                            MyText(records[i].displayTime!),
                        ],
                      ),
                    ),
                    itemCount: records.length,
                    separatorBuilder: (c, i) => HorizontalLine(),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

/// Like the Timer tab in iOS clock.
/// Runs down to zero from a selected time. Pausable.
class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late StopWatchTimer _stopWatchTimer;
  final kButtonSize = 50.0;

  Duration _countdownTime = Duration.zero;

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countDown, onEnded: _handleCountdownComplete);
    super.initState();
  }

  void _handleStartCountdown() {
    if (_countdownTime != Duration.zero) {
      _stopWatchTimer.setPresetTime(mSec: _countdownTime.inMilliseconds);
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
  }

  void _handleClearReset() {
    _stopWatchTimer.clearPresetTime();
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  void _handleCountdownComplete() {
    print('beep beep');
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => StreamBuilder<StopWatchExecute>(
            initialData: StopWatchExecute.stop,
            stream: _stopWatchTimer.execute,
            builder: (context, AsyncSnapshot<StopWatchExecute> stateSnapshot) {
              final state = stateSnapshot.data!;

              return StreamBuilder<int>(
                  initialData: 0,
                  stream: _stopWatchTimer.rawTime,
                  builder: (context, AsyncSnapshot<int> msSnapshot) {
                    final milliseconds = msSnapshot.data!;
                    return Column(
                      children: [
                        SizedBox(
                          height: constraints.maxWidth * 0.6,
                          child: AnimatedSwitcher(
                            duration: kStandardAnimationDuration,
                            child: state == StopWatchExecute.reset
                                ? CupertinoTimerPicker(
                                    onTimerDurationChanged: (d) =>
                                        setState(() => _countdownTime = d),
                                  )
                                : CircularPercentIndicator(
                                    center: TimerDisplayText(
                                      milliseconds: milliseconds,
                                      size: 40,
                                    ),
                                    backgroundColor:
                                        context.theme.primary.withOpacity(0.1),
                                    linearGradient: Styles.pinkGradient,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    percent: (_countdownTime.inMilliseconds +
                                            1000 -
                                            milliseconds) /
                                        (_countdownTime.inMilliseconds + 1000),
                                    radius: constraints.maxWidth * 0.6),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AnimatedOpacity(
                              opacity:
                                  state == StopWatchExecute.reset ? 0.5 : 1,
                              duration: kStandardAnimationDuration,
                              child: StopwatchButton(
                                  onPressed: state == StopWatchExecute.reset
                                      ? () => null
                                      : _handleClearReset,
                                  label: 'Clear',
                                  color: Styles.colorFour),
                            ),
                            AnimatedSwitcher(
                              duration: kStandardAnimationDuration,
                              child: state == StopWatchExecute.start
                                  ? StopwatchButton(
                                      onPressed: () {
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.stop);
                                      },
                                      label: 'Stop',
                                      color: Styles.colorTwo)
                                  : AnimatedOpacity(
                                      opacity: _countdownTime == Duration.zero
                                          ? 0.5
                                          : 1,
                                      duration: kStandardAnimationDuration,
                                      child: StopwatchButton(
                                          onPressed: _handleStartCountdown,
                                          label: 'Start',
                                          color: Styles.colorOne),
                                    ),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            }));
  }
}

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
  const StopwatchButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.color})
      : super(key: key);

  final size = 80.0;

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
