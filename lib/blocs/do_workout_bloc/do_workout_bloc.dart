import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/amrap_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/fortime_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/free_session_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/timed_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

class DoWorkoutBloc extends ChangeNotifier {
  final BuildContext context;

  /// Before any pre-start adjustments.
  final Workout originalWorkout;

  /// After any pre-start adjustments. Use this during.
  late Workout activeWorkout;

  late LoggedWorkout loggedWorkout;

  /// List of timers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  late List<StopWatchTimer> _stopWatchTimers;

  /// [AudioPlayer]s for any sections which have [classAudioUri]. Null if no audio.
  /// One for each section. Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  List<AudioPlayer?> _audioPlayers = [];

  /// List of _controllers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  /// Each section type has a sub controller that extends [WorkoutSectionController]
  /// Need to ensure that one only at a time is playing.
  late List<WorkoutSectionController> _controllers;

  DoWorkoutBloc({
    required BuildContext this.context,
    required Workout this.originalWorkout,
  }) {
    loggedWorkout = workoutToLoggedWorkout(workout: originalWorkout);

    activeWorkout = originalWorkout.copyAndSortAllChildren;

    final workoutSections = activeWorkout.workoutSections;

    /// One per section.
    _stopWatchTimers = workoutSections.map((_) => StopWatchTimer()).toList();

    /// One per section.
    _controllers = workoutSections
        .map((wSection) => _mapSectionTypeToControllerType(wSection))
        .toList();

    initAudioPlayers();
  }

  /// Constructor async helper ///
  Future<void> initAudioPlayers() async {
    await Future.wait(activeWorkout.workoutSections.map((section) async {
      if (Utils.textNotNull(section.classAudioUri)) {
        final player = await AudioPlayerController.init(
            audioUri: section.classAudioUri!, player: AudioPlayer());

        _audioPlayers.add(player);
      } else {
        _audioPlayers.add(null);
      }
    }).toList());

    notifyListeners();
  }

  //// Generate _controllers for all sections in the workout using this mapping ////
  WorkoutSectionController _mapSectionTypeToControllerType(
      WorkoutSection workoutSection) {
    final typeName = workoutSection.workoutSectionType.name;
    switch (typeName) {
      case kEMOMName:
      case kHIITCircuitName:
      case kTabataName:
        return TimedSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () => print('section complete'),
        );
      case kAMRAPName:
        return AMRAPSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () => print('section complete'),
        );
      case kForTimeName:
        return ForTimeSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () => print('section complete'),
        );
      case kFreeSessionName:
        return FreeSessionSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () => print('section complete'),
        );
      default:
        throw Exception(
            'No mapping exists for workout section type $typeName.');
    }
  }
  ////////

  AudioPlayer? getAudioPlayerForSection(int index) =>
      index > _audioPlayers.length - 1 ? null : _audioPlayers[index];

  StopWatchTimer getStopWatchTimerForSection(int index) =>
      _stopWatchTimers[index];

  WorkoutSectionController getControllerForSection(int index) =>
      _controllers[index];

  Stream<WorkoutSectionProgressState> getProgressStreamForSection(int index) =>
      _controllers[index].progressStream;

  WorkoutSectionProgressState getProgressStateForSection(int index) =>
      _controllers[index].state;

  //// User Inputs ////
  /// Used for workouts where the user is stepping through sets as they complete them.
  /// [AMRAP] / [ForTime]
  void markCurrentWorkoutSetAsComplete(int sectionIndex) {
    _controllers[sectionIndex].markCurrentWorkoutSetAsComplete();
  }

  void pauseWorkout() {
    /// TODO:
  }

  void generatePartialLog() {
    /// TODO:
  }

  void resetSection(int sectionIndex) {
    /// TODO:
  }

  void resetWorkout() {
    /// TODO:
  }

  /// User Inputs ////

  /// TODO.
  @override
  void dispose() async {
    for (final t in _stopWatchTimers) {
      await t.dispose();
    }
    for (final p in _audioPlayers) {
      await p?.dispose();
    }
    super.dispose();
  }
}
