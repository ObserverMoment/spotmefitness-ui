import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_finder/workout_finder_workout_card.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

class YourFilteredWorkoutsList extends StatelessWidget {
  final List<Workout> workouts;
  final void Function(Workout workout)? selectWorkout;
  final bool loading;
  final ScrollController? listPositionScrollController;
  YourFilteredWorkoutsList(
      {required this.workouts,
      this.selectWorkout,
      this.listPositionScrollController,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: LoadingCircle())
        : workouts.isEmpty
            ? FadeIn(child: Center(child: MyText('No results...')))
            : ImplicitlyAnimatedList<Workout>(
                controller: listPositionScrollController,
                // Bottom padding to push list up above floating filters panel.
                padding: const EdgeInsets.only(bottom: 138),
                items: workouts
                    .sortedBy<DateTime>((w) => w.createdAt)
                    .reversed
                    .toList(),
                itemBuilder: (context, animation, Workout workout, i) =>
                    SizeFadeTransition(
                      sizeFraction: 0.7,
                      curve: Curves.easeInOut,
                      animation: animation,
                      child: WorkoutFinderWorkoutCard(
                          workout: workout, selectWorkout: selectWorkout),
                    ),
                removeItemBuilder: (context, animation, Workout oldWorkout) {
                  return FadeTransition(
                    opacity: animation,
                    child: WorkoutFinderWorkoutCard(
                        workout: oldWorkout, selectWorkout: selectWorkout),
                  );
                },
                areItemsTheSame: (a, b) => a == b);
  }
}
