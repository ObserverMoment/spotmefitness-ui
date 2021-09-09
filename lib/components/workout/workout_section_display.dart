import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_page_view.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutDetailsSection extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool scrollable;
  final bool showMediaThumbs;
  final bool showSectionTypeTag;
  WorkoutDetailsSection(this.workoutSection,
      {this.scrollable = false,
      this.showMediaThumbs = true,
      this.showSectionTypeTag = true});

  final Size _kthumbDisplaySize = Size(64, 64);

  Set<Equipment> _uniqueEquipments() =>
      workoutSection.workoutSets.fold({}, (acum1, workoutSet) {
        final Set<Equipment> setEquipments =
            workoutSet.workoutMoves.fold({}, (acum2, workoutMove) {
          if (workoutMove.equipment != null) {
            acum2.add(workoutMove.equipment!);
          }
          if (workoutMove.move.requiredEquipments.isNotEmpty) {
            acum2.addAll(workoutMove.move.requiredEquipments);
          }
          return acum2;
        });
        acum1.addAll(setEquipments);
        return acum1;
      });

  List<BodyAreaMoveScore> bodyAreaMoveScoresFromSection() {
    return workoutSection.workoutSets.fold(
        <BodyAreaMoveScore>[],
        (acum1, workoutSet) => [
              ...acum1,
              ...workoutSet.workoutMoves.fold(
                  <BodyAreaMoveScore>[],
                  (acum2, workoutMove) =>
                      [...acum2, ...workoutMove.move.bodyAreaMoveScores])
            ]);
  }

  @override
  Widget build(BuildContext context) {
    final List<Equipment> allEquipments = _uniqueEquipments()
        .where((e) => e.id != kBodyweightEquipmentId)
        .toList();
    final sortedSets =
        workoutSection.workoutSets.sortedBy<num>((ws) => ws.sortPosition);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showSectionTypeTag)
                  WorkoutSectionTypeTag(
                    workoutSection: workoutSection,
                    fontSize: FONTSIZE.MAIN,
                  ),
              ],
            ),
          ),
          SizedBox(height: 4),
          if (showMediaThumbs &&
              Utils.anyNotNull([
                workoutSection.introAudioUri,
                workoutSection.introVideoUri,
                workoutSection.classAudioUri,
                workoutSection.classVideoUri
              ]))
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (workoutSection.introVideoUri != null)
                    VideoThumbnailPlayer(
                        videoUri: workoutSection.introVideoUri,
                        videoThumbUri: workoutSection.introVideoThumbUri,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Intro'),
                  if (workoutSection.classVideoUri != null)
                    VideoThumbnailPlayer(
                        videoUri: workoutSection.classVideoUri,
                        videoThumbUri: workoutSection.classVideoThumbUri,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Class'),
                  if (workoutSection.introAudioUri != null)
                    AudioThumbnailPlayer(
                        audioUri: workoutSection.introAudioUri!,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Intro'),
                  if (workoutSection.classAudioUri != null)
                    AudioThumbnailPlayer(
                        audioUri: workoutSection.classAudioUri!,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Class'),
                ],
              ),
            ),
          if (allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 3),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 4,
                children: allEquipments
                    .map((e) => Tag(
                          tag: e.name,
                        ))
                    .toList(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (workoutSection.rounds > 1)
                  ContentBox(
                    child: NumberRoundsIcon(
                      workoutSection.rounds,
                      alignment: Axis.vertical,
                    ),
                  ),
                if (workoutSection.isAMRAP)
                  ContentBox(
                      child: CompactTimerIcon(
                          Duration(seconds: workoutSection.timecap))),
                BorderButton(
                  mini: true,
                  prefix: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/body_areas/body_button.svg',
                        width: 54,
                        alignment: Alignment.topCenter,
                        color: context.theme.primary.withOpacity(0.3),
                      ),
                      Icon(
                        CupertinoIcons.smallcircle_circle_fill,
                        color: Styles.infoBlue,
                        size: 30,
                      ),
                    ],
                  ),
                  withBorder: false,
                  onPressed: () => context.push(
                      child: TargetedBodyAreasPageView(
                          bodyAreaMoveScoresFromSection()),
                      fullscreenDialog: true),
                ),
              ],
            ),
          ),
          if (Utils.textNotNull(workoutSection.note))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ViewMoreFullScreenTextBlock(
                  text: workoutSection.note!,
                  title: 'Section Note',
                  textAlign: TextAlign.center),
            ),
          if (sortedSets.isNotEmpty)
            Flexible(
              child: ListView(
                physics: scrollable ? null : NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: sortedSets
                    .map((workoutSet) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: WorkoutSetDisplay(
                              workoutSet: workoutSet,
                              workoutSectionType:
                                  workoutSection.workoutSectionType),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
