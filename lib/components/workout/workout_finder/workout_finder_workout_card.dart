import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';

/// Wrapper around the [WorkoutCard] widget which adds some user interactivity.
class WorkoutFinderWorkoutCard extends StatelessWidget {
  final Workout workout;
  final void Function(Workout workout)? selectWorkout;
  const WorkoutFinderWorkoutCard(
      {Key? key, required this.workout, this.selectWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: ContextMenu(
        key: Key('WorkoutFinderWorkoutCard ${workout.id}'),
        child: WorkoutCard(workout),
        menuChild: WorkoutCard(
          workout,
        ),
        actions: [
          if (selectWorkout != null)
            ContextMenuAction(
                text: 'Select',
                iconData: CupertinoIcons.add,
                onTap: () => selectWorkout!(workout)),
          ContextMenuAction(
              text: 'View',
              iconData: CupertinoIcons.eye,
              onTap: () =>
                  context.navigateTo(WorkoutDetailsRoute(id: workout.id))),
        ],
      ),
    );
  }
}
