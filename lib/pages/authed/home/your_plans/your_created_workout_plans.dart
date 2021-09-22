import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/pages/authed/home/your_plans/your_plans.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

class YourCreatedWorkoutPlans extends StatelessWidget {
  final void Function(String workoutPlanId) selectWorkoutPlan;
  const YourCreatedWorkoutPlans({Key? key, required this.selectWorkoutPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkoutPlans$Query, json.JsonSerializable>(
        key: Key(
            'YourCreatedWorkoutPlans - ${UserWorkoutPlansQuery().operationName}'),
        query: UserWorkoutPlansQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: const ShimmerCardList(itemCount: 20),
        builder: (data) {
          final workoutPlans = data.userWorkoutPlans
              .sortedBy<DateTime>((w) => w.createdAt)
              .reversed
              .toList();

          return FilterableCreatedWorkoutPlans(
            allWorkoutPlans: workoutPlans,
            selectWorkoutPlan: selectWorkoutPlan,
          );
        });
  }
}

class FilterableCreatedWorkoutPlans extends StatefulWidget {
  final void Function(String workoutPlanId) selectWorkoutPlan;
  final List<WorkoutPlan> allWorkoutPlans;
  const FilterableCreatedWorkoutPlans(
      {Key? key,
      required this.selectWorkoutPlan,
      required this.allWorkoutPlans})
      : super(key: key);

  @override
  _FilterableCreatedWorkoutPlansState createState() =>
      _FilterableCreatedWorkoutPlansState();
}

class _FilterableCreatedWorkoutPlansState
    extends State<FilterableCreatedWorkoutPlans> {
  WorkoutTag? _workoutTagFilter;

  @override
  Widget build(BuildContext context) {
    final allTags = widget.allWorkoutPlans
        .fold<List<WorkoutTag>>(
            [], (acum, next) => [...acum, ...next.workoutTags])
        .toSet()
        .toList();

    final filteredWorkoutPlans = _workoutTagFilter == null
        ? widget.allWorkoutPlans
        : widget.allWorkoutPlans
            .where((w) => w.workoutTags.contains(_workoutTagFilter));

    final sortedWorkoutPlans = filteredWorkoutPlans
        .sortedBy<DateTime>((w) => w.createdAt)
        .reversed
        .toList();

    return Column(
      children: [
        if (allTags.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.only(left: 4.0, top: 4, bottom: 10, right: 4),
            child: SizedBox(
                height: 30,
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
          child: YourWorkoutPlansList(
            workoutPlans: sortedWorkoutPlans,
            selectWorkoutPlan: widget.selectWorkoutPlan,
          ),
        ),
      ],
    );
  }
}
