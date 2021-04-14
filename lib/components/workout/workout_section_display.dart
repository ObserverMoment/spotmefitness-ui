import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_page_view.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_set_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutDetailsSection extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool scrollable;
  WorkoutDetailsSection(this.workoutSection, {this.scrollable = false});

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
                      [...acum2, ...workoutMove.move.bodyAreaMoveScores ?? []])
            ]);
  }

  @override
  Widget build(BuildContext context) {
    final Set<Equipment> allEquipments = _uniqueEquipments();
    final sortedSets =
        workoutSection.workoutSets.sortedBy<num>((ws) => ws.sortPosition);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (Utils.textNotNull(workoutSection.note))
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context.push(
                          child: TextViewer(workoutSection.note!, 'Note'),
                          fullscreenDialog: true),
                      child: Icon(CupertinoIcons.doc_text_search)),
                WorkoutSectionTypeTag(workoutSection.workoutSectionType.name,
                    timecap: workoutSection.timecap),
                MiniButton(
                  prefix: SvgPicture.asset(
                    'assets/body_areas/full_front.svg',
                    width: 28,
                    alignment: Alignment.topCenter,
                    height: 20,
                    fit: BoxFit.fitWidth,
                    color: context.theme.background,
                  ),
                  text: 'Body',
                  onPressed: () => context.push(
                      child: CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                              middle: NavBarTitle('Targeted Body Areas')),
                          child: TargetedBodyAreasPageView(
                              bodyAreaMoveScoresFromSection())),
                      fullscreenDialog: true),
                ),
              ],
            ),
          ),
          if (allEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
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
          if (workoutSection.rounds > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberRoundsIcon(workoutSection.rounds),
                ],
              ),
            ),
          if (Utils.anyNotNull([
            workoutSection.introAudioUri,
            workoutSection.introVideoUri,
            workoutSection.classAudioUri,
            workoutSection.classVideoUri
          ]))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (workoutSection.introAudioUri != null) MyText('Intro Audio'),
                if (workoutSection.classAudioUri != null) MyText('Class Audio'),
                if (workoutSection.introVideoUri != null) MyText('Intro Video'),
                if (workoutSection.classVideoUri != null) MyText('Class Video'),
              ],
            ),
          ListView.builder(
              physics: scrollable ? null : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedSets.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: WorkoutSetDisplay(sortedSets[index]),
                  ))
        ],
      ),
    );
  }
}
