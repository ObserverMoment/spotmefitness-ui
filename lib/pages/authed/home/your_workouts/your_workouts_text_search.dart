import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts/your_workouts.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/text_search_filters.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Text search (client side only) your created and saved workouts.
class YourWorkoutsTextSearch extends StatefulWidget {
  final void Function(String workoutId) selectWorkout;

  YourWorkoutsTextSearch({required this.selectWorkout});

  @override
  _YourWorkoutsTextSearchState createState() => _YourWorkoutsTextSearchState();
}

class _YourWorkoutsTextSearchState extends State<YourWorkoutsTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void _handleSelectWorkout(String workoutId) {
    widget.selectWorkout(workoutId);
    context.pop();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Nested query observers a good idea? Both have a [storeFirst] fetch policy to avoid pummeling the api with requests.
    return QueryObserver<UserWorkouts$Query, json.JsonSerializable>(
        key: Key(
            'YourWorkoutsTextSearch - ${UserWorkoutsQuery().operationName}'),
        query: UserWorkoutsQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: ShimmerListPage(),
        builder: (createdWorkoutsData) {
          return QueryObserver<UserCollections$Query, json.JsonSerializable>(
              key: Key(
                  'YourWorkoutsTextSearch - ${UserCollectionsQuery().operationName}'),
              query: UserCollectionsQuery(),
              fetchPolicy: QueryFetchPolicy.storeFirst,
              loadingIndicator: ShimmerListPage(),
              builder: (savedWorkoutsData) {
                final collections = savedWorkoutsData.userCollections;

                final allWorkouts = [
                  ...createdWorkoutsData.userWorkouts,
                  ...collections.fold<List<Workout>>(
                      [], (acum, next) => [...acum, ...next.workouts])
                ];

                final List<Workout> filteredWorkouts = _searchString.length < 3
                    ? <Workout>[]
                    : TextSearchFilters.workoutsBySearchString(
                            allWorkouts, _searchString)
                        .sortedBy<String>((workout) => workout.name);

                return MyPageScaffold(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: CupertinoSearchTextField(
                                  placeholder: 'Search your workouts',
                                  focusNode: _focusNode,
                                  onChanged: (value) => setState(() =>
                                      _searchString = value.toLowerCase()),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            NavBarTextButton(context.pop, 'Close'),
                          ],
                        ),
                        Expanded(
                            child: AnimatedSwitcher(
                          duration: kStandardAnimationDuration,
                          child: _searchString.length < 3
                              ? Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: MyText('Type at least 3 characters',
                                      subtext: true),
                                )
                              : YourWorkoutsList(
                                  selectWorkout: _handleSelectWorkout,
                                  workouts: filteredWorkouts,
                                ),
                        )),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
