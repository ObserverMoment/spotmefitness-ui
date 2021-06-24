import 'dart:ui';

import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_progress_summary.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/pages/authed/details_pages/logged_workout_details_page.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutSectionTimer extends StatelessWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSectionTimer({Key? key, required this.workoutSection})
      : super(key: key);

  final kNavbarIconSize = 38.0;

  @override
  Widget build(BuildContext context) {
    final getStopWatchTimerForSection =
        context.read<DoWorkoutBloc>().getStopWatchTimerForSection;

    final sectionIsComplete =
        context.select<DoWorkoutBloc, LoggedWorkoutSection?>(
            (b) => b.completedSections[workoutSection.sortPosition]);

    final sectionHasStarted = context.select<DoWorkoutBloc, bool>(
        (b) => b.startedSections[workoutSection.sortPosition]);

    return Stack(
      alignment: Alignment.center,
      children: [
        StreamBuilder<int>(
            initialData: 0,
            stream: getStopWatchTimerForSection(workoutSection.sortPosition)
                .rawTime,
            builder: (context, AsyncSnapshot<int> snapshot) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      'Elapsed',
                      textAlign: TextAlign.right,
                      size: FONTSIZE.TINY,
                      subtext: true,
                      lineHeight: 0.4,
                    ),
                    Text(
                        StopWatchTimer.getDisplayTime(snapshot.data ?? 0,
                            milliSecond: false),
                        style: GoogleFonts.courierPrime(
                            letterSpacing: -3,
                            textStyle: TextStyle(
                              color: context.theme.primary,
                              fontSize: 44,
                            ))),
                  ],
                )),
        Positioned(
          right: 0,
          child: AnimatedSwitcher(
            duration: kStandardAnimationDuration,
            child: sectionIsComplete != null
                ? SizeFadeIn(
                    child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      size: kNavbarIconSize,
                      color: Styles.peachRed,
                    ),
                  ))
                : StreamBuilder<StopWatchExecute>(
                    initialData: StopWatchExecute.stop,
                    stream:
                        getStopWatchTimerForSection(workoutSection.sortPosition)
                            .execute,
                    builder: (context,
                            AsyncSnapshot<StopWatchExecute> snapshot) =>
                        AnimatedSwitcher(
                            duration: kStandardAnimationDuration,
                            child: sectionHasStarted
                                ? snapshot.data == StopWatchExecute.start
                                    ? CupertinoButton(
                                        onPressed: () =>
                                            getStopWatchTimerForSection(
                                                    workoutSection.sortPosition)
                                                .onExecute
                                                .add(StopWatchExecute.stop),
                                        child: Icon(
                                          CupertinoIcons.pause_fill,
                                          size: kNavbarIconSize,
                                        ),
                                      )
                                    : CupertinoButton(
                                        onPressed: () =>
                                            getStopWatchTimerForSection(
                                                    workoutSection.sortPosition)
                                                .onExecute
                                                .add(StopWatchExecute.start),
                                        child: Icon(
                                          CupertinoIcons.play_arrow_solid,
                                          size: kNavbarIconSize,
                                        ),
                                      )
                                : Container())),
          ),
        )
      ],
    );
  }
}

class DoWorkoutSection extends StatefulWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSection({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  _DoWorkoutSectionState createState() => _DoWorkoutSectionState();
}

class _DoWorkoutSectionState extends State<DoWorkoutSection> {
  int _activePageViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<DoWorkoutBloc, LoggedWorkoutSection?>(
            (b) => b.completedSections[widget.workoutSection.sortPosition]);

    final sectionHasStarted = context.select<DoWorkoutBloc, bool>(
        (b) => b.startedSections[widget.workoutSection.sortPosition]);

    final initialState =
        context.select<DoWorkoutBloc, WorkoutSectionProgressState>(
            (b) => b.controllers[widget.workoutSection.sortPosition].state);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        StreamBuilder<WorkoutSectionProgressState>(
            initialData: initialState,
            stream: context
                .read<DoWorkoutBloc>()
                .controllers[widget.workoutSection.sortPosition]
                .progressStream,
            builder: (context, snapshot) {
              final progressState = snapshot.data!;
              return PageView(
                onPageChanged: (i) => setState(() => _activePageViewIndex = i),
                children: [
                  DoWorkoutMovesList(
                      workoutSection: widget.workoutSection,
                      state: progressState),
                  DoWorkoutProgressSummary(
                      workoutSection: widget.workoutSection,
                      state: progressState),
                  MyText('Timer + lap times for sets and sections'),
                ],
              );
            }),
        Positioned(
            bottom: 0,
            child: BasicProgressDots(
                numDots: 3, currentIndex: _activePageViewIndex)),
        if (!sectionHasStarted)
          Center(
              child: SizeFadeIn(
                  child: StartSectionModal(
                      workoutSection: widget.workoutSection))),
        if (loggedWorkoutSection != null)
          Center(
              child: SizeFadeIn(
                  child: SectionCompleteModal(
            loggedWorkoutSection: loggedWorkoutSection,
          )))
      ],
    );
  }
}

class StartSectionModal extends StatelessWidget {
  final WorkoutSection workoutSection;
  const StartSectionModal({Key? key, required this.workoutSection})
      : super(key: key);

  void _startSection(BuildContext context) {
    context.read<DoWorkoutBloc>().startSection(workoutSection.sortPosition);
  }

  @override
  Widget build(BuildContext context) {
    return _SectionModalContainer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: StartWorkoutCountdownButton(
              startSectionAfterCountdown: () => _startSection(context),
              size: 180),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: WorkoutDetailsSection(
              workoutSection,
            ),
          ),
        ),
      ],
    ));
  }
}

class StartWorkoutCountdownButton extends StatefulWidget {
  final double size;
  final void Function() startSectionAfterCountdown;
  const StartWorkoutCountdownButton(
      {Key? key, required this.size, required this.startSectionAfterCountdown})
      : super(key: key);

  @override
  _StartWorkoutCountdownButtonState createState() =>
      _StartWorkoutCountdownButtonState();
}

class _StartWorkoutCountdownButtonState
    extends State<StartWorkoutCountdownButton> {
  bool _startCountdown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.size,
      height: widget.size,
      child: CupertinoButton(
        onPressed: () => setState(() => _startCountdown = !_startCountdown),
        child: AnimatedSwitcher(
          duration: kStandardAnimationDuration,
          child: _startCountdown
              ? TimeCircularCountdown(
                  unit: CountdownUnit.second,
                  countdownTotal: 3,
                  onFinished: widget.startSectionAfterCountdown,
                  countdownCurrentColor: Styles.peachRed,
                  textStyle: GoogleFonts.courierPrime(
                      textStyle: TextStyle(
                    color: context.theme.primary,
                    fontSize: 40,
                  )),
                )
              : SizedBox.expand(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: context.theme.primary.withOpacity(0.6),
                            width: 3),
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                            colors: [Styles.colorTwo, Styles.peachRed])),
                    child: MyText(
                      'START',
                      weight: FontWeight.bold,
                      size: FONTSIZE.HUGE,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class SectionCompleteModal extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  const SectionCompleteModal({Key? key, required this.loggedWorkoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SectionModalContainer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: H1('Nice Work!'),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: LoggedWorkoutSectionSummary(loggedWorkoutSection),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: H1('Reset section button'),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: H1('Go to next section button'),
        ),
      ],
    ));
  }
}

class _SectionModalContainer extends StatelessWidget {
  final Widget child;
  const _SectionModalContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.theme.themeName == ThemeName.dark;
    return LayoutBuilder(
        builder: (context, constraints) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: context.theme.primary
                              .withOpacity(isDark ? 0.1 : 0.05)),
                      boxShadow: [
                        BoxShadow(
                            color: CupertinoColors.black
                                .withOpacity(isDark ? 0.6 : 0.3),
                            blurRadius: 3, // soften the shadow
                            spreadRadius: 1.5, //extend the shadow
                            offset: Offset(
                              0.4, // Move to right horizontally
                              0.4, // Move to bottom Vertically
                            ))
                      ],
                      color: context.theme.background
                          .withOpacity(isDark ? 0.45 : 0.6),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: child,
                    )),
              ),
            ));
  }
}
