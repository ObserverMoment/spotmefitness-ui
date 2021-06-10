import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';

class WorkoutPlanDayCard extends StatelessWidget {
  /// Can be either the abolute day = i.e. day 15 of the workout, or the relative day, i.e. day 2 or of the week.
  /// Zero indexed.
  final int displayDayNumber;
  final WorkoutPlanDay workoutPlanDay;
  final bool minimize;
  const WorkoutPlanDayCard(
      {Key? key,
      required this.workoutPlanDay,
      required this.displayDayNumber,
      this.minimize = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedWorkoutPlanDayWorkouts = workoutPlanDay.workoutPlanDayWorkouts
        .sortedBy<num>((d) => d.sortPosition)
        .toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H3(' Day ${displayDayNumber + 1}'),
          if (Utils.textNotNull(workoutPlanDay.note))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: MyText(
                workoutPlanDay.note!,
                subtext: true,
              ),
            ),
          SizedBox(height: 3),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedWorkoutPlanDayWorkouts.length,
              separatorBuilder: (c, i) => HorizontalLine(),
              itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Utils.textNotNull(
                            sortedWorkoutPlanDayWorkouts[i].note))
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: MyText(
                              sortedWorkoutPlanDayWorkouts[i].note!,
                              color: Styles.infoBlue,
                            ),
                          ),
                        WorkoutCard(
                          sortedWorkoutPlanDayWorkouts[i].workout,
                          withBoxShadow: false,
                          hideBackgroundImage: true,
                          padding: const EdgeInsets.all(0),
                          showCreatedBy: false,
                          showEquipment: !minimize,
                          showMoves: !minimize,
                          showTags: !minimize,
                          showDescription: !minimize,
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }
}

class WorkoutPlanRestDayCard extends StatelessWidget {
  /// Zero indexed.
  final int dayNumber;
  const WorkoutPlanRestDayCard({Key? key, required this.dayNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          H3(' Day ${dayNumber + 1}'),
          H3('Rest'),
        ],
      ),
    );
  }
}
