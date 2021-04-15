import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_section_creator.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

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

class WorkoutSectionInWorkout extends StatelessWidget {
  final WorkoutSection workoutSection;
  WorkoutSectionInWorkout({required this.workoutSection});

  // late Set<String> _allMoves = {};
  //   late Set<String> _allEquipments = {};

  //   for (final section in workoutSummary.userWorkoutsWorkoutSections) {
  //     for (final workoutSet in section.userWorkoutsWorkoutSets) {
  //       for (final workoutMove in workoutSet.userWorkoutsWorkoutMoves) {
  //         _allMoves.add(workoutMove.userWorkoutsMove.name);
  //         if (workoutMove.equipment != null) {
  //           _allEquipments.add(workoutMove.equipment!.name);
  //         }
  //         if (workoutMove.userWorkoutsMove.requiredEquipments.isNotEmpty) {
  //           _allEquipments.addAll(workoutMove
  //               .userWorkoutsMove.requiredEquipments
  //               .map((e) => e.name));
  //         }
  //       }
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    H3('${(workoutSection.sortPosition + 1).toString()}'),
                    if (Utils.textNotNull(workoutSection.name))
                      H3(workoutSection.name!),
                  ],
                ),
                WorkoutSectionTypeTag(
                  workoutSection.workoutSectionType.name,
                  timecap: workoutSection.timecap,
                ),
              ],
            ),
          ),
          MyText('List of moves'),
          MyText('List of equipments'),
          MyText('List of body areas graphics'),
        ],
      ),
    );
  }
}
