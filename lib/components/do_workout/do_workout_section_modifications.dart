import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/creators/workout_creator/workout_creator_structure/workout_move_creator.dart';
import 'package:sofie_ui/components/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_creator/workout_set_definition.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/pickers/duration_picker.dart';
import 'package:sofie_ui/components/user_input/pickers/round_picker.dart';
import 'package:sofie_ui/components/workout/workout_move_display.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

/// Make modifications to the structure of the section before starting.
class DoWorkoutSectionModifications extends StatelessWidget {
  final int sectionIndex;
  const DoWorkoutSectionModifications({Key? key, required this.sectionIndex})
      : super(key: key);

  /// For ARMAP Only (Sept 2021).
  void _updateSectionTimecap(BuildContext context, int seconds) {
    context
        .read<DoWorkoutBloc>()
        .updateWorkoutSectionTimecap(sectionIndex, seconds);
  }

  void _updateSectionRounds(BuildContext context, int rounds) {
    context
        .read<DoWorkoutBloc>()
        .updateWorkoutSectionRounds(sectionIndex, rounds);
  }

  void _openCreateWorkoutMove(BuildContext context) {
    context.push(
        child: WorkoutMoveCreator(
      pageTitle: 'Add Move',
      saveWorkoutMove: (workoutMove) {
        context
            .read<DoWorkoutBloc>()
            .addWorkoutMoveToSection(sectionIndex, workoutMove);
      },
      sortPosition: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final activeWorkoutSection = context.select<DoWorkoutBloc, WorkoutSection>(
        (b) => b.activeWorkout.workoutSections[sectionIndex]);

    return MyPageScaffold(
      navigationBar: MyNavBar(
        backgroundColor: context.theme.background,
        customLeading: NavBarChevronDownButton(context.pop),
        middle: const NavBarTitle(
          'View / Modify',
        ),
      ),
      child: ListView(
        children: [
          MyHeaderText(
            activeWorkoutSection.nameOrTypeForDisplay,
            size: FONTSIZE.five,
            textAlign: TextAlign.center,
          ),
          if (activeWorkoutSection.isTimed)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MyText(
                'Total Time: ${activeWorkoutSection.timedSectionDuration.displayString}',
                size: FONTSIZE.four,
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (activeWorkoutSection.roundsInputAllowed)
                  ContentBox(
                    child: RoundPicker(
                      rounds: activeWorkoutSection.rounds,
                      saveValue: (rounds) =>
                          _updateSectionRounds(context, rounds),
                    ),
                  ),
                if (activeWorkoutSection.isAMRAP)
                  ContentBox(
                    child: DurationPickerDisplay(
                      modalTitle: 'AMRAP Timecap',
                      duration: Duration(seconds: activeWorkoutSection.timecap),
                      updateDuration: (duration) =>
                          _updateSectionTimecap(context, duration.inSeconds),
                    ),
                  ),
              ],
            ),
          ),
          ImplicitlyAnimatedList<WorkoutSet>(
            shrinkWrap: true,
            items: activeWorkoutSection.workoutSets,
            itemBuilder: (context, animation, item, index) =>
                SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _WorkoutSetEditor(
                  workoutSectionType: activeWorkoutSection.workoutSectionType,
                  sectionIndex: sectionIndex,
                  workoutSet: item,
                ),
              ),
            ),
            areItemsTheSame: (a, b) => a == b,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CreateTextIconButton(
                text: 'Add Move',
                onPressed: () => _openCreateWorkoutMove(context)),
          ),
        ],
      ),
    );
  }
}

/// A stripped back version of WorkoutSetCreator specifically for use before a user starts a workout for making some basic modifications.
class _WorkoutSetEditor extends StatelessWidget {
  final int sectionIndex;
  final WorkoutSet workoutSet;
  final WorkoutSectionType workoutSectionType;
  const _WorkoutSetEditor({
    required this.workoutSet,
    required this.workoutSectionType,
    required this.sectionIndex,
  });

  void _updateSetDuration(BuildContext context, Duration duration) {
    context.read<DoWorkoutBloc>().updateWorkoutSetDuration(
        sectionIndex, workoutSet.sortPosition, duration.inSeconds);
  }

  void _updateSetRounds(BuildContext context, int rounds) {
    context
        .read<DoWorkoutBloc>()
        .updateWorkoutSetRounds(sectionIndex, workoutSet.sortPosition, rounds);
  }

  void _openEditWorkoutMove(
      BuildContext context, WorkoutMove originalWorkoutMove) {
    context.push(
        child: WorkoutMoveCreator(
      pageTitle: 'Modify Move',
      workoutMove: originalWorkoutMove,
      saveWorkoutMove: (workoutMove) {
        context.read<DoWorkoutBloc>().updateWorkoutMove(
            sectionIndex, workoutSet.sortPosition, workoutMove);
      },
      sortPosition: originalWorkoutMove.sortPosition,
    ));
  }

  void _confirmRemoveWorkoutSet(BuildContext context) {
    context.showConfirmDeleteDialog(
        itemType: 'Workout Set',
        onConfirm: () => _removeWorkoutSetFromSection(context));
  }

  void _removeWorkoutSetFromSection(BuildContext context) {
    context
        .read<DoWorkoutBloc>()
        .removeWorkoutSetFromSection(sectionIndex, workoutSet.sortPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (workoutSectionType.isTimed)
                    CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        onPressed: () => context.showBottomSheet(
                            expand: false,
                            showDragHandle: false,
                            child: WorkoutSetDurationPicker(
                                allowCopyToAll: false,
                                duration:
                                    Duration(seconds: workoutSet.duration),
                                updateDuration: (duration, _) =>
                                    _updateSetDuration(context, duration))),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.timer, size: 18),
                            const SizedBox(width: 5),
                            MyText(
                              Duration(seconds: workoutSet.duration)
                                  .displayString,
                              size: FONTSIZE.four,
                            )
                          ],
                        )),
                  if (workoutSectionType.roundsInputAllowed)
                    RoundPicker(
                        rounds: workoutSet.rounds,
                        saveValue: (rounds) =>
                            _updateSetRounds(context, rounds),
                        padding: const EdgeInsets.symmetric(horizontal: 4)),
                  if (!workoutSet.isRestSet)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: WorkoutSetDefinition(workoutSet: workoutSet),
                    ),
                ],
              ),
              if (workoutSet.isRestSet)
                const MyText(
                  'REST',
                  size: FONTSIZE.four,
                ),
              GestureDetector(
                  onTap: () => _confirmRemoveWorkoutSet(context),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      CupertinoIcons.clear_thick,
                      size: 22,
                    ),
                  )),
            ],
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: workoutSet.workoutMoves
                .mapIndexed((i, wm) => GestureDetector(
                    onTap: () => _openEditWorkoutMove(context, wm),
                    child:
                        WorkoutMoveDisplay(wm, isLast: i == wm.sortPosition)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
