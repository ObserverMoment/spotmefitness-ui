import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_overview_page.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_section.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

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

  Future<void> _generateLog() async {
    final loggedWorkout = context.read<DoWorkoutBloc>().generateLog();
    final scheduledWorkout = context.read<DoWorkoutBloc>().scheduledWorkout;

    context.showConfirmDialog(
        title: 'Save Log and Exit?',
        content: MyText(
          'This will save your workout to a log and then end the workout session.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Logging!');

          /// Save log to DB.
          final input = LoggedWorkoutCreatorBloc
              .createLoggedWorkoutInputFromLoggedWorkout(
                  loggedWorkout, scheduledWorkout);

          final variables = CreateLoggedWorkoutArguments(data: input);

          final result = await context.graphQLStore.create(
              mutation: CreateLoggedWorkoutMutation(variables: variables),
              addRefToQueries: [GQLNullVarsKeys.userLoggedWorkoutsQuery]);

          context.pop(); // Loading alert.

          await checkOperationResult(context, result);

          /// If the log is being created from a scheduled workout then we need to add the newly completed workout log to the scheduledWorkout.loggedWorkout in the store.
          if (scheduledWorkout != null && result.data != null) {
            LoggedWorkoutCreatorBloc.updateScheduleWithLoggedWorkout(
                context, scheduledWorkout, result.data!.createLoggedWorkout);
          }

          context.read<DoWorkoutBloc>().markWorkoutCompleteAndLogged();
        });
  }

  void _handleExitRequest() {
    context.showConfirmDialog(
        title: 'Exit Workout',
        content: MyText(
          'Nothing will be saved. OK?',
          textAlign: TextAlign.center,
        ),
        onConfirm: context.popRoute);
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
            navigateToSectionPage: _navigateToPage,
            generateLog: _generateLog),
        ...List.generate(
            numWorkoutSections,
            (i) => DoWorkoutSection(
                  sectionIndex: i,
                  navigateToPage: _navigateToPage,
                  isLastSection: i == numWorkoutSections - 1,
                ))
      ],
    );
  }
}
