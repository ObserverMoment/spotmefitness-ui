import 'package:flutter/cupertino.dart';

import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_section_type_pages/do_section_amrap.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_section_type_pages/do_section_fortime.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_section_type_pages/do_section_free_session.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_section_type_pages/do_section_timed.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/do_workout_bottom_navbar.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/section_components/section_complete_modal.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section/section_components/start_section_modal.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DoWorkoutSection extends StatefulWidget {
  final int sectionIndex;
  const DoWorkoutSection({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  _DoWorkoutSectionState createState() => _DoWorkoutSectionState();
}

class _DoWorkoutSectionState extends State<DoWorkoutSection> {
  late PageController _pageController;

  /// 0 = Moves list. This is always displayed, regardless of workout type.
  /// 1 = Progress summary. Displays when doing AMRAPS, ForTime and Last Standing.
  /// i.e. Competitive workouts only.
  /// 2 = Timer / stopwatch page. Always displays but for different uses.
  /// AMRAP = countdown to end. ForTime = large counting up clock. Free Session = countdown timer.
  /// Last Standing = Period countdown clock + period countdown clock if has timecap.
  /// HIITCircuit / EMOM = Current set countdown. Tabata = 20s then 10s.
  int _activePageIndex = 0;

  bool _muteAudio = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _goToPage(int index) {
    _pageController.toPage(index);
    setState(() => _activePageIndex = index);
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
  Widget _buildDoSectionPages(WorkoutSection workoutSection,
      WorkoutSectionProgressState progressState) {
    switch (workoutSection.workoutSectionType.name) {
      case kTabataName:
      case kHIITCircuitName:
      case kEMOMName:
        return DoWorkoutSectionTimed(
          pageController: _pageController,
          progressState: progressState,
          workoutSection: workoutSection,
          activePageIndex: _activePageIndex,
        );
      case kAMRAPName:
        return DoWorkoutSectionAMRAP(
          pageController: _pageController,
          progressState: progressState,
          workoutSection: workoutSection,
          activePageIndex: _activePageIndex,
        );
      case kForTimeName:
        return DoWorkoutSectionForTime(
          pageController: _pageController,
          progressState: progressState,
          workoutSection: workoutSection,
          activePageIndex: _activePageIndex,
        );
      case kFreeSessionName:
        return DoWorkoutSectionFreeSession(
          pageController: _pageController,
          workoutSection: workoutSection,
          activePageIndex: _activePageIndex,
        );

      default:
        throw Exception(
            'No DoSectionPages builder defined for section type: ${workoutSection.workoutSectionType.name}');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutSection = context.select<DoWorkoutBloc, WorkoutSection>(
        (b) => b.sortedWorkoutSections[widget.sectionIndex]);

    final loggedWorkoutSection =
        context.select<DoWorkoutBloc, LoggedWorkoutSection?>(
            (b) => b.completedSections[widget.sectionIndex]);

    final sectionHasStarted = context.select<DoWorkoutBloc, bool>(
        (b) => b.startedSections[widget.sectionIndex]);

    final initialState =
        context.select<DoWorkoutBloc, WorkoutSectionProgressState>(
            (b) => b.controllers[widget.sectionIndex].state);

    final showAudioTab = Utils.textNotNull(workoutSection.classAudioUri);

    return StreamBuilder<WorkoutSectionProgressState>(
        initialData: initialState,
        stream: context
            .read<DoWorkoutBloc>()
            .controllers[widget.sectionIndex]
            .progressStream,
        builder: (context, snapshot) {
          final progressState = snapshot.data!;
          return MyPageScaffold(
            child: SafeArea(
              child: Stack(
                children: [
                  SizedBox(height: 8),
                  _buildDoSectionPages(workoutSection, progressState),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: DoWorkoutBottomNavBar(
                        activePageIndex: _activePageIndex,
                        goToPage: _goToPage,
                        showAudioTab: showAudioTab,
                        muteAudio: _muteAudio,
                        toggleMuteAudio: _toggleMuteAudio,
                      )),
                  if (!sectionHasStarted)
                    Center(
                        child: SizeFadeIn(
                            child: StartSectionModal(
                                workoutSection: workoutSection))),
                  if (loggedWorkoutSection != null)
                    Center(
                        child: SizeFadeIn(
                            child: SectionCompleteModal(
                      loggedWorkoutSection: loggedWorkoutSection,
                    ))),
                ],
              ),
            ),
          );
        });
  }
}
