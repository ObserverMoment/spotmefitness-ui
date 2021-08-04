import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/club_card.dart';
import 'package:spotmefitness_ui/components/cards/user_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class SocialPage extends StatelessWidget {
  Widget _buildNavBarButton(IconData iconData, onPressed) => CupertinoButton(
      padding: EdgeInsets.zero, onPressed: onPressed, child: Icon(iconData));

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Social'),
        trailing: NavBarTrailingRow(children: [
          _buildNavBarButton(CupertinoIcons.person_add_solid, () => {}),
          _buildNavBarButton(CupertinoIcons.compass_fill, () => {}),
        ]),
      ),
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: HorizontalFriendsList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: HorizontalClubsList(),
                  )
                ]))
              ],
          body: Container(
            child: MyText('Feed vertical timeline'),
          )),
    );
  }
}

class HorizontalFriendsList extends StatelessWidget {
  const HorizontalFriendsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: MyHeaderText('Friends'),
            ),
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.arrow_right,
                  size: 20,
                ),
                onPressed: () => print('all friends view'))
          ],
        ),
        Container(
          height: 70,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (c, i) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: UserAvatar(size: 70),
            ),
          ),
        ),
      ],
    );
  }
}

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
              child: MyHeaderText('Clubs'),
            ),
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.arrow_right,
                  size: 20,
                ),
                onPressed: () => print('all groups view'))
          ],
        ),
        QueryObserver<UserClubs$Query, json.JsonSerializable>(
            key: Key('SocialPage.HorizontalClubsList - ${query.operationName}'),
            query: query,
            loadingIndicator: ShimmerHorizontalCardList(
              cardHeight: 132,
            ),
            builder: (data) {
              final clubs = data.userClubs;

              return Container(
                height: 140,
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: clubs.length,
                  itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClubCard(
                      club: clubs[i],
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}

class PublicProfilesGrid extends StatelessWidget {
  const PublicProfilesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query =
        UserPublicProfilesQuery(variables: UserPublicProfilesArguments());

    return QueryObserver<UserPublicProfiles$Query, json.JsonSerializable>(
        key: Key('SocialPage - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerCardGrid(
          itemCount: 12,
          maxCardWidth: 200,
        ),
        builder: (data) {
          final profileSummaries = data.userPublicProfiles;

          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: profileSummaries.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 0.8,
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemBuilder: (c, i) => GestureDetector(
                      onTap: () => context.navigateTo(
                          UserPublicProfileDetailsRoute(
                              userId: profileSummaries[i].id)),
                      child: UserProfileCard(
                        profileSummary: profileSummaries[i],
                      ),
                    )),
          );
        });
  }
}
