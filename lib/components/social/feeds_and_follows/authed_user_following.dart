import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_and_follows.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// People that the current User is following.
/// i.e. Feeds that their [user_timeline] is following.
class AuthedUserFollowing extends StatelessWidget {
  final bool isLoading;
  final List<FollowWithUserAvatarData> following;
  final AsyncCallback refreshData;
  const AuthedUserFollowing(
      {Key? key,
      required this.isLoading,
      required this.following,
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
            : following.isEmpty
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: MyText(
                            'No following anyone yet..',
                            size: FONTSIZE.BIG,
                            subtext: true,
                          ),
                        ),
                      )
                    ],
                  )
                : GridView.count(
                    padding: const EdgeInsets.all(8),
                    childAspectRatio: 0.6,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: following
                        .map((f) => _UserFollowing(
                              following: f,
                            ))
                        .toList(),
                  ));
  }
}

/// Displays a single follower of a feed.
class _UserFollowing extends StatelessWidget {
  final FollowWithUserAvatarData following;
  const _UserFollowing({Key? key, required this.following}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAvatar(
          size: 80,
          border: true,
          borderWidth: 1,
          avatarUri: following.userAvatarData?.avatarUri,
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: MyText(
            Utils.textNotNull(following.userAvatarData?.displayName)
                ? following.userAvatarData!.displayName!
                : 'Unnamed',
            size: FONTSIZE.TINY,
          ),
        ),
      ],
    );
  }
}
