import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_section.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';

class DoWorkoutDoWorkoutPage extends StatefulWidget {
  final Workout workout;
  const DoWorkoutDoWorkoutPage({Key? key, required this.workout})
      : super(key: key);

  @override
  _DoWorkoutDoWorkoutPageState createState() => _DoWorkoutDoWorkoutPageState();
}

class _DoWorkoutDoWorkoutPageState extends State<DoWorkoutDoWorkoutPage> {
  final kNavbarIconSize = 38.0;
  final _stopWatchTimer = StopWatchTimer();

  int _activeSectionPageIndex = 0;
  final _sectionPageViewController = PageController();

  void _navigateToSectionPage(int index) {
    _sectionPageViewController.jumpToPage(index);
    setState(() => _activeSectionPageIndex = index);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  void _handleExitRequest() {
    context.showDialog(
        title: 'Quit the Workout?',
        barrierDismissible: true,
        actions: [
          CupertinoDialogAction(
              child: MyText('Quit without logging'),
              onPressed: () {
                context.pop();
                context.popRoute();
              }),
          CupertinoDialogAction(
              child: MyText('Log progress, then quit'),
              onPressed: () {
                context.pop();
                print('go to log');
              }),
          CupertinoDialogAction(
              child: MyText('Restart the workout'),
              onPressed: () {
                context.pop();
                print('reset log and restart');
              }),
          CupertinoDialogAction(
            child: MyText('Cancel'),
            onPressed: context.pop,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutSections = widget.workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition);
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: _handleExitRequest,
                  child:
                      Icon(CupertinoIcons.clear_thick, size: kNavbarIconSize),
                ),
                StreamBuilder<int>(
                    initialData: 0,
                    stream: _stopWatchTimer.rawTime,
                    builder: (context, AsyncSnapshot<int> snapshot) => Column(
                          children: [
                            MyText(
                              'Elapsed',
                              textAlign: TextAlign.right,
                              size: FONTSIZE.TINY,
                              subtext: true,
                              lineHeight: 0.4,
                            ),
                            MyText(
                              StopWatchTimer.getDisplayTime(snapshot.data ?? 0,
                                  milliSecond: false),
                              size: FONTSIZE.DISPLAY,
                              lineHeight: 1,
                            ),
                          ],
                        )),
                StreamBuilder<StopWatchExecute>(
                    initialData: StopWatchExecute.stop,
                    stream: _stopWatchTimer.execute,
                    builder: (context,
                            AsyncSnapshot<StopWatchExecute> snapshot) =>
                        AnimatedSwitcher(
                            duration: kStandardAnimationDuration,
                            child: snapshot.data == StopWatchExecute.start
                                ? CupertinoButton(
                                    onPressed: () => _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.stop),
                                    child: Icon(
                                      CupertinoIcons.pause_fill,
                                      size: kNavbarIconSize,
                                    ),
                                  )
                                : CupertinoButton(
                                    onPressed: () => _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.start),
                                    child: Icon(
                                      CupertinoIcons.play_arrow_solid,
                                      size: kNavbarIconSize,
                                    ),
                                  ))),
              ],
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.only(left: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: sortedWorkoutSections
                    .map((wSection) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: _SectionPageButton(
                            workoutSection: wSection,
                            onPressed: () =>
                                _navigateToSectionPage(wSection.sortPosition),
                            activeSectionPageIndex: _activeSectionPageIndex,
                          ),
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: kDockedAudioPlayerHeight),
                    child: PageView(
                      controller: _sectionPageViewController,
                      physics: NeverScrollableScrollPhysics(),
                      children: sortedWorkoutSections
                          .map((wSection) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    DoWorkoutSection(workoutSection: wSection),
                              ))
                          .toList(),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: _DockedAudioPlayer(
                        classAudioUri:
                            sortedWorkoutSections[_activeSectionPageIndex]
                                .classAudioUri,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionPageButton extends StatelessWidget {
  final int activeSectionPageIndex;
  final WorkoutSection workoutSection;
  final void Function() onPressed;
  const _SectionPageButton(
      {Key? key,
      required this.activeSectionPageIndex,
      required this.workoutSection,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final active = activeSectionPageIndex == workoutSection.sortPosition;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: AnimatedOpacity(
          opacity: active ? 1 : 0.7,
          duration: kStandardAnimationDuration,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: context.theme.primary)),
            child: MyText(
              workoutSection.name ??
                  'Section ${workoutSection.sortPosition + 1}',
              weight: FontWeight.bold,
              lineHeight: 1.2,
            ),
          )),
    );
  }
}

class _DockedAudioPlayer extends StatelessWidget {
  final String? classAudioUri;
  const _DockedAudioPlayer({Key? key, this.classAudioUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GrowInOut(
      duration: kStandardAnimationDuration,
      show: Utils.textNotNull(classAudioUri),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Styles.infoBlue.withOpacity(0.1),
        height: kDockedAudioPlayerHeight,
        child: MyText(
          'Spotify style audio player - auto plays in time with workout - only button is a mute button - animated playing icon when playing. If user not doing this section show message "audio will auto play when you are doing this section"',
          maxLines: 3,
          size: FONTSIZE.TINY,
        ),
      ),
    );
  }
}