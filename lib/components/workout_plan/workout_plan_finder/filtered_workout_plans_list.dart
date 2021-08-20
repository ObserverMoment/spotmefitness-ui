import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_finder/finder_workout_plan_card.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class YourFilteredWorkoutPlansList extends StatelessWidget {
  final void Function(WorkoutPlan workoutPlan)? selectWorkoutPlan;
  final List<WorkoutPlan> workoutPlans;
  final bool loading;
  final ScrollController? listPositionScrollController;
  YourFilteredWorkoutPlansList(
      {required this.workoutPlans,
      this.listPositionScrollController,
      this.loading = false,
      this.selectWorkoutPlan});

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: LoadingCircle())
        : workoutPlans.isEmpty
            ? FadeIn(child: Center(child: MyText('No results...')))
            : ImplicitlyAnimatedList<WorkoutPlan>(
                controller: listPositionScrollController,
                // Bottom padding to push list up above floating filters panel.
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 4, bottom: 138),
                items: workoutPlans,
                itemBuilder: (context, animation, WorkoutPlan workoutPlan, i) =>
                    SizeFadeTransition(
                      sizeFraction: 0.7,
                      curve: Curves.easeInOut,
                      animation: animation,
                      child: WorkoutFinderWorkoutPlanCard(
                          selectWorkoutPlan: selectWorkoutPlan,
                          workoutPlan: workoutPlan),
                    ),
                removeItemBuilder:
                    (context, animation, WorkoutPlan oldWorkoutPlan) {
                  return FadeTransition(
                    opacity: animation,
                    child: WorkoutFinderWorkoutPlanCard(
                        selectWorkoutPlan: selectWorkoutPlan,
                        workoutPlan: oldWorkoutPlan),
                  );
                },
                areItemsTheSame: (a, b) => a == b);
  }
}
