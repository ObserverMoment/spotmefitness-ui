import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/discover_workout_category_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class DiscoverWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle('Workouts'),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Transform.rotate(
              angle: pi / 2,
              child: Icon(
                CupertinoIcons.slider_horizontal_3,
                size: 30,
              ),
            ),
            onPressed: () => context
                .navigateTo(WorkoutFinderRoute(initialOpenPublicTab: true))),
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
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
            child: QueryObserver<DiscoverWorkoutCategories$Query,
                    json.JsonSerializable>(
                key: Key(
                    'DiscoverWorkoutsPage - ${DiscoverWorkoutCategoriesQuery()}'),
                query: DiscoverWorkoutCategoriesQuery(),
                fetchPolicy: QueryFetchPolicy.networkOnly,
                loadingIndicator: ShimmerCardList(itemCount: 10),
                builder: (data) {
                  final discoverWorkoutCategories =
                      data.discoverWorkoutCategories;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: discoverWorkoutCategories.length,
                      itemBuilder: (c, i) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12.0),
                            child: DiscoverWorkoutCategoryCard(
                              discoverWorkoutCategory:
                                  discoverWorkoutCategories[i],
                            ),
                          ));
                }),
          ),
        ],
      ),
    );
  }
}
