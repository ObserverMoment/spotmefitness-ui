import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_plans.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class YourSavedPlans extends StatelessWidget {
  final void Function(String workoutPlanId) selectWorkoutPlan;
  const YourSavedPlans({Key? key, required this.selectWorkoutPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserCollections$Query, json.JsonSerializable>(
        key: Key('YourSavedPlans - ${UserCollectionsQuery().operationName}'),
        query: UserCollectionsQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: ShimmerCardList(itemCount: 20),
        builder: (data) {
          final collections = data.userCollections;

          return _FilterableSavedPlans(
            selectWorkoutPlan: selectWorkoutPlan,
            allCollections: collections,
          );
        });
  }
}

class _FilterableSavedPlans extends StatefulWidget {
  final void Function(String workoutPlanId) selectWorkoutPlan;
  final List<Collection> allCollections;
  const _FilterableSavedPlans(
      {Key? key, required this.selectWorkoutPlan, required this.allCollections})
      : super(key: key);

  @override
  __FilterableSavedPlansState createState() => __FilterableSavedPlansState();
}

class __FilterableSavedPlansState extends State<_FilterableSavedPlans> {
  Collection? _selectedCollection;

  @override
  Widget build(BuildContext context) {
    final selectedCollections = _selectedCollection == null
        ? widget.allCollections
        : [
            widget.allCollections
                .firstWhere((c) => c.id == _selectedCollection!.id)
          ];

    final workoutPlans = selectedCollections
        .fold<List<WorkoutPlan>>(
            [], (acum, next) => [...acum, ...next.workoutPlans])
        .sortedBy<DateTime>((w) => w.createdAt)
        .reversed
        .toList();

    final collectionsWithPlans =
        widget.allCollections.where((c) => c.workoutPlans.isNotEmpty).toList();

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 4.0, top: 4, bottom: 10, right: 4),
          child: SizedBox(
              height: 35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: collectionsWithPlans.length,
                  itemBuilder: (c, i) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: SelectableTag(
                          text: collectionsWithPlans[i].name,
                          selectedColor: Styles.infoBlue,
                          isSelected:
                              collectionsWithPlans[i] == _selectedCollection,
                          onPressed: () => setState(() => _selectedCollection =
                              collectionsWithPlans[i] == _selectedCollection
                                  ? null
                                  : collectionsWithPlans[i]),
                        ),
                      ))),
        ),
        Expanded(
          child: YourWorkoutPlansList(
            workoutPlans: workoutPlans,
            selectWorkoutPlan: widget.selectWorkoutPlan,
          ),
        ),
      ],
    );
  }
}
