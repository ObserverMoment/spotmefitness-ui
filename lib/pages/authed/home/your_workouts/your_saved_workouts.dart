import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/pages/authed/home/your_workouts/your_workouts.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

class YourSavedWorkouts extends StatelessWidget {
  final void Function(String workoutId) selectWorkout;
  const YourSavedWorkouts({Key? key, required this.selectWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserCollections$Query, json.JsonSerializable>(
        key: Key('YourSavedWorkouts - ${UserCollectionsQuery().operationName}'),
        query: UserCollectionsQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: const ShimmerCardList(itemCount: 20),
        builder: (data) {
          final collections = data.userCollections;

          return _FilterableSavedWorkouts(
            selectWorkout: selectWorkout,
            allCollections: collections,
          );
        });
  }
}

class _FilterableSavedWorkouts extends StatefulWidget {
  final void Function(String workoutId) selectWorkout;
  final List<Collection> allCollections;
  const _FilterableSavedWorkouts(
      {Key? key, required this.selectWorkout, required this.allCollections})
      : super(key: key);

  @override
  __FilterableSavedWorkoutsState createState() =>
      __FilterableSavedWorkoutsState();
}

class __FilterableSavedWorkoutsState extends State<_FilterableSavedWorkouts> {
  Collection? _selectedCollection;

  @override
  Widget build(BuildContext context) {
    final selectedCollections = _selectedCollection == null
        ? widget.allCollections
        : [
            widget.allCollections
                .firstWhere((c) => c.id == _selectedCollection!.id)
          ];

    final workouts = selectedCollections
        .fold<List<Workout>>([], (acum, next) => [...acum, ...next.workouts])
        .sortedBy<DateTime>((w) => w.createdAt)
        .reversed
        .toList();

    final collectionsWithWorkouts =
        widget.allCollections.where((c) => c.workouts.isNotEmpty).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: SizedBox(
              height: 35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: collectionsWithWorkouts.length,
                  itemBuilder: (c, i) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: SelectableTag(
                          text: collectionsWithWorkouts[i].name,
                          selectedColor: Styles.infoBlue,
                          isSelected:
                              collectionsWithWorkouts[i] == _selectedCollection,
                          onPressed: () => setState(() => _selectedCollection =
                              collectionsWithWorkouts[i] == _selectedCollection
                                  ? null
                                  : collectionsWithWorkouts[i]),
                        ),
                      ))),
        ),
        Expanded(
          child: YourWorkoutsList(
            workouts: workouts,
            selectWorkout: widget.selectWorkout,
          ),
        ),
      ],
    );
  }
}
