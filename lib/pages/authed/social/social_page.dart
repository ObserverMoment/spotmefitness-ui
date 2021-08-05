import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/club_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
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
          _buildNavBarButton(CupertinoIcons.chat_bubble_text_fill,
              () => context.pushRoute(ChatsOverviewRoute())),
          _buildNavBarButton(CupertinoIcons.person_add_solid, () => {}),
          _buildNavBarButton(CupertinoIcons.compass_fill, () => {}),
        ]),
      ),
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: HorizontalFriendsList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: HorizontalClubsList(),
                  )
                ]))
              ],
          body: Container(
            child: Center(
                child: MyHeaderText(
              'Feed coming soon',
              size: FONTSIZE.HUGE,
            )),
          )),
    );
  }
}

class HorizontalFriendsList extends StatelessWidget {
  const HorizontalFriendsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query =
        UserPublicProfilesQuery(variables: UserPublicProfilesArguments());

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
        QueryObserver<UserPublicProfiles$Query, json.JsonSerializable>(
            key: Key('SocialPage - ${query.operationName}'),
            query: query,
            loadingIndicator: ShimmerFriendsList(
              avatarSize: 70,
            ),
            builder: (data) {
              final authedUser = GetIt.I<AuthBloc>().authedUser;
              final publicUsers = data.userPublicProfiles
                  .where((u) => u.id != authedUser?.id)
                  .toList();

              return Container(
                height: 70,
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: publicUsers.length,
                  itemBuilder: (c, i) => GestureDetector(
                    onTap: () => context.navigateTo(
                        UserPublicProfileDetailsRoute(
                            userId: publicUsers[i].id)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: UserAvatar(
                        size: 70,
                        avatarUri: publicUsers[i].avatarUri,
                      ),
                    ),
                  ),
                ),
              );
            })
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
              cardHeight: 130,
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
