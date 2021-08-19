import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// People that the current User is following.
/// i.e. Feeds that their [user_timeline] is following.
class AuthedUserFollowing extends StatelessWidget {
  final bool isLoading;
  final List<FollowWithUserAvatarData> following;
  const AuthedUserFollowing({
    Key? key,
    required this.isLoading,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
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
                    .map((f) => UserFollow(
                          follow: f,
                        ))
                    .toList(),
              );
  }
}
