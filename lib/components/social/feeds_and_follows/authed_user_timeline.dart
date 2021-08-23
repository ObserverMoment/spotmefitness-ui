import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feed_utils.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:faye_dart/src/subscription.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:collection/collection.dart';

/// Timeline for the currently logged in User.
/// GetStream fees slug is [user_timeline].
/// A [user_timeline] follows many [user_feeds].
class AuthedUserTimeline extends StatefulWidget {
  final FlatFeed timelineFeed;
  const AuthedUserTimeline({
    Key? key,
    required this.timelineFeed,
  }) : super(key: key);

  @override
  _AuthedUserTimelineState createState() => _AuthedUserTimelineState();
}

class _AuthedUserTimelineState extends State<AuthedUserTimeline>
    with AutomaticKeepAliveClientMixin<AuthedUserTimeline> {
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

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, ActivityWithObjectData>(
        firstPageKey: 0, invisibleItemsThreshold: 5);
    _scrollController = ScrollController();

    _pagingController.addPageRequestListener((nextPageKey) {
      _getTimelinePosts(offset: nextPageKey);
    });

    _loadInitialData().then((_) => _subscribeToFeed());
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
      final feedActivities = await widget.timelineFeed
          .getActivities(limit: _postsPerPage, offset: offset);

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
      _feedSubscription = await widget.timelineFeed.subscribe(_handleNewPosts);
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
              context,
              message.newActivities
                  .map((e) => FeedUtils.activityFromEnrichedActivity(e))
                  .toList());

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
    _scrollController.animateTo(0,
        duration: kStandardAnimationDuration, curve: Curves.easeOut);

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

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    _feedSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/45944777/losing-widget-state-when-switching-pages-in-a-flutter-pageview
    super.build(context);
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

  @override
  bool get wantKeepAlive => true;
}
