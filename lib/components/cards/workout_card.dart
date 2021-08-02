import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final EdgeInsets padding;
  final bool showMoves;
  final bool showEquipment;
  final bool showTags;
  final bool showDescription;
  final bool hideBackgroundImage;
  final bool showCreatedBy;
  final bool showAccessScope;

  WorkoutCard(this.workout,
      {this.backgroundColor,
      this.withBoxShadow = true,
      this.showMoves = true,
      this.showEquipment = true,
      this.hideBackgroundImage = false,
      this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      this.showCreatedBy = true,
      this.showAccessScope = true,
      this.showTags = true,
      this.showDescription = true});

  final double cardHeight = 120;

  /// Either via .timecap if a non timed workout or via calculation if it is.
  int? _sectionDuration(WorkoutSection workoutSection) {
    if ([kHIITCircuitName, kTabataName, kEMOMName]
        .contains(workoutSection.workoutSectionType.name)) {
      return DataUtils.calculateTimedSectionDuration(workoutSection).inSeconds;
    } else {
      return workoutSection.timecap;
    }
  }

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
      backgroundImageUri: hideBackgroundImage ? null : workout.coverImageUri,
      backgroundColor: backgroundColor,
      withBoxShadow: withBoxShadow,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showCreatedBy || showAccessScope)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showCreatedBy)
                    MyText(
                      'By ${workout.user.displayName}',
                      textAlign: TextAlign.left,
                      size: FONTSIZE.TINY,
                      lineHeight: 1.4,
                    ),
                  if (showCreatedBy && showAccessScope)
                    MyText(
                      ' | ',
                      size: FONTSIZE.TINY,
                    ),
                  if (showAccessScope)
                    MyText(
                      workout.contentAccessScope.display,
                      textAlign: TextAlign.left,
                      size: FONTSIZE.TINY,
                      color: Styles.colorTwo,
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (workout.user.avatarUri != null)
                        UserAvatar(
                          avatarUri: workout.user.avatarUri!,
                          size: 34,
                          border: true,
                          borderWidth: 1,
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: MyText(
                            workout.name,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: DifficultyLevelTag(workout.difficultyLevel),
                )
              ],
            ),
          ),
          if (workout.workoutSections.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Wrap(spacing: 4, runSpacing: 4, children: [
                if (workout.lengthMinutes != null)
                  Container(
                    padding: kDefaultTagPadding,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: context.theme.background),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyText(
                          'Total: ',
                          textAlign: TextAlign.center,
                          size: FONTSIZE.SMALL,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Duration(minutes: workout.lengthMinutes!)
                              .display(fontSize: FONTSIZE.SMALL),
                        ),
                      ],
                    ),
                  ),
                ...workout.workoutSections
                    .sortedBy<num>((section) => section.sortPosition)
                    .map((section) => WorkoutSectionTypeTag(
                        Utils.textNotNull(section.name)
                            ? section.name!
                            : section.workoutSectionType.name,
                        hasClassVideo: Utils.textNotNull(section.classVideoUri),
                        hasClassAudio: Utils.textNotNull(section.classAudioUri),
                        timecap: _sectionDuration(section)))
                    .toList(),
              ]),
            ),
          if (showTags && _allTags.isNotEmpty)
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
          if (showDescription && Utils.textNotNull(workout.description))
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
                  maxLines: 3,
                  size: FONTSIZE.SMALL,
                  lineHeight: 1.3,
                ),
              ),
            ),
          if (showMoves && allMoves.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: allMoves
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
          if (showEquipment && allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: allEquipments
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

/// For generating an image via [screenshot] for use when sharing the workout.
class ShareWorkoutCardImage extends StatelessWidget {
  final Workout workout;

  ShareWorkoutCardImage(this.workout);

  @override
  Widget build(BuildContext context) {
    final deviceThemeIsDark =
        SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
    final textColor = deviceThemeIsDark ? Styles.white : Styles.black;
    final tagColor = deviceThemeIsDark ? Styles.black : Styles.white;
    final textStyle = TextStyle(color: textColor, fontSize: 18);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (Utils.textNotNull(workout.coverImageUri))
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedUploadcareImage(
                workout.coverImageUri!,
                displaySize: Size(200, 200),
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4))),
          padding: const EdgeInsets.all(12),
          child: Text(
            workout.name,
            style: textStyle,
          ),
        )
      ],
    );
  }
}
