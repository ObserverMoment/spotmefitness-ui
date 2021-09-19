import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/timer_components.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

/// Like the Stopwatch tab in iOS clock.
/// Does lap timing.
class StopwatchWithLaps extends StatefulWidget {
  /// Increases the text size when true
  final bool fullScreenDisplay;
  const StopwatchWithLaps({Key? key, this.fullScreenDisplay = false})
      : super(key: key);

  @override
  _StopwatchWithLapsState createState() => _StopwatchWithLapsState();
}

class _StopwatchWithLapsState extends State<StopwatchWithLaps> {
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
              builder: (context, AsyncSnapshot<int> msSnapshot) {
                return TimerDisplayText(
                  milliseconds: msSnapshot.data!,
                  fontSize: widget.fullScreenDisplay
                      ? FONTSIZE.EPIC
                      : FONTSIZE.EXTREME,
                  showMilliseconds: true,
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<StopWatchExecute>(
              initialData: StopWatchExecute.stop,
              stream: _stopWatchTimer.execute,
              builder:
                  (context, AsyncSnapshot<StopWatchExecute> stateSnapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedSwitcher(
                        duration: kStandardAnimationDuration,
                        child: stateSnapshot.data! == StopWatchExecute.stop
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
                        child: stateSnapshot.data! == StopWatchExecute.stop
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
