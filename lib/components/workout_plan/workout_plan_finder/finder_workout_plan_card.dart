import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class FinderWorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const FinderWorkoutPlanCard({Key? key, required this.workoutPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ContextMenu(
        key: Key('FinderWorkoutPlanCard ${workoutPlan.id}'),
        child: WorkoutPlanCard(workoutPlan),
        menuChild: WorkoutPlanCard(
          workoutPlan,
          showAccessScope: false,
          showEnrolledAndReviews: false,
        ),
        actions: [
          ContextMenuAction(
              text: 'View',
              iconData: CupertinoIcons.eye,
              onTap: () => context
                  .navigateTo(WorkoutPlanDetailsRoute(id: workoutPlan.id))),
          ContextMenuAction(
              text: 'Save',
              iconData: CupertinoIcons.heart_fill,
              onTap: () => print('save plan flow')),
        ],
      ),
    );
  }
}
