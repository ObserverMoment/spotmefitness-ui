import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/pages/authed/home/your_plans/your_plans.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';
import 'package:sofie_ui/services/text_search_filters.dart';

/// Text search (client side only) your created, joined and saved plans.
class YourPlansTextSearch extends StatefulWidget {
  final void Function(String workoutPlanId) selectWorkoutPlan;

  const YourPlansTextSearch({Key? key, required this.selectWorkoutPlan})
      : super(key: key);

  @override
  _YourPlansTextSearchState createState() => _YourPlansTextSearchState();
}

class _YourPlansTextSearchState extends State<YourPlansTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void _handleSelectWorkoutPlan(String workoutPlanId) {
    widget.selectWorkoutPlan(workoutPlanId);
    context.pop();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Nested query observers a good idea? (x 3 - may need to build a way to combine streams in the query observer widget). All have a [storeFirst] fetch policy to avoid pummeling the api with requests.
    /// Created Workout Plans
    return QueryObserver<UserWorkoutPlans$Query, json.JsonSerializable>(
        key: Key(
            'YourPlansTextSearch - ${UserWorkoutPlansQuery().operationName}'),
        query: UserWorkoutPlansQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: const ShimmerCardList(itemCount: 20),
        builder: (createdPlansData) {
          /// Enrolled Workout Plans
          return QueryObserver<UserWorkoutPlanEnrolments$Query,
                  json.JsonSerializable>(
              key: Key(
                  'YourPlansTextSearch - ${UserWorkoutPlanEnrolmentsQuery().operationName}'),
              query: UserWorkoutPlanEnrolmentsQuery(),
              fetchPolicy: QueryFetchPolicy.storeFirst,
              loadingIndicator: const ShimmerListPage(),
              builder: (enrolmentsData) {
                /// Saved Workout Plans
                return QueryObserver<UserCollections$Query,
                        json.JsonSerializable>(
                    key: Key(
                        'YourPlansTextSearch - ${UserCollectionsQuery().operationName}'),
                    query: UserCollectionsQuery(),
                    fetchPolicy: QueryFetchPolicy.storeFirst,
                    loadingIndicator: const ShimmerCardList(itemCount: 20),
                    builder: (collectionsData) {
                      final createdPlans = createdPlansData.userWorkoutPlans;
                      final enrolments =
                          enrolmentsData.userWorkoutPlanEnrolments;
                      final collections = collectionsData.userCollections;

                      final allPlans = <WorkoutPlan>{
                        ...createdPlans,
                        ...enrolments.map<WorkoutPlan>((e) => e.workoutPlan),
                        ...collections.fold<List<WorkoutPlan>>(
                            [], (acum, next) => [...acum, ...next.workoutPlans])
                      }.toList();

                      final List<WorkoutPlan> filteredWorkoutPlans =
                          _searchString.length < 3
                              ? <WorkoutPlan>[]
                              : TextSearchFilters.workoutPlansBySearchString(
                                      allPlans, _searchString)
                                  .sortedBy<String>(
                                      (workoutPlan) => workoutPlan.name);

                      return CupertinoPageScaffold(
                        child: SafeArea(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3.0),
                                        child: CupertinoSearchTextField(
                                          focusNode: _focusNode,
                                          onChanged: (value) => setState(() =>
                                              _searchString =
                                                  value.toLowerCase()),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    NavBarTextButton(context.pop, 'Close'),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: AnimatedSwitcher(
                                duration: kStandardAnimationDuration,
                                child: _searchString.length < 3
                                    ? const Padding(
                                        padding: EdgeInsets.all(24),
                                        child: MyText(
                                            'Type at least 3 characters',
                                            subtext: true),
                                      )
                                    : YourWorkoutPlansList(
                                        selectWorkoutPlan:
                                            _handleSelectWorkoutPlan,
                                        workoutPlans: filteredWorkoutPlans,
                                      ),
                              )),
                            ],
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
