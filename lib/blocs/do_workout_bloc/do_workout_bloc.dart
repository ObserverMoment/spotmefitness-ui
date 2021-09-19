import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/amrap_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/fortime_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/free_session_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/controllers/timed_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

class DoWorkoutBloc extends ChangeNotifier {
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

  /// [BetterPlayerController]s for any sections which have [classVideoUri]. Null if no video.
  /// One for each section. Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  List<BetterPlayerController?> _videoControllers = [];

  /// List of _controllers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  /// Each section type has a sub controller that extends [WorkoutSectionController]
  /// Need to ensure that one only at a time is playing.
  late List<WorkoutSectionController> _controllers;

  /// Init flags.
  bool audioInitSuccess = false;
  bool videoInitSuccess = false;

  DoWorkoutBloc({
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

    _initVideoControllers().then((_) => _initAudioPlayers());
  }

  /// Constructor async helper ///
  Future<void> _initVideoControllers() async {
    _videoControllers =
        await Future.wait(activeWorkout.workoutSections.map((section) async {
      if (Utils.textNotNull(section.classVideoUri)) {
        try {
          final videoData = await VideoSetupManager.getVideoData(
              videoUri: section.classVideoUri!);
          final controller = VideoSetupManager.initializeController(
              aspectRatio: videoData.aspectRatio,
              dataSource: videoData.dataSource,
              autoLoop: true);
          return controller;
        } catch (e) {
          print(e);
          throw Exception('Unable to get data for this video.');
        }
      } else {
        return null;
      }
    }).toList());

    videoInitSuccess = true;
    notifyListeners();
  }

  /// Constructor async helper ///
  Future<void> _initAudioPlayers() async {
    _audioPlayers =
        await Future.wait(activeWorkout.workoutSections.map((section) async {
      if (Utils.textNotNull(section.classAudioUri)) {
        final player = await AudioPlayerController.init(
            audioUri: section.classAudioUri!, player: AudioPlayer());

        return player;
      } else {
        return null;
      }
    }).toList());

    audioInitSuccess = true;
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
            onCompleteSection: () =>
                _onSectionComplete(workoutSection.sortPosition));
      case kAMRAPName:
        return AMRAPSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          onCompleteSection: () =>
              _onSectionComplete(workoutSection.sortPosition),
        );
      case kForTimeName:
        return ForTimeSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          onCompleteSection: () =>
              _onSectionComplete(workoutSection.sortPosition),
        );
      case kFreeSessionName:
        return FreeSessionSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          onCompleteSection: () =>
              _onSectionComplete(workoutSection.sortPosition),
        );
      default:
        throw Exception(
            'No mapping exists for workout section type $typeName.');
    }
  }

  void _onSectionComplete(int index) {
    pauseSection(index);
    notifyListeners();
  }

  AudioPlayer? getAudioPlayerForSection(int index) =>
      index > _audioPlayers.length - 1 ? null : _audioPlayers[index];

  BetterPlayerController? getVideoControllerForSection(int index) =>
      index > _videoControllers.length - 1 ? null : _videoControllers[index];

  StopWatchTimer getStopWatchTimerForSection(int index) =>
      _stopWatchTimers[index];

  WorkoutSectionController getControllerForSection(int index) =>
      _controllers[index];

  Stream<WorkoutSectionProgressState> getProgressStreamForSection(int index) =>
      _controllers[index].progressStream;

  WorkoutSectionProgressState getProgressStateForSection(int index) =>
      _controllers[index].state;

  bool get allSectionsComplete => _controllers.every((c) => c.sectionComplete);

  /// Used to get the 'Now" and Next" set displays.
  /// For now set use offset of 0.
  /// For next set use offset of 1.
  WorkoutSet getActiveSetForSection(int index, int offset) {
    final controller = _controllers[index];
    final requestedIndex = controller.state.currentSetIndex + offset;
    final setsInRound = controller.workoutSection.workoutSets.length;
    return controller.workoutSection.workoutSets[requestedIndex % setsInRound];
  }

  //// User Inputs Start ////
  Future<void> playSection(int index) async {
    getControllerForSection(index).sectionHasStarted = true;
    getStopWatchTimerForSection(index).onExecute.add(StopWatchExecute.start);

    await getAudioPlayerForSection(index)?.play();
    await getVideoControllerForSection(index)?.play();
    notifyListeners();
  }

  Future<void> pauseSection(int index) async {
    getStopWatchTimerForSection(index).onExecute.add(StopWatchExecute.stop);
    await getAudioPlayerForSection(index)?.pause();
    await getVideoControllerForSection(index)?.pause();
    notifyListeners();
  }

  Future<void> resetSection(int index) async {
    getControllerForSection(index).reset();

    await getAudioPlayerForSection(index)?.stop();
    await getAudioPlayerForSection(index)?.seek(Duration.zero);

    await getVideoControllerForSection(index)?.pause();
    await getVideoControllerForSection(index)?.seekTo(Duration.zero);

    notifyListeners();
  }

  Future<void> resetWorkout() async {
    _controllers.forEach((c) => c.reset());

    for (final p in _audioPlayers) {
      await p?.stop();
      await p?.seek(Duration.zero);
    }

    for (final v in _videoControllers) {
      await v?.pause();
      await v?.seekTo(Duration.zero);
    }
  }

  /// Used for workouts where the user is stepping through sets as they complete them.
  /// [AMRAP] / [ForTime]
  void markCurrentWorkoutSetAsComplete(int sectionIndex) {
    _controllers[sectionIndex].markCurrentWorkoutSetAsComplete();
  }

  void onSectionComplete(int index) {
    pauseSection(index);
    notifyListeners();
  }

  void generatePartialLog() {
    /// TODO:
  }

  /// User Inputs End ////

  @override
  void dispose() async {
    super.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final v in _videoControllers) {
      v?.dispose(forceDispose: true);
    }
    for (final t in _stopWatchTimers) {
      await t.dispose();
    }
    for (final p in _audioPlayers) {
      await p?.dispose();
    }
  }
}
