import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/display_utils.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Displays the next 5 (max) scheduled workouts and events horizontally.
/// Scrollable forward / backward in time.
class ComingUpList extends StatelessWidget {
  final kListHeight = 86.0;
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserScheduledWorkouts$Query, json.JsonSerializable>(
        key:
            Key('ComingUpList - ${UserScheduledWorkoutsQuery().operationName}'),
        query: UserScheduledWorkoutsQuery(),
        loadingIndicator: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShimmerCard(
            height: kListHeight + 14,
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
                SizedBox(height: 6),
                SizedBox(
                  height: kListHeight,
                  child: noPlans
                      ? ContentBox(
                          child: BorderButton(
                              withBorder: false,
                              mini: true,
                              prefix: Icon(CupertinoIcons.calendar_badge_plus),
                              text: 'Plan Something',
                              onPressed: () =>
                                  print('schedule something flow')),
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
  ScheduledWorkoutReminderCard(
      {required this.scheduledWorkout, required this.cardWidth});

  final kBorderRadius = BorderRadius.circular(12);
  final kRadius = Radius.circular(12);

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
                  ),
                  MyText(
                    scheduledWorkout.scheduledAt.timeString,
                    color: context.theme.background,
                    weight: FontWeight.bold,
                  ),
                ],
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    scheduledWorkout.workout!.name,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  if (scheduledWorkout.gymProfile != null)
                    MyText(
                      scheduledWorkout.gymProfile!.name,
                      textAlign: TextAlign.center,
                      color: Styles.colorTwo,
                      size: FONTSIZE.SMALL,
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
