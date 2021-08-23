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

  // Subscription? _timelineSubscription;
  // bool _timelineLoading = true;
  // List<ActivityWithObjectData> _timelineActivitiesWithObjectData =
  //     <ActivityWithObjectData>[];

  /// Subscription handler will put new activities from [user_timeline] feed here.
  /// This gets passed to the timeline widget to be handled.
  // List<ActivityWithObjectData> _newTimelineActivitiesWithObjectData =
  //     <ActivityWithObjectData>[];

  @override
  void initState() {
    super.initState();

    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _timelineFeed =
        _streamFeedClient.flatFeed(kUserTimelineName, _authedUser.id);
    _userFeed = _streamFeedClient.flatFeed(kUserFeedName, _authedUser.id);

    // _loadInitialData().then((_) {
    //   _subscribeToTimelineFeed();
    // });
  }

  // Future<void> _subscribeToTimelineFeed() async {
  //   try {
  //     _timelineSubscription =
  //         await _timeline.subscribe(_updateNewTimelinePosts);
  //   } catch (e) {
  //     _handleSubscriptionError(e);
  //   } finally {
  //     setState(() {});
  //   }
  // }

  // void _handleSubscriptionError(e) {
  //   print(e);
  //   context.showToast(
  //       message: 'There was a problem, updates will not be received.');
  // }

  // Future<void> _loadInitialData() async {
  //   try {

  //     await _getFollowing();
  //     await _getFollowers();
  //   } catch (e) {
  //     print(e.toString());
  //     context.showToast(
  //         message: 'Sorry there was a problem loading your timeline.',
  //         toastType: ToastType.destructive);
  //   } finally {
  //     setState(() {
  //       _timelineLoading = false;
  //     });
  //   }
  // }

  // Future<void> _updateNewTimelinePosts(RealtimeMessage? message) async {
  //   if (message?.newActivities != null) {
  //     final newActivitiesWithObjectData =
  //         await FeedUtils.getPostsUserAndObjectData(
  //             context,
  //             message!.newActivities
  //                 .map((e) => FeedUtils.activityFromEnrichedActivity(e))
  //                 .toList());

  //     setState(() {
  //       _timelineActivitiesWithObjectData = [
  //         ...newActivitiesWithObjectData,
  //         ..._timelineActivitiesWithObjectData,
  //       ];
  //     });
  //   }
  // }

  /// Gets followers of [user_feed] and hydrate with UserAvatarData.
  // Future<void> _getFollowers() async {
  //   final feedFollowers = await _feed.followers();
  //   final userIds = feedFollowers.map((f) => f.feedId.split(':')[1]).toList();

  //   _followers = await _getFollowsWithUserData(feedFollowers, userIds);
  // }

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
              ),
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

/// Displays a list of [TimelinePostCard] widgets and animates in an
// class TimelineFeedPostList extends StatefulWidget {
//   final List<ActivityWithObjectData> activitiesWithObjectData;

//   /// When this is not empty we show a floating 'new posts' button at the top of the list.
//   /// Tapping this button will add these to the main list [activitiesWithObjectData] and scroll the user to the top of the list.
//   final List<ActivityWithObjectData> newActivitiesWithObjectData;
//   final void Function(String activityId)? deleteActivityById;
//   const TimelineFeedPostList(
//       {Key? key,
//       required this.activitiesWithObjectData,
//       this.deleteActivityById,
//       this.newActivitiesWithObjectData = const []})
//       : super(key: key);

//   @override
//   _TimelineFeedPostListState createState() => _TimelineFeedPostListState();
// }

// class _TimelineFeedPostListState extends State<TimelineFeedPostList> {
//   late PagingController<int, ActivityWithObjectData> _pagingController;
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _pagingController =
//         PagingController<int, ActivityWithObjectData>(firstPageKey: 0);
//     _scrollController = ScrollController();

//     _pagingController.appendPage(widget.activitiesWithObjectData, 1);
//   }

//   @override
//   void didUpdateWidget(covariant TimelineFeedPostList oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PagedListView<int, ActivityWithObjectData>(
//       pagingController: _pagingController,
//       scrollController: _scrollController,
//       physics: AlwaysScrollableScrollPhysics(),
//       builderDelegate: PagedChildBuilderDelegate<ActivityWithObjectData>(
//         itemBuilder: (context, post, index) => SizeFadeIn(
//           duration: 50,
//           delay: index,
//           delayBasis: 10,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: TimelinePostCard(
//               activityWithObjectData: post,
//               deleteActivityById: widget.deleteActivityById,
//             ),
//           ),
//         ),
//         firstPageProgressIndicatorBuilder: (c) => LoadingCircle(),
//         newPageProgressIndicatorBuilder: (c) => LoadingCircle(),
//         noItemsFoundIndicatorBuilder: (c) =>
//             Center(child: MyText('No results...')),
//       ),
//     );
//   }
// }

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
