import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutSummary workoutSummary;
  WorkoutCard(this.workoutSummary);

  final double cardHeight = 120;

  Widget buildTag() {
    return Tag(tag: 'text');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _allTags = [
      ...workoutSummary.workoutGoals.map((g) => g.name),
      ...workoutSummary.workoutTags.map((t) => t.tag)
    ];

    late Set<String> _allMoves = {};
    late Set<String> _allEquipments = {};

    for (final section in workoutSummary.userWorkoutsWorkoutSections) {
      for (final workoutSet in section.userWorkoutsWorkoutSets) {
        for (final workoutMove in workoutSet.userWorkoutsWorkoutMoves) {
          _allMoves.add(workoutMove.userWorkoutsMove.name);
          if (workoutMove.equipment != null) {
            _allEquipments.add(workoutMove.equipment!.name);
          }
          if (workoutMove.userWorkoutsMove.requiredEquipments.isNotEmpty) {
            _allEquipments.addAll(workoutMove
                .userWorkoutsMove.requiredEquipments
                .map((e) => e.name));
          }
        }
      }
    }

    return Card(
      backgroundImageUri: workoutSummary.coverImageUri,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  workoutSummary.name,
                  weight: FontWeight.bold,
                ),
                DifficultyLevelDot(workoutSummary.difficultyLevel)
              ],
            ),
          ),
          if (workoutSummary.userWorkoutsWorkoutSections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 28,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        workoutSummary.userWorkoutsWorkoutSections.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: WorkoutSectionTypeTag(
                              workoutSummary.userWorkoutsWorkoutSections[index]
                                  .workoutSectionType.name,
                              timecap: workoutSummary
                                  .userWorkoutsWorkoutSections[index].timecap),
                        )),
              ),
            ),
          if (_allTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allTags.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 2),
                          child: Tag(
                            tag: _allTags[index],
                          ),
                        )),
              ),
            ),
          if (Utils.textNotNull(workoutSummary.description))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: MyText(
                workoutSummary.description!,
                maxLines: 2,
                size: FONTSIZE.SMALL,
              ),
            ),
          if (_allMoves.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allMoves.length,
                    itemBuilder: (context, index) => Tag(
                          color: context.theme.background,
                          textColor: context.theme.primary,
                          tag: _allMoves.elementAt(index),
                        )),
              ),
            ),
          if (_allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 7.0, bottom: 4),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allEquipments.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 2),
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Utils.getEquipmentIcon(
                                  context, _allEquipments.elementAt(index),
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
