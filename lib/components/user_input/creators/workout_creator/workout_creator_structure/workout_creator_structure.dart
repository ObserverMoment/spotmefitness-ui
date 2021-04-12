import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_section_creator.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutCreatorStructure extends StatelessWidget {
  void _openCreateSection(BuildContext context) {
    final bloc = context.read<WorkoutCreatorBloc>();
    // Create a default section as a placeholder until user selects the type.
    bloc.createSection(WorkoutSectionType()
      ..id = 0.toString()
      ..name = 'Free Session'
      ..description = '');

    // https://stackoverflow.com/questions/57598029/how-to-pass-provider-with-navigator
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider<WorkoutCreatorBloc>.value(
          value: bloc,
          child: WorkoutSectionCreator(
            bloc.workoutData.workoutSections.length - 1,
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
          child: WorkoutSectionCreator(sectionIndex),
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
              itemBuilder: (context, index) => CupertinoButton(
                    onPressed: () => _openEditSection(context, index),
                    child: MyText(workoutData.workoutSections[index].name ??
                        'Section $index'),
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
