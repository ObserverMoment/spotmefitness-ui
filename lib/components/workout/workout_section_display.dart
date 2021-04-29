import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_page_view.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_instructions.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutDetailsSection extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool scrollable;
  WorkoutDetailsSection(this.workoutSection, {this.scrollable = false});

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
    final Set<Equipment> allEquipments = _uniqueEquipments();
    final sortedSets =
        workoutSection.workoutSets.sortedBy<num>((ws) => ws.sortPosition);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WorkoutSectionTypeTag(
            workoutSection.workoutSectionType.name,
            timecap: workoutSection.timecap,
            fontSize: FONTSIZE.MAIN,
          ),
          SizedBox(height: 4),
          if (Utils.anyNotNull([
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
                    .map((e) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: context.theme.cardBackground),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3),
                          child: MyText(
                            e.name,
                            size: FONTSIZE.SMALL,
                          ),
                        ))
                    .toList(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (workoutSection.rounds > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberRoundsIcon(workoutSection.rounds),
                    ],
                  ),
                MiniButton(
                  prefix: SvgPicture.asset(
                    'assets/body_areas/full_front.svg',
                    width: 50,
                    alignment: Alignment.topCenter,
                    height: 26,
                    fit: BoxFit.cover,
                    color: context.theme.primary,
                  ),
                  withBorder: false,
                  onPressed: () => context.push(
                      child: CupertinoPageScaffold(
                          navigationBar: BasicNavBar(
                              middle: NavBarTitle('Targeted Body Areas')),
                          child: TargetedBodyAreasPageView(
                              bodyAreaMoveScoresFromSection())),
                      fullscreenDialog: true),
                ),
                if (Utils.textNotNull(workoutSection.note))
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: NotesIcon(),
                      onPressed: () => context.showBottomSheet(
                          expand: true,
                          child: TextViewer(
                              workoutSection.note!, 'Section Note'))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
            child: WorkoutSectionInstructions(
              typeName: workoutSection.workoutSectionType.name,
              rounds: workoutSection.rounds,
              timecap: workoutSection.timecap,
            ),
          ),
          if (sortedSets.isNotEmpty)
            Flexible(
              child: ListView(
                physics: scrollable ? null : NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: sortedSets
                    .map((workoutSet) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
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
