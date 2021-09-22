import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/cards/discover_workout_plan_category_card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

class DiscoverPlansPage extends StatelessWidget {
  const DiscoverPlansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        middle: const NavBarTitle('Discover Plans'),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.search,
            ),
            onPressed: () => context.navigateTo(
                WorkoutPlanFinderRoute(initialOpenPublicTab: true))),
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              height: 50,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: SelectableTag(
                          isSelected: false,
                          onPressed: () => {},
                          text: 'Popular Tag'),
                    ),
                  ))),
          Expanded(
            child: QueryObserver<DiscoverWorkoutPlanCategories$Query,
                    json.JsonSerializable>(
                key: Key(
                    'DiscoverWorkoutPlansPage - ${DiscoverWorkoutPlanCategoriesQuery()}'),
                query: DiscoverWorkoutPlanCategoriesQuery(),
                fetchPolicy: QueryFetchPolicy.networkOnly,
                loadingIndicator: const ShimmerCardList(itemCount: 10),
                builder: (data) {
                  final discoverWorkoutPlanCategories =
                      data.discoverWorkoutPlanCategories;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: discoverWorkoutPlanCategories.length,
                      itemBuilder: (c, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
