import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';

class YourWorkoutsPage extends StatelessWidget {
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
                .reversed
                .toList();
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: NavBarTitle('Your Workouts'),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        builder: (context) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                    'Info about this list, the filters, what the icons mean, the different tag types etc'),
                              ],
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
                                    child:
                                        WorkoutCard(workout: workouts[index]),
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
