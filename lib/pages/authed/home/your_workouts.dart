import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';

class YourWorkoutsPage extends StatefulWidget {
  @override
  _YourWorkoutsPageState createState() => _YourWorkoutsPageState();
}

class _YourWorkoutsPageState extends State<YourWorkoutsPage> {
  String? _searchString;

  @override
  Widget build(BuildContext context) {
    return QueryResponseBuilder(
      options: QueryOptions(
        document: UserWorkoutsQuery().document,
        fetchPolicy: FetchPolicy.cacheAndNetwork,

        // These are user created workouts
      ),
      builder: (result, {fetchMore, refetch}) {
        final workouts = UserWorkouts$Query.fromJson(result.data ?? {})
            .userWorkouts
            .where((workoutSummary) => Utils.textNotNull(_searchString)
                ? workoutSummary.name
                    .toLowerCase()
                    .contains(_searchString!.toLowerCase())
                : true)
            // TODO: Should be able to remove the null check from here once this issue is resolved.
            // https://github.com/zino-app/graphql-flutter/issues/814
            .sortedBy<DateTime>((w) => w.createdAt!)
            .reversed
            .toList();

        return CupertinoPageScaffold(
            navigationBar: BasicNavBar(
              middle: NavBarTitle('Your Workouts'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () => context.push(
                        rootNavigator: true,
                        fullscreenDialog: true,
                        child: WorkoutCreator()),
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
                            onChanged: (searchString) =>
                                setState(() => _searchString = searchString),
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
                                  WorkoutDetailsRoute(id: workouts[index].id)),
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
      },
    );
  }
}
