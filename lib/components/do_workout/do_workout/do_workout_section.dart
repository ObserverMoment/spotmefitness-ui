import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout/do_workout_moves_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_instructions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class DoWorkoutSection extends StatefulWidget {
  final WorkoutSection workoutSection;
  const DoWorkoutSection({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  _DoWorkoutSectionState createState() => _DoWorkoutSectionState();
}

class _DoWorkoutSectionState extends State<DoWorkoutSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WorkoutSectionInstructions(
            typeName: widget.workoutSection.workoutSectionType.name,
            rounds: widget.workoutSection.rounds,
            timecap: widget.workoutSection.timecap,
          ),
        ),
        Expanded(
          child: PageView(
            children: [
              DoWorkoutMovesList(workoutSection: widget.workoutSection),
              MyText('Progress Summary and Input'),
              MyText('Timer + lap times for sets and sections'),
            ],
          ),
        )
      ],
    );
  }
}
