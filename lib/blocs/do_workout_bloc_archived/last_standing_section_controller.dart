// import 'dart:async';
// import 'dart:math';

// import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
// import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
// import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';

// class LastStandingSectionController extends WorkoutSectionController {
//   /// Last Standing can be open ended - will be null if so.
//   late int? _finishAfterTimeSeconds;
//   late StreamSubscription _timerStreamSubscription;
//   late int _numberSetsPerRound;

//   /// Last Standing rounds should always be 1.
//   /// So we can represent checkpoints in a single list that the user will loop around until their either fail or they hit the 'finish line' at [_finishAfterTimeSeconds].
//   /// Not acumulating, time in ms is for each individual set.
//   late List<int> _setCheckPointTimesMs;

//   /// We need to save a local count of the total progress the user has made.
//   /// We compare this with where they should be based on the elsapsed time to determine if they should be resting ([state.userShouldBeResting]) or if they have failed a checkpoint.
//   /// [state.currentSetIndex] loops around the sets within the section and has a max of [_numberSetsPerRound]. So it cannot be used for this comparison.
//   /// Where the user IS.
//   int _acumulatedSetIndex = 0;

//   /// Where the user SHOULD BE.
//   int _acumSetIndexBasedOnTime = 0;

//   /// The next checkpoint based on elapsed time.
//   int _nextAcumCheckPointMs = 0;

//   LastStandingSectionController(
//       {required WorkoutSection workoutSection,
//       required StopWatchTimer stopWatchTimer,
//       required void Function() markSectionComplete})
//       : super(
//             stopWatchTimer: stopWatchTimer,
//             workoutSection: workoutSection,
//             markSectionComplete: markSectionComplete) {
//     _finishAfterTimeSeconds = workoutSection.timecap;
//     _numberSetsPerRound = workoutSection.workoutSets.length;

//     /// All Last Standing sets must have a duration. If they do not, this is an error.
//     /// These are set timecaps / lap times (not split times - we do something similar with an acumulated time in a timed workout).
//     _setCheckPointTimesMs =
//         workoutSection.workoutSets.map((wSet) => wSet.duration * 1000).toList();

//     _nextAcumCheckPointMs = _setCheckPointTimesMs[0];

//     state.timeToNextCheckpointMs = _setCheckPointTimesMs[0];
//     progressStateController.add(state);

//     _timerStreamSubscription =
//         stopWatchTimer.secondTime.listen(timerStreamListener);
//   }

//   void timerStreamListener(int secondsElapsed) async {
//     if (!sectionComplete) {
//       if ((secondsElapsed * 1000) >= _nextAcumCheckPointMs) {
//         _acumSetIndexBasedOnTime++;
//         _nextAcumCheckPointMs += _setCheckPointTimesMs[
//             _acumSetIndexBasedOnTime % _numberSetsPerRound];
//       }

//       if (_acumulatedSetIndex < _acumSetIndexBasedOnTime) {
//         /// Missed a checkpoint - the workout is over.
//         sectionComplete = true;
//         markSectionComplete();
//       } else if (_finishAfterTimeSeconds != null &&
//           secondsElapsed >= _finishAfterTimeSeconds!) {
//         /// They have reached the finish line.
//         markSectionComplete();
//       } else if (_acumulatedSetIndex > _acumSetIndexBasedOnTime) {
//         /// They are ahead and should rest.
//         state.userShouldBeResting = true;
//       } else if (_acumulatedSetIndex == _acumSetIndexBasedOnTime) {
//         state.userShouldBeResting = false;
//       }

//       state.timeToNextCheckpointMs =
//           max(0, _nextAcumCheckPointMs - (secondsElapsed * 1000));

//       /// Update percentage complete if there is a 'finish line'.
//       if (_finishAfterTimeSeconds != null)
//         state.percentComplete =
//             (secondsElapsed / _finishAfterTimeSeconds!).clamp(0.0, 1.0);

//       progressStateController.add(state);
//     }
//   }

//   /// Public method for the user to progress to the next set (or section if this is the last set)
//   void markCurrentWorkoutSetAsComplete() {
//     _acumulatedSetIndex++;

//     /// Update the [loggedWorkoutSection]
//     loggedWorkoutSection.loggedWorkoutSets.add(workoutSetToLoggedWorkoutSet(
//         sortedWorkoutSets[state.currentSetIndex], state.currentSectionRound));

//     final secondsElapsed = stopWatchTimer.secondTime.value;
//     state.moveToNextSetOrSection(secondsElapsed);

//     /// Broadcast new state.
//     progressStateController.add(state);
//   }

//   @override
//   void dispose() async {
//     await _timerStreamSubscription.cancel();
//     super.dispose();
//   }
// }
