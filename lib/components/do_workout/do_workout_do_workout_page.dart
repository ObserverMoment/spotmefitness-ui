import 'dart:ui';

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

  void _navigateToSectionPage(int index) {
    print('go to section index');

    /// + 1 because 0 is the overview page. Sections start at 1.
    setState(() => _activePageIndex = index + 1);
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
        useRootNavigator: true,
        title: 'Leave the Workout?',
        barrierDismissible: true,
        actions: [
          CupertinoDialogAction(
              child: MyText('Leave without logging'),
              onPressed: () {
                context.pop(rootNavigator: true); // Dialog.
                context.popRoute(); // Do workout.
              }),
          CupertinoDialogAction(
              child: MyText('Log progress, then Leave'),
              onPressed: () {
                context.pop(rootNavigator: true); // Dialog.
                context.read<DoWorkoutBloc>().generatePartialLog();
              }),
          CupertinoDialogAction(
              child: MyText('Restart the workout'),
              onPressed: () {
                context.pop(rootNavigator: true); // Dialog.
                _handleResetWorkout();
              }),
          CupertinoDialogAction(
              child: MyText('Cancel'),
              onPressed: () => context.pop(rootNavigator: true) // Dialog.,
              ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final numWorkoutSections = context
        .select<DoWorkoutBloc, int>((b) => b.sortedWorkoutSections.length);

    return IndexedStack(
      index: _activePageIndex,
      children: [
        DoWorkoutOverview(
            handleExitRequest: _handleExitRequest,
            navigateToSectionPage: _navigateToSectionPage),
        ...List.generate(
            numWorkoutSections,
            (i) => DoWorkoutSection(
                  sectionIndex: i,
                ))
      ],
    );
  }
}
