import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Feed for the currently logged in User.
/// GetStream fees slug is [user_feed].
/// User posts go into this feed - other [user_timelines] can follow it.
class AuthedUserFeed extends StatelessWidget {
  final List<ActivityWithObjectData> activitiesWithObjectData;
  final bool isLoading;
  const AuthedUserFeed({
    Key? key,
    required this.activitiesWithObjectData,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingCircle()
        : activitiesWithObjectData.isEmpty
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
            : TimelineFeedPostList(
                activitiesWithObjectData: activitiesWithObjectData,
              );
  }
}
