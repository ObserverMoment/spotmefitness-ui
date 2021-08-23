import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/social/authed_user_clubs_list.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_feed.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_followers.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_following.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_timeline.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';

/// Maintains subscriptions - also includes a list of auth user's clubs
class FeedsFollowsAndClubs extends StatefulWidget {
  const FeedsFollowsAndClubs({Key? key}) : super(key: key);

  @override
  _FeedsFollowsAndClubsState createState() => _FeedsFollowsAndClubsState();
}

class _FeedsFollowsAndClubsState extends State<FeedsFollowsAndClubs> {
  int _activeTabIndex = 0;
  final _pageController = PageController();

  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;

  /// Timeline - activities from feeds the users timeline is following.
  late FlatFeed _timelineFeed;

  /// Feed - posts the user has made themselves.
  late FlatFeed _userFeed;

  @override
  void initState() {
    super.initState();

    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _timelineFeed =
        _streamFeedClient.flatFeed(kUserTimelineName, _authedUser.id);
    _userFeed = _streamFeedClient.flatFeed(kUserFeedName, _authedUser.id);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4),
        MyTabBarNav(titles: [
          'Timeline',
          'Posted',
          'Clubs',
          'Following',
          'Followers',
        ], handleTabChange: _changeTab, activeTabIndex: _activeTabIndex),
        SizedBox(height: 8),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              AuthedUserTimeline(
                  timelineFeed: _timelineFeed,
                  streamFeedClient: _streamFeedClient),
              AuthedUserFeed(
                userFeed: _userFeed,
              ),
              AuthedUserClubsList(),
              AuthedUserFollowing(
                timelineFeed: _timelineFeed,
              ),
              AuthedUserFollowers(
                userFeed: _userFeed,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class UserFollow extends StatelessWidget {
  final FollowWithUserAvatarData follow;
  const UserFollow({Key? key, required this.follow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: follow.userAvatarData != null
          ? () => context.navigateTo(
              UserPublicProfileDetailsRoute(userId: follow.userAvatarData!.id))
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(
            size: 80,
            border: true,
            borderWidth: 1,
            avatarUri: follow.userAvatarData?.avatarUri,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: MyText(
              Utils.textNotNull(follow.userAvatarData?.displayName)
                  ? follow.userAvatarData!.displayName
                  : 'Unnamed',
              size: FONTSIZE.TINY,
            ),
          ),
        ],
      ),
    );
  }
}
