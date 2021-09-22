import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:sofie_ui/components/media/images/user_avatar.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/utils.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final EdgeInsets padding;

  const WorkoutCard(
    this.workout, {
    Key? key,
    this.backgroundColor,
    this.withBoxShadow = true,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _allTags = [
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
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(kCardBorderRadiusValue),
                topRight: Radius.circular(kCardBorderRadiusValue)),
            child: SizedBox(
                height: 130,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (workout.coverImageUri != null)
                      SizedUploadcareImage(workout.coverImageUri!)
                    else
                      Image.asset(
                        'assets/home_page_images/home_page_workouts.jpg',
                        fit: BoxFit.cover,
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.background.withOpacity(0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      workout.lengthMinutes != null
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.end,
                                  children: [
                                    if (workout.lengthMinutes != null)
                                      DurationTag(
                                        duration: Duration(
                                            minutes: workout.lengthMinutes!),
                                        backgroundColor: Styles.infoBlue,
                                        textColor: Styles.white,
                                      ),
                                    DifficultyLevelTag(
                                      difficultyLevel: workout.difficultyLevel,
                                      fontSize: FONTSIZE.one,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (_allTags.isNotEmpty)
                            SizedBox(
                              height: 30,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(left: 8),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: _allTags.length,
                                itemBuilder: (c, i) => Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Tag(
                                    tag: _allTags[i],
                                    color:
                                        context.theme.primary.withOpacity(0.95),
                                    textColor: context.theme.background,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Container(
              decoration:
                  BoxDecoration(color: context.theme.primary.withOpacity(0.75)),
              height: 2),
          Container(
            padding:
                const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 8),
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
                          size: 34,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 5,
                        runSpacing: 8,
                        children: workout.workoutSections
                            .sortedBy<num>((section) => section.sortPosition)
                            .map((section) => WorkoutSectionTypeTag(
                                  workoutSection: section,
                                ))
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: allEquipments
                              .map(
                                (e) => Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: context.theme.background,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    width: 30,
                                    height: 30,
                                    child: Utils.getEquipmentIcon(context, e,
                                        color: context.theme.primary)),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
