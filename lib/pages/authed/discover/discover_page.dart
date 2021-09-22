import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/cards/discover_featured_card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: const MyNavBar(
        withoutLeading: true,
        middle: LeadingNavBarTitle(
          'Discover',
          fontSize: FONTSIZE.five,
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
                          context.navigateTo(const DiscoverWorkoutsRoute())),
                  DiscoverPageButton(
                      text: 'Plans',
                      onPressed: () =>
                          context.navigateTo(const DiscoverPlansRoute())),
                  DiscoverPageButton(
                      text: 'Challenges',
                      onPressed: () =>
                          context.navigateTo(const DiscoverChallengesRoute())),
                  DiscoverPageButton(
                      text: 'Clubs',
                      onPressed: () =>
                          context.navigateTo(const DiscoverClubsRoute())),
                ],
              )),
          Expanded(
            child: QueryObserver<DiscoverFeatured$Query, json.JsonSerializable>(
                key: Key('DiscoverPage - ${DiscoverFeaturedQuery()}'),
                query: DiscoverFeaturedQuery(),
                fetchPolicy: QueryFetchPolicy.networkOnly,
                loadingIndicator: const ShimmerCardList(itemCount: 10),
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
      margin: const EdgeInsets.only(right: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: context.theme.primary)),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onPressed: onPressed,
        child: MyText(
          text.toUpperCase(),
          size: FONTSIZE.two,
        ),
      ),
    );
  }
}
