import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/club_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/social/authed_user/authed_user_feed.dart';
import 'package:spotmefitness_ui/components/social/authed_user/authed_user_followers.dart';
import 'package:spotmefitness_ui/components/social/authed_user/authed_user_following.dart';
import 'package:spotmefitness_ui/components/social/authed_user/authed_user_timeline.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  int _activeTabIndex = 0;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    setState(() => _activeTabIndex = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          _buildNavBarButton(CupertinoIcons.person_add,
              () => context.navigateTo(DiscoverPeopleRoute())),
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
          body: StackAndFloatingButton(
            buttonText: 'New Post',
            onPressed: () {},
            child: Column(
              children: [
                SizedBox(height: 12),
                MyTabBarNav(
                    titles: ['Timeline', 'Posts', 'Followers', 'Following'],
                    handleTabChange: _changeTab,
                    activeTabIndex: _activeTabIndex),
                SizedBox(height: 8),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _changeTab,
                    children: [
                      AuthedUserTimeline(),
                      AuthedUserFeed(),
                      AuthedUserFollowers(),
                      AuthedUserFollowing(),
                    ],
                  ),
                )
              ],
            ),
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
