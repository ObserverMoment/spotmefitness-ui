import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_overview_page.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

class DoWorkoutDoWorkoutPage extends StatefulWidget {
  const DoWorkoutDoWorkoutPage({
    Key? key,
  }) : super(key: key);

  @override
  _DoWorkoutDoWorkoutPageState createState() => _DoWorkoutDoWorkoutPageState();
}

class _DoWorkoutDoWorkoutPageState extends State<DoWorkoutDoWorkoutPage> {
  /// If == 0 user is viewing the [Overview] page.
  /// Or if > 0 user is viewing / doing the workout section at [workout.workoutSections][_activePageIndex]
  int _activePageIndex = 0;

  void _navigateToPage(int index) {
    setState(() => _activePageIndex = index);
  }

  void _handleExitRequest() {
    context.showActionSheetMenu(title: 'Exit or Reset?', actions: [
      CupertinoActionSheetAction(
          child: MyText('Exit Workout'),
          onPressed: () {
            context.pop(); // Dialog.
            context.popRoute(); // Exit
          }),
      CupertinoActionSheetAction(
          child: MyText('Reset Workout'),
          onPressed: () {
            context.pop(); // Dialog.
            context.read<DoWorkoutBloc>().resetWorkout();
          }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final numWorkoutSections = context.select<DoWorkoutBloc, int>(
        (b) => b.activeWorkout.workoutSections.length);

    return IndexedStack(
      index: _activePageIndex,
      sizing: StackFit.expand,
      children: [
        DoWorkoutOverview(
            handleExitRequest: _handleExitRequest,
            navigateToSectionPage: _navigateToPage),
        ...List.generate(
            numWorkoutSections,
            (i) => DoWorkoutSection(
                  sectionIndex: i,
                  navigateToPage: _navigateToPage,
                ))
      ],
    );
  }
}
