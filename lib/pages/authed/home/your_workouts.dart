import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/text_search_filters.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class YourWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkouts$Query, json.JsonSerializable>(
      key: Key('YourWorkoutsPage - ${UserWorkoutsQuery().operationName}'),
      query: UserWorkoutsQuery(),
      garbageCollectAfterFetch: true,
      fetchPolicy: QueryFetchPolicy.storeAndNetwork,
      loadingIndicator: CupertinoPageScaffold(
          navigationBar: BasicNavBar(
            heroTag: 'Loading-YourWorkoutsPage',
            middle: NavBarTitle('Your Workouts'),
          ),
          child: ShimmerCardList(itemCount: 20)),
      builder: (data) {
        final workouts = data.userWorkouts
            .sortedBy<DateTime>((w) => w.createdAt)
            .reversed
            .toList();

        return CupertinoPageScaffold(
            navigationBar: BorderlessNavBar(
              middle: NavBarTitle('Your Workouts'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () => context.navigateTo(WorkoutCreatorRoute()),
                  ),
                  InfoPopupButton(
                    infoWidget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(
                        'Info about this list, the filters, what the icons mean, the different tag types etc',
                        maxLines: 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
            child: FilterableWorkoutsList(workouts));
      },
    );
  }
}

class FilterableWorkoutsList extends StatelessWidget {
  final List<Workout> workouts;
  FilterableWorkoutsList(this.workouts);

  void _openWorkoutDetails(BuildContext context, String id) {
    context.navigateTo(WorkoutDetailsRoute(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        workouts.isEmpty
            ? Center(child: MyText('No workouts to display...'))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: workouts.length + 1,
                  itemBuilder: (c, i) {
                    if (i == workouts.length) {
                      return SizedBox(height: 58);
                    } else {
                      return GestureDetector(
                        onTap: () =>
                            _openWorkoutDetails(context, workouts[i].id),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4.0),
                          child: WorkoutCard(workouts[i]),
                        ),
                      );
                    }
                  },
                ),
              ),
        Positioned(
            bottom: kBottomNavBarHeight + 10,
            child: SortFilterSearchFloatingButton(
              onFilterPress: () => print('TODO - implement workout filters'),
              onSortPress: () => print('TODO - implement workout sort'),
              onSearchPress: () => context.push(
                  fullscreenDialog: true,
                  rootNavigator: true,
                  child: YourWorkoutsTextSearch(
                      allWorkouts: workouts,
                      selectWorkout: (workoutId) =>
                          _openWorkoutDetails(context, workoutId))),
            ))
      ],
    );
  }
}

class YourWorkoutsTextSearch extends StatefulWidget {
  final List<Workout> allWorkouts;
  final void Function(String workoutId) selectWorkout;

  YourWorkoutsTextSearch(
      {required this.allWorkouts, required this.selectWorkout});

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
    final workouts = TextSearchFilters.workoutsBySearchString(
            widget.allWorkouts, _searchString)
        .sortedBy<String>((workout) => workout.name);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: CupertinoSearchTextField(
                        focusNode: _focusNode,
                        onChanged: (value) =>
                            setState(() => _searchString = value.toLowerCase()),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  NavBarCloseButton(context.pop),
                ],
              ),
            ),
            Expanded(
              child: FadeIn(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: workouts.length,
                    itemBuilder: (c, i) => GestureDetector(
                        onTap: () => _handleSelectWorkout(workouts[i].id),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4.0),
                          child: WorkoutCard(workouts[i]),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
