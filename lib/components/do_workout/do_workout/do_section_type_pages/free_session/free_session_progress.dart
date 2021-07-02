import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/free_session_section_controller.dart';
import 'package:spotmefitness_ui/components/text.dart';

class FreeSessionProgress extends StatelessWidget {
  final FreeSessionSectionController freeSessionController;
  const FreeSessionProgress({Key? key, required this.freeSessionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSets =
        freeSessionController.loggedWorkoutSection.loggedWorkoutSets;
    return Container(
      child: MyText(loggedWorkoutSets.length.toString()),
    );
  }
}
