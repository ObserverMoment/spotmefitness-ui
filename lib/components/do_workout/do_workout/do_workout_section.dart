import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_bottom_navbar.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_moves_list.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_progress_summary.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/section_complete_modal.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/section_components/start_section_modal.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class DoWorkoutSection extends StatefulWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSection({Key? key, required this.workoutSection})
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _goToPage(int index) {
    _pageController.toPage(index);
    setState(() => _activePageIndex = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

    final showAudioTab = Utils.textNotNull(widget.workoutSection.classAudioUri);
    final showVideoTab = Utils.textNotNull(widget.workoutSection.classVideoUri);

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
                controller: _pageController,
                onPageChanged: (i) => setState(() => _activePageIndex = i),
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
        Align(
            alignment: Alignment.bottomCenter,
            child: DoWorkoutBottomNavBar(
              activePageIndex: _activePageIndex,
              goToPage: _goToPage,
              showAudioTab: showAudioTab,
              showingAudio: false,
              activateAudio: () => print('audio'),
              showVideoTab: showVideoTab,
              showingVideo: false,
              activateVideo: () => print('video'),
            )),
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
