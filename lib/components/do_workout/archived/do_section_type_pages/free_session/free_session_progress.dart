import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/free_session_section_controller.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';

class FreeSessionProgress extends StatelessWidget {
  final FreeSessionSectionController freeSessionController;
  const FreeSessionProgress({Key? key, required this.freeSessionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: LoggedWorkoutSectionSummaryCard(
    //       loggedWorkoutSection: freeSessionController.loggedWorkoutSection),
    // );
  }
}
