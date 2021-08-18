import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Followers of the currently logged in User.
/// i.e Details of other users [user_timelines] which are following this users [user_feed]
class AuthedUserFollowers extends StatelessWidget {
  final List<FollowWithUserAvatarData> followers;
  final bool isLoading;
  const AuthedUserFollowers({
    Key? key,
    required this.followers,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
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
            : GridView.count(
                padding: const EdgeInsets.all(8),
                childAspectRatio: 0.6,
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: followers
                    .map((f) => _UserFollower(
                          follower: f,
                        ))
                    .toList(),
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
          size: 80,
          border: true,
          borderWidth: 1,
          avatarUri: follower.userAvatarData?.avatarUri,
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: MyText(
            Utils.textNotNull(follower.userAvatarData?.displayName)
                ? follower.userAvatarData!.displayName
                : 'Unnamed',
            size: FONTSIZE.TINY,
          ),
        ),
      ],
    );
  }
}
