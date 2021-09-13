import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class WorkoutFinderWorkoutPlanCard extends StatelessWidget {
  final void Function(WorkoutPlan workoutPlan)? selectWorkoutPlan;
  final WorkoutPlan workoutPlan;
  const WorkoutFinderWorkoutPlanCard(
      {Key? key, required this.workoutPlan, this.selectWorkoutPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ContextMenu(
        key: Key('WorkoutFinderWorkoutPlanCard ${workoutPlan.id}'),
        child: WorkoutPlanCard(workoutPlan),
        menuChild: WorkoutPlanCard(
          workoutPlan,
        ),
        actions: [
          if (selectWorkoutPlan != null)
            ContextMenuAction(
                text: 'Select',
                iconData: CupertinoIcons.add,
                onTap: () => selectWorkoutPlan!(workoutPlan)),
          ContextMenuAction(
              text: 'View',
              iconData: CupertinoIcons.eye,
              onTap: () => context
                  .navigateTo(WorkoutPlanDetailsRoute(id: workoutPlan.id))),
        ],
      ),
    );
  }
}
