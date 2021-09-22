import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/display_utils.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

/// Displays the next 5 (max) scheduled workouts and events horizontally.
/// Scrollable forward / backward in time.
class ComingUpList extends StatelessWidget {
  double get kListHeight => 86.0;

  const ComingUpList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserScheduledWorkouts$Query, json.JsonSerializable>(
        key:
            Key('ComingUpList - ${UserScheduledWorkoutsQuery().operationName}'),
        query: UserScheduledWorkoutsQuery(),
        loadingIndicator: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShimmerCard(
            height: kListHeight + 8,
          ),
        ),
        builder: (data) {
          final comingUp = data.userScheduledWorkouts
              .sortedBy<DateTime>((s) => s.scheduledAt)
              .where((s) => s.scheduledAt.isAfter(DateTime.now()))
              .where((s) => s.workout != null)
              .take(5)
              .toList();

          final cardWidth = DisplayUtils.horizontalListItemWidth(
              context: context, targetWidth: 150, idealOverhang: 60);

          final bool noPlans = comingUp.isEmpty;

          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: noPlans
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                MyText(noPlans ? 'No plans?' : 'Up next...'),
                const SizedBox(height: 6),
                SizedBox(
                  height: kListHeight,
                  child: noPlans
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: SecondaryButton(
                                prefixIconData:
                                    CupertinoIcons.calendar_badge_plus,
                                text: 'Plan Something',
                                onPressed: () => context.navigateTo(
                                    YourScheduleRoute(
                                        openAtDate: DateTime.now())),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: comingUp.length,
                          itemBuilder: (c, i) {
                            return GestureDetector(
                              onTap: () => context.navigateTo(YourScheduleRoute(
                                  openAtDate: comingUp[i].scheduledAt)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ScheduledWorkoutReminderCard(
                                  scheduledWorkout: comingUp[i],
                                  cardWidth: cardWidth,
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
          );
        });
  }
}

class ScheduledWorkoutReminderCard extends StatelessWidget {
  final ScheduledWorkout scheduledWorkout;
  final double cardWidth;
  const ScheduledWorkoutReminderCard(
      {Key? key, required this.scheduledWorkout, required this.cardWidth})
      : super(key: key);

  BorderRadius get kBorderRadius => BorderRadius.circular(12);
  Radius get kRadius => const Radius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
          color: context.theme.primary.withOpacity(0.1),
          borderRadius: kBorderRadius),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: context.theme.primary,
                  borderRadius:
                      BorderRadius.only(topLeft: kRadius, topRight: kRadius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    scheduledWorkout.scheduledAt.isToday
                        ? 'Today'
                        : scheduledWorkout.scheduledAt.isTomorrow
                            ? 'Tomorrow'
                            : scheduledWorkout.scheduledAt.minimalDateString,
                    color: context.theme.background,
                    weight: FontWeight.bold,
                    lineHeight: 1.3,
                  ),
                  MyText(
                    scheduledWorkout.scheduledAt.timeString,
                    color: context.theme.background,
                    weight: FontWeight.bold,
                    lineHeight: 1.3,
                  ),
                ],
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    scheduledWorkout.workout!.name,
                    textAlign: TextAlign.center,
                    lineHeight: 1.3,
                  ),
                  if (scheduledWorkout.gymProfile != null)
                    MyText(
                      scheduledWorkout.gymProfile!.name,
                      textAlign: TextAlign.center,
                      color: Styles.colorTwo,
                      size: FONTSIZE.two,
                      lineHeight: 1.3,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
