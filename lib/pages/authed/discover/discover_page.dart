import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/discover_featured_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Discover'),
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BorderButton(
                      mini: true,
                      text: 'Workouts',
                      onPressed: () =>
                          context.navigateTo(DiscoverWorkoutsRoute())),
                  BorderButton(
                      mini: true,
                      text: 'Plans',
                      onPressed: () =>
                          context.navigateTo(DiscoverPlansRoute())),
                  BorderButton(
                      mini: true,
                      text: 'Challenges',
                      onPressed: () =>
                          context.navigateTo(DiscoverChallengesRoute())),
                  BorderButton(
                      mini: true,
                      text: 'Events',
                      onPressed: () =>
                          context.navigateTo(DiscoverEventsRoute())),
                ],
              )),
          Expanded(
            child: QueryObserver<DiscoverFeatured$Query, json.JsonSerializable>(
                key: Key('DiscoverPage - ${DiscoverFeaturedQuery()}'),
                query: DiscoverFeaturedQuery(),
                fetchPolicy: QueryFetchPolicy.networkOnly,
                loadingIndicator: ShimmerCardList(itemCount: 10),
                builder: (data) {
                  final discoverFeatured = data.discoverFeatured;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: discoverFeatured.length,
                      itemBuilder: (c, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DiscoverFeaturedCard(
                              discoverFeatured: discoverFeatured[i],
                            ),
                          ));
                }),
          ),
        ],
      ),
    );
  }
}
