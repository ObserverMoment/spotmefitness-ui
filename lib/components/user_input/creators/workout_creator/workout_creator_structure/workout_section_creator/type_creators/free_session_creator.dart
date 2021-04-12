import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class FreeSessionCreator extends StatelessWidget {
  final int editingSectionIndex;
  FreeSessionCreator(this.editingSectionIndex);
  @override
  Widget build(BuildContext context) {
    final section = context.select<WorkoutCreatorBloc, WorkoutSection>(
        (bloc) => bloc.workoutData.workoutSections[editingSectionIndex]);

    return Column(
      children: [
        Row(
          children: [
            MyText(section.name ?? 'Section $editingSectionIndex'),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: section.workoutSets.length,
            itemBuilder: (context, index) =>
                MyText(section.workoutSets[index].sortPosition.toString())),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                text: 'Add Set',
                onPressed: () => print('add set'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
