import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class YourWorkoutsPage extends StatefulWidget {
  @override
  _YourWorkoutsPageState createState() => _YourWorkoutsPageState();
}

class _YourWorkoutsPageState extends State<YourWorkoutsPage> {
  String? _searchString;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: UserWorkoutsQuery().document,
          fetchPolicy: FetchPolicy.cacheFirst
          // These are user created workouts
          ),
      builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
          result: result,
          builder: () {
            final workouts = UserWorkouts$Query.fromJson(result.data ?? {})
                .workoutSummary
                .where((workoutSummary) => Utils.textNotNull(_searchString)
                    ? workoutSummary.name
                        .toLowerCase()
                        .contains(_searchString!.toLowerCase())
                    : true)
                .toList()
                .reversed
                .toList();
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: NavBarTitle('Your Workouts'),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.push(
                        fullscreenDialog: true,
                        child: CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                            middle: NavBarTitle('Info'),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                  'Info about this list, the filters, what the icons mean, the different tag types etc'),
                            ],
                          ),
                        )),
                    child: Icon(
                      CupertinoIcons.info_circle,
                      size: 25,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SortByButton(
                              onPressed: () => {},
                            ),
                            FilterButton(
                              onPressed: () => {},
                              activeFilters: 3,
                            ),
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CupertinoSearchTextField(
                                padding: const EdgeInsets.all(5.0),
                                onChanged: (searchString) => setState(
                                    () => _searchString = searchString),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: workouts.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => context.router.root.push(
                                      WorkoutDetailsRoute(
                                          id: workouts[index].id)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 3.0),
                                    child: WorkoutCard(workouts[index]),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
