import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feed_utils.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:faye_dart/src/subscription.dart';
import 'package:collection/collection.dart';

/// Feed for the currently logged in User.
/// GetStream fees slug is [user_feed].
/// User posts go into this feed - other [user_timelines] can follow it.
class AuthedUserFeed extends StatefulWidget {
  final FlatFeed userFeed;
  const AuthedUserFeed({
    Key? key,
    required this.userFeed,
  }) : super(key: key);

  @override
  _AuthedUserFeedState createState() => _AuthedUserFeedState();
}

class _AuthedUserFeedState extends State<AuthedUserFeed>
    with AutomaticKeepAliveClientMixin<AuthedUserFeed> {
  bool _isLoading = true;

  late PagingController<int, ActivityWithObjectData> _pagingController;
  late ScrollController _scrollController;

  Subscription? _feedSubscription;

  /// GetStream uses integer offset for making api calls to get more activities when paginating.
  final int _postsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController<int, ActivityWithObjectData>(
        firstPageKey: 0, invisibleItemsThreshold: 5);
    _scrollController = ScrollController();

    _pagingController.addPageRequestListener((nextPageKey) {
      _getFeedPosts(offset: nextPageKey);
    });

    _loadInitialData().then((_) => _subscribeToFeed());
  }

  Future<void> _loadInitialData() async {
    await _getFeedPosts(offset: 0);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getFeedPosts({required int offset}) async {
    try {
      final feedActivities = await widget.userFeed
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
      _feedSubscription = await widget.userFeed.subscribe(_updateNewFeedPosts);
    } catch (e) {
      print(e);
      context.showToast(
          message: 'There was a problem, updates will not be received.');
    } finally {
      setState(() {});
    }
  }

  Future<void> _updateNewFeedPosts(RealtimeMessage? message) async {
    if (message?.newActivities != null && message!.newActivities.isNotEmpty) {
      final newActivitiesWithObjectData =
          await FeedUtils.getPostsUserAndObjectData(
              context,
              message.newActivities
                  .map((e) => FeedUtils.activityFromEnrichedActivity(e))
                  .toList());

      final sortedNewActivities = newActivitiesWithObjectData
          .sortedBy<DateTime>((a) => a.activity.time!);

      _scrollController.jumpTo(0.0);
      _pagingController.itemList = [
        ...sortedNewActivities,
        ..._pagingController.itemList ?? []
      ];
    }

    if (message?.deleted != null &&
        message!.deleted.isNotEmpty &&
        _pagingController.itemList != null &&
        _pagingController.itemList!.isNotEmpty) {
      _pagingController.itemList = _pagingController.itemList!
          .where((i) => !message.deleted.contains(i.activity.id))
          .toList();
    }
  }

  void _deleteActivityById(String id) =>
      FeedUtils.deleteActivityById(context, widget.userFeed, id);

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
    return _isLoading
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
                        deleteActivityById: _deleteActivityById,
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
              );
  }

  @override
  bool get wantKeepAlive => true;
}
