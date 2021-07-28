import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class StreakAndStatsSummary extends StatelessWidget {
  const StreakAndStatsSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query =
        UserLoggedWorkoutsQuery(variables: UserLoggedWorkoutsArguments());

    return QueryObserver<UserLoggedWorkouts$Query, json.JsonSerializable>(
        key: Key('StreakAndStatsSummary - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerCard(),
        builder: (data) {
          return ContentBox(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreakDisplay(
                    loggedWorkouts: data.userLoggedWorkouts,
                  ),
                  SizedBox(width: 12),
                  RecentLogDots(
                    loggedWorkouts: data.userLoggedWorkouts,
                  ),
                ],
              ));
        });
  }
}

/// For the last 14 days - is there a loggedWorkout on that day. If there is then fill the dot.
class RecentLogDots extends StatelessWidget {
  final List<LoggedWorkout> loggedWorkouts;
  const RecentLogDots({Key? key, required this.loggedWorkouts})
      : super(key: key);

  DateTime _getDateXDaysAgo(DateTime now, int days) {
    return DateTime(now.year, now.month, now.day - days);
  }

  Widget _buildRow(
      BuildContext context,
      double dotSize,
      Map<DateTime, List<LoggedWorkout>> logsByDay,
      DateTime now,
      int startDaysAgo) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              7,
              (i) => Container(
                    height: dotSize,
                    width: dotSize,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: logsByDay[_getDateXDaysAgo(
                                  now, startDaysAgo - i - 1)] !=
                              null
                          ? Styles.peachRed
                          : context.theme.primary.withOpacity(0.1),
                    ),
                  ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Needs improvement if we are to make this responsive.
    final dotSize = MediaQuery.of(context).size.width / 22;

    final now = DateTime.now();

    final logsByDay = loggedWorkouts
        .where((l) =>
            l.completedOn.isAfter(DateTime(now.year, now.month, now.day - 27)))
        .groupListsBy((l) => DateTime(
            l.completedOn.year, l.completedOn.month, l.completedOn.day));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRow(context, dotSize, logsByDay, now, 28),
        _buildRow(context, dotSize, logsByDay, now, 21),
        _buildRow(context, dotSize, logsByDay, now, 14),
        _buildRow(context, dotSize, logsByDay, now, 7),
        SizedBox(height: 10),
        MyText(
          '${logsByDay.keys.length} workout days in the last 28',
          size: FONTSIZE.TINY,
          maxLines: 2,
          weight: FontWeight.bold,
        )
      ],
    );
  }
}

class _StreakCalcData {
  // used during the calculation. Increments while counting then resets to zero.
  int streak = 0;
  int current = 0;
  int longest = 0;
  // Once the initial streak - starting yesterday - is completed, mark this as true.
  bool currentDone = false;
}

class StreakDisplay extends StatelessWidget {
  final List<LoggedWorkout> loggedWorkouts;
  const StreakDisplay({Key? key, required this.loggedWorkouts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final logsByDay = loggedWorkouts.groupListsBy((l) =>
        DateTime(l.completedOn.year, l.completedOn.month, l.completedOn.day));

    final bool hasWorkedoutToday =
        logsByDay[DateTime(now.year, now.month, now.day)] != null;

    final earliestLogDate = logsByDay.keys.sortedBy<DateTime>((k) => k).first;
    final dayBeforeEarlistLogDate = DateTime(
        earliestLogDate.year, earliestLogDate.month, earliestLogDate.day - 1);

    _StreakCalcData streakData = _StreakCalcData();

    int daysPast = hasWorkedoutToday
        ? 0
        : -1; // Start at yesterday, unless they have logged a workout today.
    DateTime day = DateTime(now.year, now.month, now.day + daysPast);

    while (day.isAfter(dayBeforeEarlistLogDate)) {
      if (logsByDay[day] != null) {
        streakData.streak++;
      } else {
        // The streak has ended.
        // Check if this is the end of the most recent streak starting yesterday.
        if (!streakData.currentDone) {
          streakData.current = streakData.streak;
          streakData.currentDone = true;
        }
        // Check if this is the longest streak we have found so far.
        if (streakData.streak > streakData.longest) {
          streakData.longest = streakData.streak;
        }

        // Reset the streak counter.
        streakData.streak = 0;
      }

      /// Move another day into the past.
      daysPast--;
      day = DateTime(now.year, now.month, now.day + daysPast);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyText(
          'STREAK',
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: SvgPicture.asset(
            'assets/progress_page_images/streak_icon.svg',
            width: 44,
          ),
        ),
        MyText(
          streakData.current.toString(),
          size: FONTSIZE.DISPLAY,
        ),
        MyText(
          '(days in a row)',
          size: FONTSIZE.TINY,
          subtext: true,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            MyText(
              'LONGEST: ',
              size: FONTSIZE.SMALL,
            ),
            MyText(
              streakData.longest.toString(),
            ),
          ],
        ),
      ],
    );
  }
}
