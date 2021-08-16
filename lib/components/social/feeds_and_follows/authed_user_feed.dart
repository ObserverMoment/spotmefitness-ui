import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Feed for the currently logged in User.
/// GetStream fees slug is [user_feed].
/// User posts go into this feed - other [user_timelines] can follow it.
class AuthedUserFeed extends StatelessWidget {
  final List<Activity> activities;
  final bool isLoading;
  final AsyncCallback refreshData;
  const AuthedUserFeed(
      {Key? key,
      required this.activities,
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
          : activities.isEmpty
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
                  itemCount: activities.length,
                  itemBuilder: (c, i) =>
                      _UserFeedEntry(activity: activities[i])),
    );
  }
}

/// Displays the post and also UI for user to CRUD.
class _UserFeedEntry extends StatelessWidget {
  final Activity activity;
  const _UserFeedEntry({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(activity.actor.toString()),
    );
  }
}
