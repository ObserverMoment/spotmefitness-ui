import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutSectionProgressState {
  late int numberSetsPerSectionRound;
  int latestSectionRoundSplitTimeMs = 0;
  int latestSetSplitTimeMs = 0;

  int currentSectionRound = 0;
  int currentSetIndex = 0;

  WorkoutSectionData workoutSectionData = WorkoutSectionData()..rounds = [];

  /// Used for timed workouts or timecaps.
  /// Can be the next set or the end of the section, depending on the section type.
  int? timeToNextCheckpointMs;

  /// Must be a double between 0.0 and 1.0 inclusive.
  /// How this is calculated will depend on the type of workout / workout controller.
  /// For example timed workouts are just curTime / totalTime.
  /// ForTime and Free Session workouts are based on rounds and sets complete vs total rounds and set in the workout.
  double percentComplete = 0.0;

  /// Only used for [LastStanding] type sections where a user can 'get ahead' of the time and so should be resting while they wait for the next period.
  bool userShouldBeResting = false;

  WorkoutSectionProgressState(WorkoutSection workoutSection) {
    numberSetsPerSectionRound = workoutSection.workoutSets.length;
  }

  /// This is invoked each time a new state is generated.
  /// So make sure if you add any fields that they also get added to this copy method!
  WorkoutSectionProgressState.copy(WorkoutSectionProgressState o)
      : currentSectionRound = o.currentSectionRound,
        currentSetIndex = o.currentSetIndex,
        workoutSectionData = o.workoutSectionData,
        percentComplete = o.percentComplete,
        timeToNextCheckpointMs = o.timeToNextCheckpointMs,
        numberSetsPerSectionRound = o.numberSetsPerSectionRound,
        latestSectionRoundSplitTimeMs = o.latestSectionRoundSplitTimeMs,
        latestSetSplitTimeMs = o.latestSetSplitTimeMs,
        userShouldBeResting = o.userShouldBeResting;

  /// Move to next set, or if currently on the last set of a section round, move to the round - resetting the section index to 0.
  /// [secondsElapsed] is the total seconds passed for this section.
  /// This method will calculate the splits for the set / section from this and the latest split times stored locally.
  /// Makes a copy of the current state and returns it.
  void moveToNextSetOrSection(int secondsElapsed) {
    final elapsedMs = secondsElapsed * 1000;
    final sectionLapTimeTimeMs = elapsedMs - latestSectionRoundSplitTimeMs;
    final setLapTimeTimeMs = elapsedMs - latestSetSplitTimeMs;

    if (currentSetIndex >= numberSetsPerSectionRound - 1) {
      /// Move to the next section round.
      latestSectionRoundSplitTimeMs = elapsedMs;

      /// Add the latest lap times.
      addSectionRoundLapTime(sectionLapTimeTimeMs);

      addSetLapTime(setLapTimeTimeMs);

      currentSectionRound += 1;
      currentSetIndex = 0;
    } else {
      /// Move to the next set.
      /// Add the latest lap time.
      addSetLapTime(setLapTimeTimeMs);

      currentSetIndex += 1;
    }

    /// Always update the set split time when moving to the next set.
    latestSetSplitTimeMs = elapsedMs;
  }

  /// Add a lapTime at the [currentSectionRound] and [currentSetIndex]
  void addSetLapTime(int lapTimeMs) {
    /// TODO.
  }

  void addSectionRoundLapTime(int lapTimeMs) {
    /// TODO.
  }

  void moveToNextSet() {
    if (currentSetIndex == numberSetsPerSectionRound - 1) {
      currentSectionRound++;
      currentSetIndex = 0;
    } else {
      currentSetIndex++;
    }
  }

  void moveToNextSection() {
    currentSectionRound++;
    currentSetIndex = 0;
  }
}
