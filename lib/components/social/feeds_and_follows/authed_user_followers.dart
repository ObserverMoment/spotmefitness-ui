import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feed_utils.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Followers of the currently logged in User.
/// i.e Details of other users [user_timelines] which are following this users [user_feed]
class AuthedUserFollowers extends StatefulWidget {
  final FlatFeed userFeed;
  const AuthedUserFollowers({
    Key? key,
    required this.userFeed,
  }) : super(key: key);

  @override
  _AuthedUserFollowersState createState() => _AuthedUserFollowersState();
}

class _AuthedUserFollowersState extends State<AuthedUserFollowers>
    with AutomaticKeepAliveClientMixin<AuthedUserFollowers> {
  bool _isLoading = true;

  // /// List of followers [user_timelines] which are following this [user_feed]
  List<FollowWithUserAvatarData> _followers = <FollowWithUserAvatarData>[];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final followers = await widget.userFeed.followers();
      final userIds = followers.map((f) => f.feedId.split(':')[1]).toList();

      _followers =
          await FeedUtils.getFollowsWithUserData(context, followers, userIds);
    } catch (e) {
      print(e.toString());
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
    // https://stackoverflow.com/questions/45944777/losing-widget-state-when-switching-pages-in-a-flutter-pageview
    super.build(context);
    return _isLoading
        ? ShimmerCirclesGrid()
        : _followers.isEmpty
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: MyText(
                        'No followers yet..',
                        size: FONTSIZE.BIG,
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
                    total: _followers.length,
                    label: 'Followers',
                  ),
                  ..._followers
                      .map((f) => UserFollow(
                            follow: f,
                          ))
                      .toList()
                ],
              );
  }

  @override
  bool get wantKeepAlive => true;
}
