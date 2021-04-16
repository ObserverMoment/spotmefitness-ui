import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_section_creator.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutCreatorStructure extends StatelessWidget {
  void _openCreateSection(BuildContext context) {
    final bloc = context.read<WorkoutCreatorBloc>();
    // Create a default section as a placeholder until user selects the type.
    bloc.createWorkoutSection(WorkoutSectionType()
      ..id = 0.toString()
      ..name = 'Section'
      ..description = '');

    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: bloc,
          child: WorkoutSectionCreator(
            key: Key((bloc.workoutData.workoutSections.length - 1).toString()),
            sectionIndex: bloc.workoutData.workoutSections.length - 1,
            isCreate: true,
          ),
        ),
      ),
    );
  }

  void _openEditSection(BuildContext context, int sectionIndex) {
    final bloc = context.read<WorkoutCreatorBloc>();

    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: bloc,
          child: WorkoutSectionCreator(
              key: Key(sectionIndex.toString()), sectionIndex: sectionIndex),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutData = context.watch<WorkoutCreatorBloc>().workoutData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: workoutData.workoutSections.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () => _openEditSection(context, index),
                    child: WorkoutSectionInWorkout(
                        workoutSection: workoutData.workoutSections[index]),
                  )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                text: 'Add Section',
                onPressed: () => _openCreateSection(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionMovesEquipmentsBodyAreas {
  final Set<String> moves;
  final Set<String> equipments;
  final Set<String> bodyAreas;
  _SectionMovesEquipmentsBodyAreas(this.moves, this.equipments, this.bodyAreas);
}

class WorkoutSectionInWorkout extends StatelessWidget {
  final WorkoutSection workoutSection;
  WorkoutSectionInWorkout({required this.workoutSection});

  /// Creates a list of all move names and equipment names in the workout without any duplicates.
  _SectionMovesEquipmentsBodyAreas _getMovesAndEquipments() {
    final Set<String> allMoves = {};
    final Set<String> allEquipments = {};
    final Set<String> allBodyAreas = {};

    for (final workoutSet in workoutSection.workoutSets) {
      for (final workoutMove in workoutSet.workoutMoves) {
        allMoves.add(workoutMove.move.name);
        allBodyAreas.addAll(workoutMove.move.bodyAreaMoveScores
            .map((bams) => bams.bodyArea.name));
        if (workoutMove.equipment != null) {
          allEquipments.add(workoutMove.equipment!.name);
        }
        if (workoutMove.move.requiredEquipments.isNotEmpty) {
          allEquipments
              .addAll(workoutMove.move.requiredEquipments.map((e) => e.name));
        }
      }
    }
    return _SectionMovesEquipmentsBodyAreas(
        allMoves, allEquipments, allBodyAreas);
  }

  @override
  Widget build(BuildContext context) {
    final data = _getMovesAndEquipments();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styles.colorOne,
                        ),
                        child: MyText(
                          '${workoutSection.sortPosition + 1}',
                          weight: FontWeight.bold,
                          color: Styles.white,
                        )),
                    Expanded(
                      child: MyText(
                        Utils.textNotNull(workoutSection.name)
                            ? workoutSection.name!
                            : 'Section ${workoutSection.sortPosition + 1}',
                        weight: FontWeight.bold,
                      ),
                    ),
                    if (Utils.textNotNull(workoutSection.note))
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: NotesIcon(),
                          onPressed: () => context.showBottomSheet(
                              expand: true,
                              child: TextViewer(
                                  workoutSection.note!, 'Section Note')))
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 14,
                runSpacing: 14,
                children: [
                  WorkoutSectionTypeTag(
                    workoutSection.workoutSectionType.name,
                    timecap: workoutSection.timecap,
                  ),
                  ...data.moves
                      .map((m) => Tag(
                            color: context.theme.background,
                            textColor: context.theme.primary,
                            tag: m,
                            fontSize: FONTSIZE.SMALL,
                          ))
                      .toList(),
                  ...data.equipments
                      .map((e) => SizedBox(
                          width: 26,
                          height: 26,
                          child: Utils.getEquipmentIcon(context, e,
                              color: context.theme.primary.withOpacity(0.8))))
                      .toList(),
                  ...data.bodyAreas
                      .map((ba) => RoundedBox(child: MyText(ba)))
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
