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
import 'package:collection/collection.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final Color? backgroundColor;
  final bool withBoxShadow;
  final EdgeInsets padding;

  WorkoutCard(
    this.workout, {
    this.backgroundColor,
    this.withBoxShadow = true,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

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
      backgroundColor: backgroundColor,
      withBoxShadow: withBoxShadow,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: SizedBox(
                height: 130,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    workout.coverImageUri != null
                        ? SizedUploadcareImage(workout.coverImageUri!)
                        : Image.asset(
                            'assets/home_page_images/home_page_workouts.jpg',
                            fit: BoxFit.cover,
                          ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.background.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DifficultyLevelTag(workout.difficultyLevel),
                              if (workout.lengthMinutes != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Card(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Duration(
                                              minutes: workout.lengthMinutes!)
                                          .display(
                                              fontSize: FONTSIZE.SMALL,
                                              bold: true),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )),
                    if (_allTags.isNotEmpty)
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                          )),
                  ],
                )),
          ),
          Container(
              decoration: BoxDecoration(color: context.theme.primary),
              height: 3),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (workout.user.avatarUri != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: UserAvatar(
                          avatarUri: workout.user.avatarUri!,
                          size: 34,
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyHeaderText(
                          workout.name,
                        ),
                        MyText(
                          'By ${workout.user.displayName}',
                          size: FONTSIZE.TINY,
                          lineHeight: 1.4,
                        ),
                      ],
                    ),
                  ],
                ),
                if (workout.workoutSections.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: workout.workoutSections
                            .sortedBy<num>((section) => section.sortPosition)
                            .map((section) => WorkoutSectionTypeTag(
                                Utils.textNotNull(section.name)
                                    ? section.name!
                                    : section.workoutSectionType.name,
                                hasClassVideo:
                                    Utils.textNotNull(section.classVideoUri),
                                hasClassAudio:
                                    Utils.textNotNull(section.classAudioUri),
                                timecap: _sectionDuration(section)))
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: allEquipments
                              .map(
                                (e) => Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: context.theme.background
                                            .withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    width: 32,
                                    height: 32,
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
