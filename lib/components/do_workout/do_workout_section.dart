import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_section_fortime.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_workout_section_nav.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class DoWorkoutSection extends StatefulWidget {
  final int sectionIndex;

  /// Pass section index + 1 to navigate to a section, or 0 to navigate to the overview page.
  final void Function(int sectionIndex) navigateToPage;
  const DoWorkoutSection(
      {Key? key, required this.sectionIndex, required this.navigateToPage})
      : super(key: key);

  @override
  _DoWorkoutSectionState createState() => _DoWorkoutSectionState();
}

class _DoWorkoutSectionState extends State<DoWorkoutSection> {
  late DoWorkoutBloc _bloc;

  /// 0 = Moves list. This is always displayed, regardless of workout type.
  /// 1 = Timer / stopwatch page. Always displays but for different uses.
  /// AMRAP = countdown to end. ForTime = large counting up clock. Free Session = countdown timer.
  /// HIITCircuit / EMOM = Current set countdown. Tabata = 20s then 10s.
  /// 2 = Video - if present.
  int _activePageIndex = 0;

  bool _muteAudio = false;

  void _checkForComplete() {
    if (_bloc.getControllerForSection(widget.sectionIndex).sectionComplete) {
      /// TODO: handle autoplay of the next section when autoplay is enabled.
      /// And check if there is a 'next section' to go to.
      /// If all sections are complete then could nav back to overview automatically.

      showCupertinoModalPopup(
          context: context,
          useRootNavigator: false,
          barrierDismissible: false,
          builder: (context) {
            return Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CupertinoActionSheet(
                    title: MyHeaderText('SECTION COMPLETE',
                        textAlign: TextAlign.center),
                    message: Column(
                      children: [
                        MyText('Great Work!'),
                        SizedBox(height: 16),
                        PrimaryButton(
                          onPressed: () {
                            context.pop();

                            /// TODO: Go to next section.
                          },
                          suffixIconData: CupertinoIcons.arrow_right,
                          text: 'Next Section',
                        ),
                        SizedBox(height: 8),
                        PrimaryButton(
                          onPressed: () {
                            context.pop();
                            widget.navigateToPage(0);
                          },
                          prefixIconData: CupertinoIcons.arrow_left,
                          text: 'To Overview',
                        ),
                      ],
                    ),
                  ),
                ));
          });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<DoWorkoutBloc>();

    /// Listener for section complete.
    /// Pushes a dialog with some options.
    _bloc.addListener(_checkForComplete);
  }

  void _goToPage(int index) {
    setState(() => _activePageIndex = index);
  }

  void _handleExitRequest() {
    context.showActionSheetMenu(title: 'Leave Section?', actions: [
      CupertinoActionSheetAction(
          child: MyText('Keep progress and leave'),
          onPressed: () {
            context.pop(); // Dialog.
            widget.navigateToPage(0); // To overview.
          }),
      CupertinoActionSheetAction(
          child: MyText('Clear progress and leave'),
          onPressed: () {
            context.pop(); // Dialog.
            context.read<DoWorkoutBloc>().resetSection(widget.sectionIndex);
            widget.navigateToPage(0); // To overview.
          }),
      CupertinoActionSheetAction(
          child: MyText('Reset section'),
          onPressed: () {
            context.pop(); // Dialog.
            context.read<DoWorkoutBloc>().resetSection(widget.sectionIndex);
          }),
    ]);
  }

  void _toggleMuteAudio() {
    /// get the audio player and mute / unmute it.
    final player = context
        .read<DoWorkoutBloc>()
        .getAudioPlayerForSection(widget.sectionIndex);

    if (player != null) {
      final isMuted = player.volume == 0.0;
      player.setVolume(isMuted ? 1.0 : 0.0);
      setState(() => _muteAudio = !_muteAudio);
    }
  }

  /// Build the set of pages and components for the different workout section sub types.
  Widget _buildSectionContent(
    WorkoutSection workoutSection,
    WorkoutSectionProgressState progressState,
  ) {
    switch (workoutSection.workoutSectionType.name) {
      case kTabataName:
      case kHIITCircuitName:
      case kEMOMName:
      // return DoWorkoutSectionTimed(
      //   progressState: progressState,
      //   workoutSection: workoutSection,
      //   activePageIndex: _activePageIndex,
      // );
      case kAMRAPName:
        return MyText('AMRAP section');
      // return DoWorkoutSectionAMRAP(
      //   pageController: _pageController,
      //   progressState: progressState,
      //   workoutSection: workoutSection,
      //   activePageIndex: _activePageIndex,
      // );
      case kForTimeName:
        return DoWorkoutSectionForTime(
          progressState: progressState,
          workoutSection: workoutSection,
          activePageIndex: _activePageIndex,
        );
      case kFreeSessionName:
        return MyText('Free Session section');
      // return DoWorkoutSectionFreeSession(
      //   pageController: _pageController,
      //   workoutSection: workoutSection,
      //   activePageIndex: _activePageIndex,
      // );

      default:
        throw Exception(
            'No DoSectionPages builder defined for section type: ${workoutSection.workoutSectionType.name}');
    }
  }

  @override
  void dispose() {
    _bloc.removeListener(_checkForComplete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutSection = context.select<DoWorkoutBloc, WorkoutSection>(
        (b) => b.activeWorkout.workoutSections[widget.sectionIndex]);

    final initialState =
        context.select<DoWorkoutBloc, WorkoutSectionProgressState>(
            (b) => b.getProgressStateForSection(widget.sectionIndex));

    final audioController = context.select<DoWorkoutBloc, AudioPlayer?>(
        (b) => b.getAudioPlayerForSection(widget.sectionIndex));

    final isRunning = context.select<DoWorkoutBloc, bool>(
        (b) => b.getStopWatchTimerForSection(widget.sectionIndex).isRunning);

    return StreamBuilder<WorkoutSectionProgressState>(
        initialData: initialState,
        stream: context
            .read<DoWorkoutBloc>()
            .getProgressStreamForSection(widget.sectionIndex),
        builder: (context, snapshot) {
          final state = snapshot.data!;
          return Stack(
            children: [
              _buildSectionContent(workoutSection, state),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedSwitcher(
                        duration: kStandardAnimationDuration,
                        child: isRunning
                            ? NavItem(
                                activeIconData: CupertinoIcons.pause_fill,
                                inactiveIconData: CupertinoIcons.pause_fill,
                                isActive: true,
                                onTap: () => context
                                    .read<DoWorkoutBloc>()
                                    .pauseSection(widget.sectionIndex))
                            : NavItem(
                                activeIconData: CupertinoIcons.arrow_left,
                                inactiveIconData: CupertinoIcons.arrow_left,
                                isActive: true,
                                onTap: _handleExitRequest),
                      ),
                      DoWorkoutSectionNav(
                        activePageIndex: _activePageIndex,
                        goToPage: _goToPage,
                        showVideoTab:
                            Utils.textNotNull(workoutSection.classVideoUri),
                        showAudioTab: audioController != null,
                        muteAudio: _muteAudio,
                        toggleMuteAudio: _toggleMuteAudio,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
