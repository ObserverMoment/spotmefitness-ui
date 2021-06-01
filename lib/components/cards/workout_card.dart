import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final EdgeInsets padding;
  final bool showMoves;
  final bool showEquipment;
  final bool hideBackgroundImage;
  WorkoutCard(this.workout,
      {this.backgroundColor,
      this.withBoxShadow = true,
      this.showMoves = true,
      this.showEquipment = true,
      this.hideBackgroundImage = false,
      this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12)});

  final double cardHeight = 120;

  @override
  Widget build(BuildContext context) {
    final List<String> _allTags = [
      ...workout.workoutGoals.map((g) => g.name),
      ...workout.workoutTags.map((t) => t.tag)
    ];

    final Set<String> _allMoves = {};
    final Set<String> _allEquipments = {};

    for (final section in workout.workoutSections) {
      for (final workoutSet in section.workoutSets) {
        for (final workoutMove in workoutSet.workoutMoves) {
          if (workoutMove.move.id != kRestMoveId) {
            _allMoves.add(workoutMove.move.name);
          }
          if (workoutMove.equipment != null) {
            _allEquipments.add(workoutMove.equipment!.name);
          }
          if (workoutMove.move.requiredEquipments.isNotEmpty) {
            _allEquipments
                .addAll(workoutMove.move.requiredEquipments.map((e) => e.name));
          }
        }
      }
    }

    return Card(
      backgroundImageUri: hideBackgroundImage ? null : workout.coverImageUri,
      backgroundColor: backgroundColor,
      withBoxShadow: withBoxShadow,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  workout.name,
                  weight: FontWeight.bold,
                ),
                DifficultyLevelDot(workout.difficultyLevel)
              ],
            ),
          ),
          if (workout.workoutSections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: workout.workoutSections
                    .sortedBy<num>((section) => section.sortPosition)
                    .map((section) => WorkoutSectionTypeTag(
                        Utils.textNotNull(section.name)
                            ? section.name!
                            : section.workoutSectionType.name,
                        timecap: section.timecap))
                    .toList(),
              ),
            ),
          if (_allTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: _allTags
                    .map(
                      (tag) => Tag(
                        tag: tag,
                      ),
                    )
                    .toList(),
              ),
            ),
          if (Utils.textNotNull(workout.description))
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                  color: context.theme.background.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6),
                child: MyText(
                  workout.description!,
                  maxLines: 2,
                  size: FONTSIZE.SMALL,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          if (showMoves && _allMoves.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: _allMoves
                    .map(
                      (move) => Tag(
                        color: context.theme.background,
                        textColor: context.theme.primary,
                        tag: move,
                      ),
                    )
                    .toList(),
              ),
            ),
          if (showEquipment && _allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _allEquipments
                    .map(
                      (e) => Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: context.theme.background.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)),
                          width: 36,
                          height: 36,
                          child: Utils.getEquipmentIcon(context, e,
                              color: context.theme.primary)),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
