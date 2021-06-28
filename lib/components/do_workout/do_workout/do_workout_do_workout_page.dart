import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_section.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/docked_audio_player.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/workout_section_timer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DoWorkoutDoWorkoutPage extends StatefulWidget {
  final Workout workout;
  const DoWorkoutDoWorkoutPage({Key? key, required this.workout})
      : super(key: key);

  @override
  _DoWorkoutDoWorkoutPageState createState() => _DoWorkoutDoWorkoutPageState();
}

class _DoWorkoutDoWorkoutPageState extends State<DoWorkoutDoWorkoutPage> {
  final kNavbarIconSize = 34.0;

  int _activeSectionPageIndex = 0;
  final _sectionTimerPageController = PageController();
  final _sectionPageViewController = PageController();

  void _navigateToSectionPage(int index) {
    /// Changing section page pauses the timer for the section that you were previously on + alerts users.
    context
        .read<DoWorkoutBloc>()
        .pauseStopWatchTimerForSection(_activeSectionPageIndex);

    _sectionPageViewController.toPage(index);
    _sectionTimerPageController.toPage(index);
    setState(() => _activeSectionPageIndex = index);
  }

  void _handleResetWorkout() {
    context.showConfirmDialog(
      title: 'Reset the whole workout?',
      content: MyText(
        'The work you have done will not be saved. OK?',
        textAlign: TextAlign.center,
        maxLines: 3,
      ),
      onConfirm: () => context.read<DoWorkoutBloc>().resetWorkout(),
    );
  }

  void _handleExitRequest() {
    context.read<DoWorkoutBloc>().pauseWorkout();

    context.showDialog(
        title: 'Leave the Workout?',
        barrierDismissible: true,
        actions: [
          CupertinoDialogAction(
              child: MyText('Leave without logging'),
              onPressed: () {
                context.pop();
                context.popRoute();
              }),
          CupertinoDialogAction(
              child: MyText('Log progress, then Leave'),
              onPressed: () {
                context.pop();
                print('go to log');
              }),
          CupertinoDialogAction(
              child: MyText('Restart the workout'),
              onPressed: () {
                context.pop();
                _handleResetWorkout();
              }),
          CupertinoDialogAction(
            child: MyText('Cancel'),
            onPressed: context.pop,
          ),
        ]);
  }

  @override
  void dispose() {
    _sectionTimerPageController.dispose();
    _sectionPageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutSections = widget.workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition);

    final classAudioUri =
        sortedWorkoutSections[_activeSectionPageIndex].classAudioUri;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 64,
                  child: PageView(
                    controller: _sectionTimerPageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: sortedWorkoutSections
                        .map((wSection) =>
                            DoWorkoutSectionTimer(workoutSection: wSection))
                        .toList(),
                  ),
                ),
                Container(
                  height: 48,
                  padding: const EdgeInsets.only(left: 8),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: sortedWorkoutSections
                        .map((wSection) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: _SectionPageButton(
                                workoutSection: wSection,
                                onPressed: () => _navigateToSectionPage(
                                    wSection.sortPosition),
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
                        padding: EdgeInsets.only(
                            bottom: Utils.textNotNull(classAudioUri)
                                ? kDockedAudioPlayerHeight
                                : 0),
                        child: PageView(
                          controller: _sectionPageViewController,
                          physics: NeverScrollableScrollPhysics(),
                          children: sortedWorkoutSections
                              .map((wSection) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DoWorkoutSection(
                                        workoutSection: wSection),
                                  ))
                              .toList(),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: GrowInOut(
                            show: Utils.textNotNull(classAudioUri),
                            duration: kStandardAnimationDuration,
                            child: DockedAudioPlayer(
                              classAudioUri: classAudioUri,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: CupertinoButton(
                onPressed: _handleExitRequest,
                child:
                    Icon(CupertinoIcons.clear_circled, size: kNavbarIconSize),
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
    final completed = context.select<DoWorkoutBloc, bool>(
        (b) => b.completedSections[workoutSection.sortPosition] != null);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: AnimatedOpacity(
          opacity: active ? 1 : 0.5,
          duration: kStandardAnimationDuration,
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: completed
                            ? Styles.peachRed
                            : context.theme.primary)),
                child: MyText(
                    workoutSection.name ??
                        'Section ${workoutSection.sortPosition + 1}',
                    weight: FontWeight.bold,
                    lineHeight: 1.2,
                    color: completed ? Styles.peachRed : context.theme.primary),
              ),
              if (completed)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: FadeIn(
                      child: Icon(
                    CupertinoIcons.checkmark_alt,
                    size: 14,
                    color: Styles.peachRed,
                  )),
                )
            ],
          )),
    );
  }
}
