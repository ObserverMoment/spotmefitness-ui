import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class DoWorkoutBloc {
  int currentSectionIndex = 0;
  int currentSectionRound = 0;
  int currentSetIndex = 0;
  int currentSetRound = 0;

  DoWorkoutBloc({required Workout workout});
}
