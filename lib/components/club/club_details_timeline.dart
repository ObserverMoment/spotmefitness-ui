import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feed_utils.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:faye_dart/src/subscription.dart';
import 'package:collection/collection.dart';

/// NOTE: Logic in this widget is very simlar to that in [AuthedUserTimeline] in [FeedsAndFollows]. Except there is no sharing of posts to club feeds - they are club specific. Plus we may add some additional functionality - such as comments / threads to timeline posts here.
class ClubDetailsTimeline extends StatefulWidget {
  final Club club;
  const ClubDetailsTimeline({
    Key? key,
    required this.club,
  }) : super(key: key);

  @override
  _ClubDetailsTimelineState createState() => _ClubDetailsTimelineState();
}

class _ClubDetailsTimelineState extends State<ClubDetailsTimeline> {
  late AuthedUser _authedUser;
  late StreamFeedClient _streamFeedClient;

  /// Owners and admins can post to this feed.
  late FlatFeed _clubMembersFeed;

  /// TODO:
  /// Members can follow / unfollow the club members feed with their timeline.
  late FlatFeed _authedUserTimelineFeed;

  bool _isLoading = true;
  late PagingController<int, ActivityWithObjectData> _pagingController;
  late ScrollController _scrollController;

  Subscription? _feedSubscription;

  /// GetStream uses integer offset for making api calls to get more activities when paginating.
  final int _postsPerPage = 10;

  /// New posts that have come in via the subscription.
  /// We let the user choose if they want to see these via a floating button at the top of the list.
  /// Ontap these activities get added to the top of the [_pagingController.itemList] and the user is scrolled back to the top of the page.
  List<ActivityWithObjectData> _newActivitiesWithObjectData = [];

  /// List of activities which the current user has marked as liked.
  List<PostWithLikeReaction> _postsWithLikeReactions = [];

  @override
  void initState() {
    super.initState();
    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _streamFeedClient = context.streamFeedClient;

    _clubMembersFeed = _streamFeedClient.flatFeed(kClubMembersFeedName);
    _authedUserTimelineFeed =
        _streamFeedClient.flatFeed(kUserTimelineName, _authedUser.id);

    _loadInitialData().then((_) => _subscribeToFeed());

    _pagingController = PagingController<int, ActivityWithObjectData>(
        firstPageKey: 0, invisibleItemsThreshold: 5);
    _scrollController = ScrollController();

    _pagingController.addPageRequestListener((nextPageKey) {
      _getTimelinePosts(offset: nextPageKey);
    });
  }

  Future<void> _loadInitialData() async {
    await _getTimelinePosts(offset: 0);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getTimelinePosts({required int offset}) async {
    try {
      final feedActivities = await _clubMembersFeed.getEnrichedActivities(
        limit: _postsPerPage,
        offset: offset,
        // On the timeline we dont show like counts or share counts
        // But we do want to know if the user has liked or shared a post already
        flags: EnrichmentFlags().withOwnReactions(),
      );

      final feedActivitiesWithOwnLikeReactions = feedActivities.where((a) =>
          a.ownReactions?[kLikeReactionName] != null &&
          a.ownReactions![kLikeReactionName]!.isNotEmpty);

      _postsWithLikeReactions = [
        ..._postsWithLikeReactions,
        ...feedActivitiesWithOwnLikeReactions
            .map((a) => PostWithLikeReaction(
                activityId: a.id!,
                reaction: a.ownReactions![kLikeReactionName]![0]))
            .toList()
      ];

      final activitiesWithObjectData =
          await FeedUtils.getPostsUserAndObjectData(context, feedActivities);

      final int numPostsBefore = _pagingController.itemList?.length ?? 0;
      final int numNewPosts = activitiesWithObjectData.length;

      if (feedActivities.length < _postsPerPage) {
        _pagingController.appendLastPage(activitiesWithObjectData);
      } else {
        _pagingController.appendPage(
            activitiesWithObjectData, numPostsBefore + numNewPosts);
      }
    } catch (e) {
      print(e.toString());
      _pagingController.error = e.toString();
      context.showToast(
          message: 'Sorry there was a problem loading your posts.',
          toastType: ToastType.destructive);
    }
  }

  Future<void> _subscribeToFeed() async {
    try {
      _feedSubscription = await _clubMembersFeed.subscribe(_handleNewPosts);
    } catch (e) {
      print(e);
      context.showToast(
          message: 'There was a problem, updates will not be received.');
    } finally {
      setState(() {});
    }
  }

  Future<void> _handleNewPosts(RealtimeMessage? message) async {
    if (message?.newActivities != null && message!.newActivities.isNotEmpty) {
      final newActivitiesWithObjectData =
          await FeedUtils.getPostsUserAndObjectData(
              context, message.newActivities);

      final sortedNewActivities = newActivitiesWithObjectData
          .sortedBy<DateTime>((a) => a.activity.time!);

      setState(() {
        _newActivitiesWithObjectData = [
          ...sortedNewActivities,
          ..._newActivitiesWithObjectData
        ];
      });
    }
  }

  void _prependNewPosts() {
    /// Animate the user back to the top of the list.
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: kStandardAnimationDuration, curve: Curves.easeOut);
    }

    /// Add the new items to the paging controller.
    _pagingController.itemList = [
      ..._newActivitiesWithObjectData,
      ..._pagingController.itemList ?? []
    ];

    /// Clear the [_newActivitiesWithObjectData] to remove the floating button.
    setState(() {
      _newActivitiesWithObjectData = [];
    });
  }

  Future<void> _likeUnlikePost(String activityId) async {
    final postWithReaction = _postsWithLikeReactions
        .firstWhereOrNull((p) => p.activityId == activityId);
    if (postWithReaction != null) {
      await _streamFeedClient.reactions.delete(postWithReaction.reaction.id!);
      _postsWithLikeReactions.removeWhere((p) => p.activityId == activityId);
    } else {
      final reaction =
          await _streamFeedClient.reactions.add(kLikeReactionName, activityId);
      _postsWithLikeReactions.add(
          PostWithLikeReaction(activityId: activityId, reaction: reaction));
    }
    setState(() {});
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    _feedSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final likedPostIds =
        _postsWithLikeReactions.map((p) => p.activityId).toList();

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _isLoading
            ? ShimmerCardList(
                itemCount: 10,
                cardHeight: 260,
              )
            : _pagingController.itemList == null ||
                    _pagingController.itemList!.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: MyText(
                            'No posts yet..',
                            size: FONTSIZE.BIG,
                            subtext: true,
                          ),
                        ),
                      )
                    ],
                  )
                : PagedListView<int, ActivityWithObjectData>(
                    pagingController: _pagingController,
                    scrollController: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    builderDelegate:
                        PagedChildBuilderDelegate<ActivityWithObjectData>(
                      itemBuilder: (context, post, index) => SizeFadeIn(
                        duration: 50,
                        delay: index,
                        delayBasis: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TimelinePostCard(
                            activityWithObjectData: post,
                            likeUnlikePost: () =>
                                _likeUnlikePost(post.activity.id!),
                            userHasLiked:
                                likedPostIds.contains(post.activity.id!),
                            disableSharing: true,
                          ),
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (context) => MyText(
                        'Oh dear, ${_pagingController.error.toString()}',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                      ),
                      newPageErrorIndicatorBuilder: (context) => MyText(
                        'Oh dear, ${_pagingController.error.toString()}',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                      ),
                      firstPageProgressIndicatorBuilder: (c) => LoadingCircle(),
                      newPageProgressIndicatorBuilder: (c) => LoadingCircle(),
                      noItemsFoundIndicatorBuilder: (c) =>
                          Center(child: MyText('No results...')),
                    ),
                  ),
        if (_newActivitiesWithObjectData.isNotEmpty)
          Positioned(
              top: 8,
              child: SizeFadeIn(
                  child: FloatingIconButton(
                iconData: CupertinoIcons.news,
                onPressed: _prependNewPosts,
                text:
                    '${_newActivitiesWithObjectData.length} new ${_newActivitiesWithObjectData.length == 1 ? "post" : "posts"}',
              )))
      ],
    );
  }
}

class PostWithLikeReaction {
  final String activityId;
  final Reaction reaction;
  const PostWithLikeReaction({
    required this.activityId,
    required this.reaction,
  });
}

class PostWithShareReaction {
  final String activityId;
  final Reaction reaction;
  const PostWithShareReaction(
      {required this.activityId, required this.reaction});
}
