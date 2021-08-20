import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
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
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:faye_dart/src/subscription.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:collection/collection.dart';
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
  late FlatFeed _timeline;
  Subscription? _timelineSubscription;
  bool _timelineLoading = true;
  List<ActivityWithObjectData> _timelineActivitiesWithObjectData =
      <ActivityWithObjectData>[];

  /// List of feeds [user_feeds] which are being followed by this [user_timeline]
  List<FollowWithUserAvatarData> _following = <FollowWithUserAvatarData>[];

  /// Feed - posts the user has made themselves.
  late FlatFeed _feed;
  Subscription? _feedSubscription;
  bool _feedLoading = true;
  List<ActivityWithObjectData> _feedActivitiesWithObjectData =
      <ActivityWithObjectData>[];

  /// List of followers [user_timelines] which are following this [user_feed]
  List<FollowWithUserAvatarData> _followers = <FollowWithUserAvatarData>[];

  @override
  void initState() {
    super.initState();

    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;
    _timeline = _streamFeedClient.flatFeed(kUserTimelineName, _authedUser.id);
    _feed = _streamFeedClient.flatFeed(kUserFeedName, _authedUser.id);

    _loadInitialData().then((_) {
      _subscribeToFeeds();
    });
  }

  Future<void> _subscribeToFeeds() async {
    try {
      _feedSubscription = await _feed.subscribe(_updateNewFeedPosts);
      _timelineSubscription =
          await _timeline.subscribe(_updateNewTimelinePosts);
    } catch (e) {
      _handleSubscriptionError(e);
    } finally {
      setState(() {});
    }
  }

  void _handleSubscriptionError(e) {
    print(e);
    context.showToast(
        message: 'There was a problem, updates will not be received.');
  }

  Future<void> _loadInitialData() async {
    try {
      await _getTimelinePosts();
      await _getFollowing();
      await _getFeedPosts();
      await _getFollowers();
    } catch (e) {
      print(e.toString());
      context.showToast(
          message: 'Sorry there was a problem loading your timeline.',
          toastType: ToastType.destructive);
    } finally {
      setState(() {
        _timelineLoading = false;
        _feedLoading = false;
      });
    }
  }

  Future<void> _getTimelinePosts() async {
    final timelineActivities = await _timeline.getActivities();
    if (timelineActivities.isNotEmpty) {
      _timelineActivitiesWithObjectData =
          await _getPostsUserAndObjectData(timelineActivities);
    }
  }

  Future<void> _getFeedPosts() async {
    final feedActivities = await _feed.getActivities();
    if (feedActivities.isNotEmpty) {
      _feedActivitiesWithObjectData =
          await _getPostsUserAndObjectData(feedActivities);
    }
  }

  Future<void> _updateNewTimelinePosts(RealtimeMessage? message) async {
    if (message?.newActivities != null) {
      final newActivitiesWithObjectData = await _getPostsUserAndObjectData(
          message!.newActivities
              .map((e) => _activityFromEnrichedActivity(e))
              .toList());

      setState(() {
        _timelineActivitiesWithObjectData = [
          ...newActivitiesWithObjectData,
          ..._timelineActivitiesWithObjectData,
        ];
      });
    }
  }

  Future<void> _updateNewFeedPosts(RealtimeMessage? message) async {
    if (message?.newActivities != null) {
      final newActivitiesWithObjectData = await _getPostsUserAndObjectData(
          message!.newActivities
              .map((e) => _activityFromEnrichedActivity(e))
              .toList());

      setState(() {
        _feedActivitiesWithObjectData = [
          ...newActivitiesWithObjectData,
          ..._feedActivitiesWithObjectData,
        ];
      });
    }
  }

  /// The difference between the structures of EnrichedActivity and Activty is awkward...
  /// Will also change depending if you have stored an object (a user for example) in getStream.
  /// Here we assume that no enriched data exists.
  Activity _activityFromEnrichedActivity(EnrichedActivity e) => Activity(
        id: e.id,
        // Must be [SU:id]
        actor: "SU:${(e.actor!.data as Map)['id']}",
        // Must be [ObjectType:id]
        object: e.object!.data.toString(),
        verb: e.verb,
        time: e.time,
        extraData: e.extraData,
      );

  /// Calls our API to get the necessary data for the User (who created the post) and for the referenced object (all posts reference an object in the DB - e.g a Workout).
  /// Based on [userId] via [activity.actor], and [objectId] | [objectType] via [activity.object]
  /// [ActivityWithObjectData] is what is needed to display a single post in the UI.
  Future<List<ActivityWithObjectData>> _getPostsUserAndObjectData(
      List<Activity> activities) async {
    final List<TimelinePostDataRequestInput> postDataRequests =
        activities.map((a) {
      if (a.object == null) {
        throw Exception('Error: Activity.object should never be null.');
      }
      if (a.actor == null) {
        throw Exception('Error: Activity.actor should never be null.');
      }
      final idAndType = a.object!.split(':');

      return TimelinePostDataRequestInput(
          posterId: a.actor!.split(':')[1],
          objectId: idAndType[1],
          objectType: idAndType[0].toTimelinePostType());
    }).toList();

    /// Call API and get TimelinePostData[]
    final result = await context.graphQLStore.networkOnlyOperation<
            TimelinePostsData$Query, TimelinePostsDataArguments>(
        operation: TimelinePostsDataQuery(
            variables: TimelinePostsDataArguments(
                postDataRequests: postDataRequests)));

    if (result.hasErrors || result.data == null) {
      throw Exception(
          'getPostUserAndObjectData: Unable to retrieve full timeline posts data.');
    }

    /// [activities] and [requestedPosts] are in the same order - so we can match without going back into the [activities].
    /// Find the correct [TimelinePostData] by matching both the userId and the objectId, then add  to [ActivityWithObjectData] along with the [activity].
    return activities
        .mapIndexed<ActivityWithObjectData>((i, activity) =>
            ActivityWithObjectData(
                activity,
                result.data?.timelinePostsData.firstWhereOrNull((p) =>
                    p.poster.id == postDataRequests[i].posterId &&
                    p.object.id == postDataRequests[i].objectId)))
        .toList();
  }

  void _handleDeleteActivityById(String activityId) {
    context.showConfirmDeleteDialog(
        itemType: 'Post',
        message: 'This will remove the post from all timelines. Are you sure?',
        onConfirm: () async {
          try {
            await _feed.removeActivityById(activityId);
            context.showToast(message: 'Post deleted..');
          } catch (e) {
            print(e);
            context.showToast(
                message:
                    'Sorry, there was a problem, the post could not be deleted.');
          }
        });
  }

  Future<void> _getFollowing() async {
    final timelineFollowing = await _timeline.following();
    final userIds =
        timelineFollowing.map((f) => f.targetId.split(':')[1]).toList();

    _following = await _getFollowsWithUserData(timelineFollowing, userIds);
  }

  /// Gets followers of [user_feed] and hydrate with UserAvatarData.
  Future<void> _getFollowers() async {
    final feedFollowers = await _feed.followers();
    final userIds = feedFollowers.map((f) => f.feedId.split(':')[1]).toList();

    _followers = await _getFollowsWithUserData(feedFollowers, userIds);
  }

  /// Call our API and get the data necessary to display a user avatar and name.
  /// The feed / timeline ID in getstream matches a User id in our API.
  /// eg. ["user_feed:{our_user_id}""] or ["user_timeline:{our_user_id}""]
  Future<List<FollowWithUserAvatarData>> _getFollowsWithUserData(
      List<Follow> follows, List<String> userIds) async {
    /// Call API and get UserAvatarData[]
    final result = await context.graphQLStore
        .networkOnlyOperation<UserAvatars$Query, UserAvatarsArguments>(
            operation: UserAvatarsQuery(
                variables: UserAvatarsArguments(ids: userIds)));

    if (result.hasErrors || result.data == null) {
      throw Exception(
          '_getFollowsWithUserData: Unable to retrieve full user follow data.');
    }

    return follows
        .mapIndexed<FollowWithUserAvatarData>((i, follower) =>
            FollowWithUserAvatarData(
                follower,
                result.data?.userAvatars
                    .firstWhereOrNull((u) => u.id == userIds[i])))
        .toList();
  }

  /// For each data type (page) there is a [PagingController].
  /// Scroll down - triggers getNextPage methods ///
  void _getNextTimelinePage() {}

  void _getNextFeedPage() {}

  void _getNextFollowersPage() {}

  void _getNextFollowingPage() {}

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    setState(() => _activeTabIndex = index);
  }

  Widget _buildFollowCount(int count) => Positioned(
        top: 2,
        right: 3,
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
    _timelineSubscription?.cancel();
    _feedSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4),
        MyTabBarNav(titles: [
          'Timeline',
          'Posts',
          'Clubs',
          'Followers',
          'Following'
        ], superscriptIcons: [
          null,
          null,
          null,
          _followers.isNotEmpty ? _buildFollowCount(_followers.length) : null,
          _following.isNotEmpty ? _buildFollowCount(_following.length) : null,
        ], handleTabChange: _changeTab, activeTabIndex: _activeTabIndex),
        SizedBox(height: 8),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              AuthedUserTimeline(
                activitiesWithObjectData: _timelineActivitiesWithObjectData,
                isLoading: _timelineLoading,
              ),
              AuthedUserFeed(
                  activitiesWithObjectData: _feedActivitiesWithObjectData,
                  isLoading: _feedLoading,
                  deleteActivityById: _handleDeleteActivityById),
              AuthedUserClubsList(),
              AuthedUserFollowers(
                followers: _followers,
                isLoading: _feedLoading,
              ),
              AuthedUserFollowing(
                following: _following,
                isLoading: _timelineLoading,
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// Displays a list of [TimelinePostCard] widgets and animates in an
class TimelineFeedPostList extends StatefulWidget {
  final List<ActivityWithObjectData> activitiesWithObjectData;
  final void Function(String activityId)? deleteActivityById;
  const TimelineFeedPostList(
      {Key? key,
      required this.activitiesWithObjectData,
      this.deleteActivityById})
      : super(key: key);

  @override
  _TimelineFeedPostListState createState() => _TimelineFeedPostListState();
}

class _TimelineFeedPostListState extends State<TimelineFeedPostList> {
  late PagingController<int, ActivityWithObjectData> _pagingController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _pagingController =
        PagingController<int, ActivityWithObjectData>(firstPageKey: 0);
    _scrollController = ScrollController();

    _pagingController.appendPage(widget.activitiesWithObjectData, 1);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ActivityWithObjectData>(
      pagingController: _pagingController,
      scrollController: _scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<ActivityWithObjectData>(
        itemBuilder: (context, post, index) => SizeFadeIn(
          duration: 50,
          delay: index,
          delayBasis: 15,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TimelinePostCard(
              activityWithObjectData: post,
              deleteActivityById: widget.deleteActivityById,
            ),
          ),
        ),
        firstPageProgressIndicatorBuilder: (c) => LoadingCircle(),
        newPageProgressIndicatorBuilder: (c) => LoadingCircle(),
        noItemsFoundIndicatorBuilder: (c) =>
            Center(child: MyText('No results...')),
      ),
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
