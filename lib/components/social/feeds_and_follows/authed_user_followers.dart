import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_and_follows.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Followers of the currently logged in User.
/// i.e Details of other users [user_timelines] which are following this users [user_feed]
class AuthedUserFollowers extends StatelessWidget {
  final List<FollowWithUserAvatarData> followers;
  final bool isLoading;
  final AsyncCallback refreshData;
  const AuthedUserFollowers(
      {Key? key,
      required this.followers,
      required this.isLoading,
      required this.refreshData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: 1,
      backgroundColor: context.theme.cardBackground,
      color: context.theme.primary,
      onRefresh: refreshData,
      child: isLoading
          ? LoadingCircle()
          : followers.isEmpty
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
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: followers.length,
                  itemBuilder: (c, i) => _UserFollower(follower: followers[i])),
    );
  }
}

/// Displays a single follower of a feed.
class _UserFollower extends StatelessWidget {
  final FollowWithUserAvatarData follower;
  const _UserFollower({Key? key, required this.follower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAvatar(
          size: 70,
          border: true,
          borderWidth: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: MyText(
            'Name',
            size: FONTSIZE.TINY,
          ),
        ),
      ],
    );
  }
}
