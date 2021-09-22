import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/social/feeds_and_follows/feed_utils.dart';
import 'package:sofie_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:sofie_ui/components/social/feeds_and_follows/model.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/model/enum.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:stream_feed/stream_feed.dart';

/// People that the current User is following.
/// i.e. Feeds that their [user_timeline] is following.
class AuthedUserFollowing extends StatefulWidget {
  final FlatFeed timelineFeed;
  const AuthedUserFollowing({
    Key? key,
    required this.timelineFeed,
  }) : super(key: key);

  @override
  _AuthedUserFollowingState createState() => _AuthedUserFollowingState();
}

class _AuthedUserFollowingState extends State<AuthedUserFollowing> {
  bool _isLoading = true;

  /// List of feeds [user_feeds] which are being followed by this [user_timeline]
  List<FollowWithUserAvatarData> _following = <FollowWithUserAvatarData>[];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final timelineFollowing = await widget.timelineFeed.following();
      final userIds =
          timelineFollowing.map((f) => f.targetId.split(':')[1]).toList();

      _following = await FeedUtils.getFollowsWithUserData(
          context, timelineFollowing, userIds);
    } catch (e) {
      printLog(e.toString());
      context.showToast(
          message: 'Sorry there was a problem loading your follows.',
          toastType: ToastType.destructive);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const ShimmerCirclesGrid()
        : _following.isEmpty
            ? ListView(
                shrinkWrap: true,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(
                      child: MyText(
                        'No following anyone yet..',
                        size: FONTSIZE.four,
                        subtext: true,
                      ),
                    ),
                  )
                ],
              )
            : GridView.count(
                padding: const EdgeInsets.all(8),
                childAspectRatio: 0.9,
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 6,
                crossAxisSpacing: 20,
                children: [
                  FollowTotalAvatar(
                    total: _following.length,
                    label: 'Following',
                  ),
                  ..._following
                      .map((f) => UserFollow(
                            follow: f,
                          ))
                      .toList()
                ],
              );
  }
}
