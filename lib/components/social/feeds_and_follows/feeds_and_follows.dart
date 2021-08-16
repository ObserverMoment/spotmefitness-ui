import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_feed.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_followers.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_following.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/authed_user_timeline.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

/// Maintains subscriptions
class FeedsAndFollows extends StatefulWidget {
  const FeedsAndFollows({Key? key}) : super(key: key);

  @override
  _FeedsAndFollowsState createState() => _FeedsAndFollowsState();
}

class _FeedsAndFollowsState extends State<FeedsAndFollows> {
  int _activeTabIndex = 0;
  final _pageController = PageController();

  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;

  /// Timeline - activities from feeds the users timeline is following.
  late FlatFeed _timeline;
  bool _timelineLoading = true;
  List<Activity> _timelineActivities = <Activity>[];

  /// List of feeds [user_feeds] which are being followed by this [user_timeline]
  List<FollowWithUserAvatarData> _following = <FollowWithUserAvatarData>[];

  /// Feed - posts the user has made themselves.
  late FlatFeed _feed;
  bool _feedLoading = true;
  List<Activity> _feedActivities = <Activity>[];

  /// List of followers [user_timelines] which are following this [user_feed]
  List<FollowWithUserAvatarData> _followers = <FollowWithUserAvatarData>[];

  void _addTest() async {
    print('------------------------------');
    print('------------------------------');
    print('------------------------------');
    print('------------------------------');
    print('_streamFeedClient.currentUser');
    print(_streamFeedClient.currentUser!.profile());
    await _feed.addActivity(Activity(
        //
        actor: _streamFeedClient.currentUser!.ref,
        verb: 'post',
        object: 'Article:${DateTime.now().millisecondsSinceEpoch}'));
    _refreshFeed();
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    setState(() => _activeTabIndex = index);
  }

  @override
  void initState() {
    super.initState();

    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _timeline = _streamFeedClient.flatFeed('user_timeline', _authedUser.id);
    _feed = _streamFeedClient.flatFeed('user_feed', _authedUser.id);

    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      _timelineActivities = await _timeline.getActivities();
      await _getFollowing();

      _feedActivities = await _feed.getActivities();
      await _getFollowers();
    } catch (e) {
      print(e.toString());
      context.showToast(
          message: 'Sorry there was a problem loading your timeline info.',
          toastType: ToastType.destructive);
    } finally {
      setState(() {
        _timelineLoading = false;
        _feedLoading = false;
      });
    }
  }

  Future<void> _getTimeline() async {}
  Future<void> _getFeed() async {}

  Future<void> _getFollowing() async {
    final timelineFollowing = await _timeline.following();
    final userIds =
        timelineFollowing.map((f) => f.targetId.split(':')[1]).toList();

    /// Call API and get UserAvatarData[]
    final result = await context.graphQLStore
        .networkOnlyOperation<UserAvatars$Query, UserAvatarsArguments>(
            operation: UserAvatarsQuery(
                variables: UserAvatarsArguments(ids: userIds)));

    _following = timelineFollowing
        .mapIndexed((i, follower) => FollowWithUserAvatarData(
            follower,
            result.data?.userAvatars
                .firstWhereOrNull((u) => u.id == userIds[i])))
        .toList();
  }

  /// Gets followers of [user_feed] and hydrate with UserAvatarData.
  Future<void> _getFollowers() async {
    final feedFollowers = await _feed.followers();
    final userIds = feedFollowers.map((f) => f.feedId.split(':')[1]).toList();

    /// Call API and get UserAvatarData[]
    final result = await context.graphQLStore
        .networkOnlyOperation<UserAvatars$Query, UserAvatarsArguments>(
            operation: UserAvatarsQuery(
                variables: UserAvatarsArguments(ids: userIds)));

    _followers = feedFollowers
        .mapIndexed((i, follower) => FollowWithUserAvatarData(
            follower,
            result.data?.userAvatars
                .firstWhereOrNull((u) => u.id == userIds[i])))
        .toList();
  }

  /// Pull to refresh - triggers the refresh methods ///
  /// Timeline and following
  Future<void> _refreshTimeline() async {
    try {
      _timelineActivities = await _timeline.getActivities();
      await _getFollowing();
      setState(() {});
    } catch (e) {
      print(e.toString());
      context.showToast(
          message: 'Sorry there was a problem loading your timeline info.',
          toastType: ToastType.destructive);
    }
  }

  /// Feed and followers.
  /// Also called after user has added a new post to their feed so that update is immediate.
  Future<void> _refreshFeed() async {
    try {
      _feedActivities = await _feed.getActivities();
      await _getFollowers();
      setState(() {});
    } catch (e) {
      print(e.toString());
      context.showToast(
          message: 'Sorry there was a problem loading your feed info.',
          toastType: ToastType.destructive);
    }
  }

  /// For each data type (page) there is a [PagingController].
  /// Scroll down - triggers getNextPage methods ///
  void _getNextTimelinePage() {}

  void _getNextFeedPage() {}

  void _getNextFollowersPage() {}

  void _getNextFollowingPage() {}

  Widget _buildFollowCount(int count) => Positioned(
        top: -5,
        right: 2,
        child: MyText(
          count.toString(),
          color: Styles.colorTwo,
          size: FONTSIZE.SMALL,
          weight: FontWeight.bold,
        ),
      );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StackAndFloatingButton(
      buttonText: 'New Post',
      onPressed: _addTest,
      child: Column(
        children: [
          SizedBox(height: 12),
          MyTabBarNav(titles: [
            'Timeline',
            'Posts',
            'Followers',
            'Following'
          ], superscriptIcons: [
            null,
            null,
            _buildFollowCount(_followers.length),
            _buildFollowCount(_following.length),
          ], handleTabChange: _changeTab, activeTabIndex: _activeTabIndex),
          SizedBox(height: 8),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                AuthedUserTimeline(
                  activities: _timelineActivities,
                  isLoading: _timelineLoading,
                  refreshData: _refreshTimeline,
                ),
                AuthedUserFeed(
                  activities: _feedActivities,
                  isLoading: _feedLoading,
                  refreshData: _refreshFeed,
                ),
                AuthedUserFollowers(
                  followers: _followers,
                  isLoading: _feedLoading,
                  refreshData: _refreshFeed,
                ),
                AuthedUserFollowing(
                  following: _following,
                  isLoading: _timelineLoading,
                  refreshData: _refreshTimeline,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FollowWithUserAvatarData {
  final Follow follow;
  final UserAvatarData? userAvatarData;
  const FollowWithUserAvatarData(this.follow, this.userAvatarData);
}
