import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/moves_lists/free_session_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/moves_lists/main_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/timers/amrap_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/timers/fortime_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/timers/interval_timer.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/components/video_overlays/main_video_overlay.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_section_template_layout.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_workout_section_nav.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/timers/stopwatch_and_timer.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class DoWorkoutSection extends StatefulWidget {
  final int sectionIndex;
  // Pass section index + 1 to navigate to a section, or 0 to navigate to the overview page.
  final void Function(int sectionIndex) navigateToPage;
  final bool isLastSection;
  const DoWorkoutSection(
      {Key? key,
      required this.sectionIndex,
      required this.navigateToPage,
      required this.isLastSection})
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

  bool _completeModelOpen = false;

  void _checkForComplete() {
    /// To stop the bloc listener triggering twice which was causing two dialogs to open on top of each other.
    if (!_completeModelOpen) {
      if (_bloc.getControllerForSection(widget.sectionIndex).sectionComplete) {
        if (widget.isLastSection) {
          widget.navigateToPage(0);
        } else {
          /// TODO: handle autoplay of the next section when autoplay is enabled.
          /// And check if there is a 'next section' to go to.
          /// If all sections are complete then could nav back to overview automatically.
          _completeModelOpen = true;
          showCupertinoModalPopup(
              context: context,
              barrierDismissible: false,
              useRootNavigator: false,
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
                                widget.navigateToPage(widget.sectionIndex + 1);
                                _completeModelOpen = false;
                              },
                              suffixIconData: CupertinoIcons.arrow_right,
                              text: 'Next Section',
                            ),
                            SizedBox(height: 8),
                            PrimaryButton(
                              onPressed: () {
                                context.pop();
                                widget.navigateToPage(0);
                                _completeModelOpen = false;
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

  void _handleResetRequest() {
    context.showConfirmDialog(
      title: 'Reset Section?',
      onConfirm: () {
        context.read<DoWorkoutBloc>().resetSection(widget.sectionIndex);
      },
    );
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

    final hasStarted = context.select<DoWorkoutBloc, bool>((b) =>
        b.getControllerForSection(widget.sectionIndex).sectionHasStarted);

    return StreamBuilder<WorkoutSectionProgressState>(
        initialData: initialState,
        stream: context
            .read<DoWorkoutBloc>()
            .getProgressStreamForSection(widget.sectionIndex),
        builder: (context, snapshot) {
          final state = snapshot.data!;
          return Stack(
            children: [
              _DoSectionTemplateSelector(
                workoutSection: workoutSection,
                state: state,
                activePageIndex: _activePageIndex,
              ),
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
                            : Row(
                                children: [
                                  NavItem(
                                      activeIconData: CupertinoIcons.arrow_left,
                                      inactiveIconData:
                                          CupertinoIcons.arrow_left,
                                      isActive: true,
                                      onTap: () => widget.navigateToPage(0)),
                                  if (hasStarted)
                                    NavItem(
                                        activeIconData:
                                            CupertinoIcons.refresh_bold,
                                        inactiveIconData:
                                            CupertinoIcons.refresh_bold,
                                        isActive: true,
                                        onTap: _handleResetRequest),
                                ],
                              ),
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

class _DoSectionTemplateSelector extends StatelessWidget {
  final WorkoutSection workoutSection;
  final WorkoutSectionProgressState state;
  final int activePageIndex;
  const _DoSectionTemplateSelector(
      {Key? key,
      required this.workoutSection,
      required this.state,
      required this.activePageIndex})
      : super(key: key);

  Widget _buildMovesList() {
    switch (workoutSection.workoutSectionType.name) {
      case kAMRAPName:
      case kForTimeName:
        return MainMovesList(workoutSection: workoutSection, state: state);
      case kEMOMName:
      case kTabataName:
      case kHIITCircuitName:
        return MainMovesList(workoutSection: workoutSection, state: state);
      case kFreeSessionName:
        return FreeSessionMovesList(workoutSection: workoutSection);
      default:
        throw Exception(
            'No moves list builder specified for ${workoutSection.workoutSectionType.name}');
    }
  }

  Widget _buildTimer() {
    switch (workoutSection.workoutSectionType.name) {
      case kForTimeName:
        return ForTimeTimer(workoutSection: workoutSection, state: state);
      case kAMRAPName:
        return AMRAPTimer(workoutSection: workoutSection, state: state);
      case kEMOMName:
      case kTabataName:
      case kHIITCircuitName:
        return IntervalTimer(workoutSection: workoutSection, state: state);
      case kFreeSessionName:
        return StopwatchAndTimer();
      default:
        throw Exception(
            'No moves list builder specified for ${workoutSection.workoutSectionType.name}');
    }
  }

  Widget _buildVideoOverlay() {
    switch (workoutSection.workoutSectionType.name) {
      case kAMRAPName:
      case kForTimeName:
      case kEMOMName:
      case kTabataName:
      case kHIITCircuitName:
        return MainVideoOverlay(workoutSection: workoutSection, state: state);
      case kFreeSessionName: // No video overlay required.
        return Container();
      default:
        throw Exception(
            'No moves list builder specified for ${workoutSection.workoutSectionType.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoSectionTemplateLayout(
      movesList: _buildMovesList(),
      timer: _buildTimer(),
      videoOverlay: _buildVideoOverlay(),
      activePageIndex: activePageIndex,
      state: state,
      workoutSection: workoutSection,
    );
  }
}
