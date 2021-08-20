import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Timeline for the currently logged in User.
/// GetStream fees slug is [user_timeline].
/// A [user_timeline] follows many [user_feeds].
class AuthedUserTimeline extends StatelessWidget {
  final List<ActivityWithObjectData> activitiesWithObjectData;
  final bool isLoading;
  const AuthedUserTimeline({
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
