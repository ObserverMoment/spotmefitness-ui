import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

class ViewWorkoutSectionMoves extends StatelessWidget {
  final int sectionIndex;
  const ViewWorkoutSectionMoves({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutSection = context.select<DoWorkoutBloc, WorkoutSection>(
        (b) => b.activeWorkout.workoutSections[sectionIndex]);

    return MyPageScaffold(
      navigationBar: MyNavBar(
        backgroundColor: context.theme.background,
        customLeading: NavBarChevronDownButton(context.pop),
        middle: NavBarTitle(workoutSection.nameOrTypeForDisplay),
      ),
      child: WorkoutDetailsSection(
        workoutSection,
        scrollable: true,
      ),
    );
  }
}
