import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Based on the number of weeks in the workout plan, displays a grid of days to choose from.
/// Initially built so user can select a day when they want to move or copy a current WorkoutPlanDay to a different day number.
/// Will display an icon on any days that already have workoutPlanDays on them.
class WorkoutPlanDaySelector extends StatelessWidget {
  final String title;
  final String message;

  /// Disable click on this day.
  final int? prevSelectedDay;
  final WorkoutPlan workoutPlan;
  final void Function(int dayNumber) selectDayNumber;
  const WorkoutPlanDaySelector(
      {Key? key,
      required this.title,
      required this.message,
      required this.workoutPlan,
      required this.selectDayNumber,
      this.prevSelectedDay})
      : super(key: key);

  final kWeekRowPadding = 12.0;
  final kDayItemMargin = 2.0;

  int dayNumberFromIndexes(int weekIndex, int dayIndex) =>
      (weekIndex * 7) + dayIndex;

  void _handleSelectDayNumber(BuildContext context,
      List<int> daysWithWorkoutsPlanned, int weekIndex, int dayIndex) {
    final dayNumber = dayNumberFromIndexes(weekIndex, dayIndex);

    /// If day has stuff on it then check with them they mean to do this.
    if (daysWithWorkoutsPlanned
        .contains(dayNumberFromIndexes(weekIndex, dayIndex))) {
      context.showConfirmDialog(
          title: 'Workouts Planned',
          content: MyText(
            'The planned workouts on week ${weekIndex + 1} day ${dayIndex + 1} will be overwritten. OK?',
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
          onConfirm: () => _selectDayNumber(context, dayNumber));
    } else {
      _selectDayNumber(context, dayNumber);
    }
  }

  void _selectDayNumber(BuildContext context, int dayNumber) {
    selectDayNumber(dayNumber);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final daysWithWorkoutsPlanned = workoutPlan.workoutPlanDays
        .fold<List<int>>([], (acum, next) => [...acum, next.dayNumber]);

    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        middle: NavBarTitle(title),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: MyText(
              message,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Dot(
                  diameter: 12,
                  color: Styles.infoBlue,
                ),
                SizedBox(width: 6),
                MyText('Has workout planned')
              ],
            ),
          ),
          LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: workoutPlan.lengthWeeks,
                  itemBuilder: (c, weekIndex) {
                    final dayItemWidth =
                        (constraints.maxWidth - (kWeekRowPadding * 2)) / 7;

                    return Column(
                      children: [
                        H3('Week ${weekIndex + 1}'),
                        Padding(
                          padding: EdgeInsets.all(kWeekRowPadding),
                          child: Row(
                            children: List.generate(7, (dayIndex) {
                              final sameAsPrevSelected = prevSelectedDay ==
                                  dayNumberFromIndexes(weekIndex, dayIndex);

                              return GestureDetector(
                                onTap: () => !sameAsPrevSelected
                                    ? _handleSelectDayNumber(
                                        context,
                                        daysWithWorkoutsPlanned,
                                        weekIndex,
                                        dayIndex)
                                    : null,
                                child: Opacity(
                                  opacity: sameAsPrevSelected ? 0.3 : 1,
                                  child: Container(
                                    margin: EdgeInsets.all(kDayItemMargin),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: context.theme.primary)),
                                    alignment: Alignment.center,
                                    width: dayItemWidth - (kDayItemMargin * 2),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        if (daysWithWorkoutsPlanned.contains(
                                            dayNumberFromIndexes(
                                                weekIndex, dayIndex)))
                                          Dot(
                                            diameter: 30,
                                            color: Styles.infoBlue,
                                          ),
                                        MyText(
                                          '${dayIndex + 1}',
                                          weight: FontWeight.bold,
                                          lineHeight: 1.2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
