import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/cards/timeline_post_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_and_follows.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Feed for the currently logged in User.
/// GetStream fees slug is [user_feed].
/// User posts go into this feed - other [user_timelines] can follow it.
class AuthedUserFeed extends StatelessWidget {
  final List<ActivityWithObjectData> activitiesWithObjectData;
  final bool isLoading;
  final AsyncCallback refreshData;
  const AuthedUserFeed(
      {Key? key,
      required this.activitiesWithObjectData,
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
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: activitiesWithObjectData.length,
                  itemBuilder: (c, i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TimelinePostCard(
                            activityWithObjectData:
                                activitiesWithObjectData[i]),
                      )),
    );
  }
}
