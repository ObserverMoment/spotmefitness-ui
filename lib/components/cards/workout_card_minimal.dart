import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/media/images/user_avatar.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/utils.dart';

/// No background image and more compact - for displaying in a plan schedule list.
/// Title and equipment are on the top - tags on the bottom.
class MinimalWorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final EdgeInsets padding;

  const MinimalWorkoutCard(
    this.workout, {
    Key? key,
    this.backgroundColor,
    this.withBoxShadow = true,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> allTags = [
      ...workout.workoutGoals.map((g) => g.name),
      ...workout.workoutTags.map((t) => t.tag)
    ];

    final Set<String> allMoves = {};
    final Set<String> allEquipments = {};

    for (final section in workout.workoutSections) {
      for (final workoutSet in section.workoutSets) {
        for (final workoutMove in workoutSet.workoutMoves) {
          if (workoutMove.move.id != kRestMoveId) {
            allMoves.add(workoutMove.move.name);
          }
          if (workoutMove.equipment != null) {
            allEquipments.add(workoutMove.equipment!.name);
          }
          if (workoutMove.move.requiredEquipments.isNotEmpty) {
            allEquipments
                .addAll(workoutMove.move.requiredEquipments.map((e) => e.name));
          }
        }
      }
    }

    return Card(
      backgroundColor: backgroundColor,
      withBoxShadow: withBoxShadow,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (workout.user.avatarUri != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: UserAvatar(
                          avatarUri: workout.user.avatarUri,
                          size: 38,
                        ),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyHeaderText(
                            workout.name,
                            maxLines: 2,
                            lineHeight: 1.3,
                          ),
                          MyText(
                            'By ${workout.user.displayName}',
                            size: FONTSIZE.one,
                            lineHeight: 1.4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (workout.workoutSections.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: allEquipments
                          .map(
                            (e) => Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: context.theme.cardBackground,
                                    borderRadius: BorderRadius.circular(30)),
                                width: 34,
                                height: 34,
                                child: Utils.getEquipmentIcon(context, e,
                                    color: context.theme.primary)),
                          )
                          .toList(),
                    ),
                  )
              ],
            ),
          ),
          Container(
              decoration:
                  BoxDecoration(color: context.theme.primary.withOpacity(0.6)),
              height: 2),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (workout.lengthMinutes != null)
                  DurationTag(
                    duration: Duration(minutes: workout.lengthMinutes!),
                    backgroundColor: Styles.infoBlue,
                    textColor: Styles.white,
                  ),
                DifficultyLevelTag(
                  difficultyLevel: workout.difficultyLevel,
                  fontSize: FONTSIZE.one,
                ),
                if (workout.workoutSections.isNotEmpty)
                  ...workout.workoutSections
                      .sortedBy<num>((section) => section.sortPosition)
                      .map((section) => WorkoutSectionTypeTag(
                            workoutSection: section,
                            fontSize: FONTSIZE.one,
                          ))
                      .toList(),
                if (allTags.isNotEmpty)
                  ...allTags
                      .map((t) => Tag(
                            tag: t,
                          ))
                      .toList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
