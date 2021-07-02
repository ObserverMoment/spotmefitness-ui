import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/discover_workout_plan_category_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class DiscoverPlansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Plans'),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SecondaryButton(
                  text: 'Find a Plan',
                  prefix: Icon(
                    CupertinoIcons.viewfinder_circle,
                    color: Styles.white,
                    size: 20,
                  ),
                  onPressed: () => context.navigateTo(
                      WorkoutPlanFinderRoute(initialOpenPublicTab: true))),
            ),
          ),
          Expanded(
            child: QueryObserver<DiscoverWorkoutPlanCategories$Query,
                    json.JsonSerializable>(
                key: Key(
                    'DiscoverWorkoutPlansPage - ${DiscoverWorkoutPlanCategoriesQuery()}'),
                query: DiscoverWorkoutPlanCategoriesQuery(),
                fetchPolicy: QueryFetchPolicy.networkOnly,
                loadingIndicator: ShimmerCardList(itemCount: 10),
                builder: (data) {
                  final discoverWorkoutPlanCategories =
                      data.discoverWorkoutPlanCategories;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: discoverWorkoutPlanCategories.length,
                      itemBuilder: (c, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DiscoverWorkoutPlanCategoryCard(
                              discoverWorkoutPlanCategory:
                                  discoverWorkoutPlanCategories[i],
                            ),
                          ));
                }),
          ),
        ],
      ),
    );
  }
}
