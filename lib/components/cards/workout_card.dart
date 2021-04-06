import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/icons.dart';
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

    for (final section in workoutSummary.workoutSectionsWithoutMoveDetail) {
      for (final workoutSet in section.workoutSetsWithEquipmentOnly) {
        for (final workoutMove in workoutSet.workoutMovesWithEquipmentOnly) {
          _allMoves.add(workoutMove.moveWithEquipmentOnly.name);
          if (workoutMove.equipment != null) {
            _allEquipments.add(workoutMove.equipment!.name);
          }
          if (workoutMove.moveWithEquipmentOnly.requiredEquipments.isNotEmpty) {
            _allEquipments.addAll(workoutMove
                .moveWithEquipmentOnly.requiredEquipments
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                workoutSummary.name,
                weight: FontWeight.bold,
              ),
              DifficultyLevelDot(workoutSummary.difficultyLevel)
            ],
          ),
          if (workoutSummary.workoutSectionsWithoutMoveDetail.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        workoutSummary.workoutSectionsWithoutMoveDetail.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: WorkoutSectionTypeTag(
                              workoutSummary
                                  .workoutSectionsWithoutMoveDetail[index]
                                  .workoutSectionType
                                  .name,
                              timecap: workoutSummary
                                  .workoutSectionsWithoutMoveDetail[index]
                                  .timecap),
                        )),
              ),
            ),
          if (_allTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
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
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: MyText(
                workoutSummary.description!,
                maxLines: 2,
                size: FONTSIZE.SMALL,
              ),
            ),
          if (_allMoves.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: SizedBox(
                height: 24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allMoves.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 2),
                          child: Tag(
                            color: context.theme.background,
                            textColor: context.theme.primary,
                            tag: _allMoves.elementAt(index),
                          ),
                        )),
              ),
            ),
          if (_allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 3.0, bottom: 2),
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
