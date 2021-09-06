import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/discover_featured_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        withoutLeading: true,
        middle: LeadingNavBarTitle(
          'Discover',
          fontSize: FONTSIZE.LARGE,
        ),
      ),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 10),
              height: 54,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DiscoverPageButton(
                      text: 'Workouts',
                      onPressed: () =>
                          context.navigateTo(DiscoverWorkoutsRoute())),
                  DiscoverPageButton(
                      text: 'Plans',
                      onPressed: () =>
                          context.navigateTo(DiscoverPlansRoute())),
                  DiscoverPageButton(
                      text: 'Challenges',
                      onPressed: () =>
                          context.navigateTo(DiscoverChallengesRoute())),
                  DiscoverPageButton(
                      text: 'Clubs',
                      onPressed: () =>
                          context.navigateTo(DiscoverClubsRoute())),
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
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

class DiscoverPageButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const DiscoverPageButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: context.theme.primary)),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onPressed: onPressed,
        child: MyText(
          text.toUpperCase(),
          size: FONTSIZE.SMALL,
        ),
      ),
    );
  }
}
