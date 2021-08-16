import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/club_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class HorizontalClubsList extends StatelessWidget {
  const HorizontalClubsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = UserClubsQuery();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: MyHeaderText(
                'Clubs',
                size: FONTSIZE.BIG,
              ),
            ),
            TextButton(
                text: 'See all',
                underline: false,
                onPressed: () =>
                    context.navigateTo(HomeStack(children: [YourClubsRoute()])))
          ],
        ),
        QueryObserver<UserClubs$Query, json.JsonSerializable>(
            key: Key('SocialPage.HorizontalClubsList - ${query.operationName}'),
            query: query,
            loadingIndicator: ShimmerHorizontalCardList(
              listHeight: 140,
            ),
            builder: (data) {
              final clubs = data.userClubs;

              /// Height of this container must match [ClubSummaryCard] height.
              return Container(
                height: 140,
                alignment: Alignment.centerLeft,
                child: data.userClubs.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: clubs.length,
                        itemBuilder: (c, i) => GestureDetector(
                          onTap: () => context.navigateTo(
                              ClubDetailsRoute(id: data.userClubs[i].id)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClubSummaryCard(
                              club: clubs[i],
                            ),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: ContentBox(
                                child: BorderButton(
                                    withBorder: false,
                                    prefix: Icon(
                                      CupertinoIcons.add,
                                      size: 16,
                                    ),
                                    text: 'Create a club',
                                    onPressed: () =>
                                        context.navigateTo(ClubCreatorRoute())),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            })
      ],
    );
  }
}
