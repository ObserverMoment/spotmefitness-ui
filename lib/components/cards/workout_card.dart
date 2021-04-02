import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutSummary workout;
  WorkoutCard({required this.workout});

  final double cardHeight = 120;

  Widget buildTag() {
    return Tag(tag: 'text');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> allTags = [
      ...workout.workoutGoals.map((g) => g.name),
      ...workout.workoutTags.map((t) => t.tag)
    ];

    late Set<String> allMoves = {};
    late Set<String> allEquipments = {};

    for (final section in workout.workoutSections) {
      for (final workoutSet in section.workoutSets) {
        for (final workoutMove in workoutSet.workoutMoves) {
          allMoves.add(workoutMove.move.name);
          if (workoutMove.selectedEquipment != null) {
            allEquipments.add(workoutMove.selectedEquipment!.name);
          }
          if (workoutMove.move.requiredEquipments.isNotEmpty) {
            allEquipments
                .addAll(workoutMove.move.requiredEquipments.map((e) => e.name));
          }
        }
      }
    }

    return Card(
      backgroundImageUri: workout.coverImageUri,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                workout.name,
                weight: FontWeight.bold,
              ),
              DifficultyLevelDot(workout.difficultyLevel)
            ],
          ),
          if (workout.workoutSections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: workout.workoutSections.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: WorkoutSectionTypeTag(
                              workout.workoutSections[index].workoutSectionType
                                  .name,
                              timecap: workout.workoutSections[index].timecap),
                        )),
              ),
            ),
          if (allTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allTags.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 2),
                          child: Tag(
                            tag: allTags[index],
                          ),
                        )),
              ),
            ),
          if (workout.description != null && workout.description != '')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: MyText(
                workout.description!,
                maxLines: 2,
              ),
            ),
          if (allMoves.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allMoves.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 2),
                          child: Tag(
                            color: context.theme.background,
                            textColor: context.theme.primary,
                            tag: allMoves.elementAt(index),
                          ),
                        )),
              ),
            ),
          if (allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 3.0, bottom: 2),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allEquipments.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 2),
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Utils.getEquipmentIcon(
                                  context, allEquipments.elementAt(index),
                                  color:
                                      context.theme.primary.withOpacity(0.8))),
                        )),
              ),
            ),
        ],
      ),
    );
  }
}
