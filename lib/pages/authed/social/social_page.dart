import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/club_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class SocialPage extends StatelessWidget {
  Widget _buildNavBarButton(IconData iconData, onPressed) => CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      onPressed: onPressed,
      child: Icon(iconData));

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Social'),
        trailing: NavBarTrailingRow(children: [
          _buildNavBarButton(CupertinoIcons.bell,
              () => print('navigate to notifications page')),
          _buildNavBarButton(CupertinoIcons.chat_bubble_text,
              () => context.pushRoute(ChatsOverviewRoute())),
        ]),
      ),
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _HorizontalClubsList(),
                  )
                ]))
              ],
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: MyHeaderText('Feed'),
                  ),
                  _buildNavBarButton(CupertinoIcons.person_add,
                      () => context.navigateTo(DiscoverPeopleRoute()))
                ],
              ),
              Container(
                child: MyHeaderText(
                  'Coming soon!',
                  size: FONTSIZE.BIG,
                ),
              ),
            ],
          )),
    );
  }
}

class _HorizontalClubsList extends StatelessWidget {
  const _HorizontalClubsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = UserClubsQuery();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: MyHeaderText('Clubs'),
              ),
              CupertinoButton(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    CupertinoIcons.compass,
                  ),
                  onPressed: () => context.navigateTo(DiscoverClubsRoute()))
            ],
          ),
        ),
        QueryObserver<UserClubs$Query, json.JsonSerializable>(
            key:
                Key('SocialPage._HorizontalClubsList - ${query.operationName}'),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: ContentBox(
                                child: BorderButton(
                                    withBorder: false,
                                    mini: true,
                                    prefix: Icon(CupertinoIcons.search_circle),
                                    text: 'Find clubs',
                                    onPressed: () => context
                                        .navigateTo(DiscoverClubsRoute())),
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
