import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_section_creator.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutCreatorStructure extends StatefulWidget {
  @override
  _WorkoutCreatorStructureState createState() =>
      _WorkoutCreatorStructureState();
}

class _WorkoutCreatorStructureState extends State<WorkoutCreatorStructure> {
  late WorkoutCreatorBloc _bloc;
  late List<WorkoutSection> _sortedworkoutSections;

  void _checkForNewData() {
    final updated = _bloc.workout.workoutSections;

    if (!_sortedworkoutSections.equals(updated)) {
      setState(() {
        _sortedworkoutSections = [
          ...updated.sortedBy<num>((ws) => ws.sortPosition)
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();

    _sortedworkoutSections = [
      ..._bloc.workout.workoutSections.sortedBy<num>((ws) => ws.sortPosition)
    ];
    _bloc.addListener(_checkForNewData);
  }

  void _openCreateSection() async {
    final nextIndex = _sortedworkoutSections.length;
    // Create a default section as a placeholder until user selects the type.
    await _bloc
        .createWorkoutSection(DefaultObjectfactory.defaultWorkoutSectionType());

    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: _bloc,
          child: WorkoutSectionCreator(
            key: Key((nextIndex).toString()),
            sectionIndex: nextIndex,
            isCreate: true,
          ),
        ),
      ),
    );
  }

  void _openEditSection(int sectionIndex) {
    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: _bloc,
          child: WorkoutSectionCreator(
              key: Key(sectionIndex.toString()), sectionIndex: sectionIndex),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              ImplicitlyAnimatedList<WorkoutSection>(
                items: _sortedworkoutSections,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                areItemsTheSame: (a, b) => a.id == b.id,
                itemBuilder: (context, animation, item, index) {
                  return SizeFadeTransition(
                    sizeFraction: 0.7,
                    curve: Curves.easeInOut,
                    animation: animation,
                    child: GestureDetector(
                      onTap: () => _openEditSection(index),
                      child: WorkoutSectionInWorkout(
                        key: Key(item.id),
                        workoutSection: item,
                        index: index,
                        canReorder: _sortedworkoutSections.length > 1,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CreateTextIconButton(
                      text: 'Add Section',
                      loading: context.select<WorkoutCreatorBloc, bool>(
                          (b) => b.creatingSection),
                      onPressed: _openCreateSection,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class WorkoutSectionInWorkout extends StatelessWidget {
  final Key key;
  final int index;
  final WorkoutSection workoutSection;
  final bool canReorder;
  WorkoutSectionInWorkout(
      {required this.key,
      required this.index,
      required this.workoutSection,
      this.canReorder = false});

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

  void _updateSection(BuildContext context, Map<String, dynamic> data) {
    context
        .read<WorkoutCreatorBloc>()
        .updateWorkoutSection(workoutSection.sortPosition, data);
  }

  void _deleteWorkoutSection(BuildContext context) {
    context.showConfirmDeleteDialog(
        itemType: 'Section',
        onConfirm: () =>
            context.read<WorkoutCreatorBloc>().deleteWorkoutSection(index));
  }

  void _moveWorkoutSectionUpOne(BuildContext context) {
    context.read<WorkoutCreatorBloc>().reorderWorkoutSections(index, index - 1);
  }

  void _moveWorkoutSectionDownOne(BuildContext context) {
    context.read<WorkoutCreatorBloc>().reorderWorkoutSections(index, index + 1);
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (Utils.textNotNull(workoutSection.note))
                          CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: NotesIcon(),
                              onPressed: () => context.showBottomSheet(
                                  expand: true,
                                  child: TextViewer(
                                      workoutSection.note!, 'Section Note'))),
                        NavBarEllipsisMenu(ellipsisCircled: false, items: [
                          ContextMenuItem(
                            text: Utils.textNotNull(workoutSection.name)
                                ? 'Edit name'
                                : 'Add name',
                            iconData: CupertinoIcons.pencil,
                            onTap: () => context.push(
                                child: FullScreenTextEditing(
                              title: 'Name',
                              inputValidation: (text) => true,
                              initialValue: workoutSection.name,
                              onSave: (text) =>
                                  _updateSection(context, {'name': text}),
                            )),
                          ),
                          if (canReorder)
                            ContextMenuItem(
                              text: 'Move up',
                              onTap: () => _moveWorkoutSectionUpOne(context),
                              iconData: CupertinoIcons.up_arrow,
                            ),
                          if (canReorder)
                            ContextMenuItem(
                              text: 'Move down',
                              onTap: () => _moveWorkoutSectionDownOne(context),
                              iconData: CupertinoIcons.down_arrow,
                            ),
                          ContextMenuItem(
                            text: 'Delete',
                            onTap: () => _deleteWorkoutSection(context),
                            iconData: CupertinoIcons.delete_simple,
                            destructive: true,
                          ),
                        ])
                      ],
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  WorkoutSectionTypeTag(workoutSection.workoutSectionType.name),
                  if ([kHIITCircuitName, kTabataName, kEMOMName]
                      .contains(workoutSection.workoutSectionType.name))
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 4),
                      child: ContentBox(
                        child: MyText(
                          'Duration: ${DataUtils.calculateTimedSectionDuration(workoutSection).compactDisplay()}',
                          color: Styles.colorTwo,
                        ),
                      ),
                    ),
                  if (workoutSection.timecap != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 4),
                      child: ContentBox(
                        child: MyText(
                          'Timecap: ${workoutSection.timecap!.secondsToTimeDisplay()}',
                          color: Styles.colorTwo,
                        ),
                      ),
                    ),
                  ...data.moves
                      .map((m) => Tag(
                            color: context.theme.background,
                            textColor: context.theme.primary,
                            tag: m,
                            fontSize: FONTSIZE.SMALL,
                          ))
                      .toList(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 2,
                children: [
                  ...data.bodyAreas
                      .map((ba) => RoundedBox(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          child: MyText(ba)))
                      .toList()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 2,
                children: [
                  ...data.equipments
                      .map((e) => SizedBox(
                          width: 26,
                          height: 26,
                          child: Utils.getEquipmentIcon(context, e,
                              color: context.theme.primary)))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
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
