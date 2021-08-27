import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/club_timeline_post_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/model/enum.dart';

/// NOTE: Logic in this widget is simlar to that in [AuthedUserTimeline] in [FeedsAndFollows]. Except there is no sharing of posts to club feeds - they are club specific. Plus we may add some additional functionality - such as comments / threads to timeline posts here.
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
  bool _isLoading = true;
  late PagingController<int, TimelinePostFullData> _pagingController;
  late ScrollController _scrollController;

  /// GetStream uses integer offset for making api calls to get more activities when paginating.
  final int _postsPerPage = 10;

  @override
  void initState() {
    super.initState();

    _loadInitialData();

    _pagingController = PagingController<int, TimelinePostFullData>(
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
      final result = await context.graphQLStore.networkOnlyOperation<
              ClubMembersFeedPosts$Query, ClubMembersFeedPostsArguments>(
          operation: ClubMembersFeedPostsQuery(
              variables: ClubMembersFeedPostsArguments(
                  clubId: widget.club.id,
                  limit: _postsPerPage,
                  offset: offset)));

      if (result.hasErrors || result.data == null) {
        throw Exception(result.errors);
      } else {
        final newPosts = result.data!.clubMembersFeedPosts;
        final int numPostsBefore = _pagingController.itemList?.length ?? 0;
        final int numNewPosts = newPosts.length;

        if (newPosts.length < _postsPerPage) {
          _pagingController.appendLastPage(newPosts);
        } else {
          _pagingController.appendPage(newPosts, numPostsBefore + numNewPosts);
        }
      }
    } catch (e) {
      print(e.toString());
      _pagingController.error = e.toString();
      context.showToast(
          message: 'Sorry there was a problem loading your posts.',
          toastType: ToastType.destructive);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
            : PagedListView<int, TimelinePostFullData>(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                pagingController: _pagingController,
                scrollController: _scrollController,
                // Scrolling being handled in parent.
                physics: NeverScrollableScrollPhysics(),
                builderDelegate:
                    PagedChildBuilderDelegate<TimelinePostFullData>(
                  itemBuilder: (context, postData, index) => SizeFadeIn(
                    duration: 50,
                    delay: index,
                    delayBasis: 10,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ClubTimelinePostCard(postData: postData)),
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
}
