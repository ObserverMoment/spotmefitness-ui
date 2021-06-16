import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts/your_workouts.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class YourCreatedWorkouts extends StatelessWidget {
  final void Function(String workoutId) selectWorkout;
  const YourCreatedWorkouts({Key? key, required this.selectWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkouts$Query, json.JsonSerializable>(
        key: Key('YourCreatedWorkouts - ${UserWorkoutsQuery().operationName}'),
        query: UserWorkoutsQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: ShimmerCardList(itemCount: 20),
        builder: (data) {
          final workouts = data.userWorkouts
              .sortedBy<DateTime>((w) => w.createdAt)
              .reversed
              .toList();

          return FilterableCreatedWorkouts(
            allWorkouts: workouts,
            selectWorkout: selectWorkout,
          );
        });
  }
}

class FilterableCreatedWorkouts extends StatefulWidget {
  final void Function(String workoutId) selectWorkout;
  final List<Workout> allWorkouts;
  const FilterableCreatedWorkouts(
      {Key? key, required this.selectWorkout, required this.allWorkouts})
      : super(key: key);

  @override
  _FilterableCreatedWorkoutsState createState() =>
      _FilterableCreatedWorkoutsState();
}

class _FilterableCreatedWorkoutsState extends State<FilterableCreatedWorkouts> {
  WorkoutTag? _workoutTagFilter;

  @override
  Widget build(BuildContext context) {
    final allTags = widget.allWorkouts
        .fold<List<WorkoutTag>>(
            [], (acum, next) => [...acum, ...next.workoutTags])
        .toSet()
        .toList();

    final filteredWorkouts = _workoutTagFilter == null
        ? widget.allWorkouts
        : widget.allWorkouts
            .where((w) => w.workoutTags.contains(_workoutTagFilter));

    final sortedWorkouts = filteredWorkouts
        .sortedBy<DateTime>((w) => w.createdAt)
        .reversed
        .toList();

    return Column(
      children: [
        if (allTags.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, top: 4, bottom: 10, right: 4),
            child: SizedBox(
                height: 35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allTags.length,
                    itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SelectableTag(
                            text: allTags[i].tag,
                            selectedColor: Styles.infoBlue,
                            isSelected: allTags[i] == _workoutTagFilter,
                            onPressed: () => setState(() => _workoutTagFilter =
                                allTags[i] == _workoutTagFilter
                                    ? null
                                    : allTags[i]),
                          ),
                        ))),
          ),
        Expanded(
          child: YourWorkoutsList(
            workouts: sortedWorkouts,
            selectWorkout: widget.selectWorkout,
          ),
        ),
      ],
    );
  }
}
