import 'package:better_player/better_player.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/controllers/amrap_section_controller.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/controllers/fortime_section_controller.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/controllers/free_session_section_controller.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/controllers/timed_section_controller.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/workout_progress_state.dart';
import 'package:sofie_ui/components/media/audio/audio_players.dart';
import 'package:sofie_ui/components/media/video/uploadcare_video_player.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/data_model_converters/workout_to_logged_workout.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:uuid/uuid.dart';

class DoWorkoutBloc extends ChangeNotifier {
  /// Before any pre-start adjustments.
  final Workout originalWorkout;
  final ScheduledWorkout? scheduledWorkout;

  /// After any pre-start adjustments. Use this during.
  late Workout activeWorkout;

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

  /// Completed progress flags.
  /// Lets the UI know to send the User to the post workout page.
  bool workoutCompletedAndLogged = false;

  DoWorkoutBloc({
    required this.originalWorkout,
    this.scheduledWorkout,
  }) {
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
          printLog(e.toString());
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
    for (final c in _controllers) {
      c.reset();
    }

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

  /// Modify workout methods ////
  /// Modify sets and moves before starting the workout or (if Free Session) during the workout ///
  void updateWorkoutSectionRounds(int sectionIndex, int rounds) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    section.rounds = rounds;
    activeWorkout.workoutSections[sectionIndex] = section;

    notifyListeners();
  }

  /// For AMRAPs.
  void updateWorkoutSectionTimecap(int sectionIndex, int seconds) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    section.timecap = seconds;
    activeWorkout.workoutSections[sectionIndex] = section;

    notifyListeners();
  }

  /// Allows the user to add a single move set (i.e) not a SuperSet to the end of the section.
  /// Primarily for use in a Free Session so the user can extend their workout / add extra moves easily whilst they are in progress. But also available via the [DoWorkoutSectionModifications] screen.
  /// Always making a copy of the section as this is what the provider.select listener is checking.
  void addWorkoutMoveToSection(int sectionIndex, WorkoutMove workoutMove) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    final newWorkoutSet = WorkoutSet()
      ..id = const Uuid().v1()
      ..sortPosition = section.workoutSets.length
      ..rounds = 1
      ..duration = 60
      ..workoutMoves = [workoutMove];

    section.workoutSets.add(newWorkoutSet);

    activeWorkout.workoutSections[sectionIndex] = section;
    notifyListeners();
  }

  void removeWorkoutSetFromSection(int sectionIndex, int setIndex) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    section.workoutSets.removeAt(setIndex);

    section.workoutSets.forEachIndexed((i, wSet) {
      wSet.sortPosition = i;
    });

    activeWorkout.workoutSections[sectionIndex] = section;
    notifyListeners();
  }

  void updateWorkoutSetRounds(int sectionIndex, int setIndex, int rounds) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    section.workoutSets[setIndex].rounds = rounds;

    activeWorkout.workoutSections[sectionIndex] = section;
    notifyListeners();
  }

  void updateWorkoutSetDuration(int sectionIndex, int setIndex, int seconds) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    section.workoutSets[setIndex].duration = seconds;

    activeWorkout.workoutSections[sectionIndex] = section;
    notifyListeners();
  }

  void updateWorkoutMove(
      int sectionIndex, int setIndex, WorkoutMove workoutMove) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());

    section.workoutSets[setIndex].workoutMoves = section
        .workoutSets[setIndex].workoutMoves
        .map((wm) => wm.id == workoutMove.id ? workoutMove : wm)
        .toList();

    activeWorkout.workoutSections[sectionIndex] = section;

    notifyListeners();
  }

  void addWorkoutSetToSection(int sectionIndex, WorkoutSet workoutSet) {
    final section = WorkoutSection.fromJson(
        activeWorkout.workoutSections[sectionIndex].toJson());
    section.workoutSets.add(workoutSet);

    activeWorkout.workoutSections[sectionIndex] = section;
    notifyListeners();
  }

  /// Based on the state objects of all of the section controllers, generate a full workout log for this workout.
  LoggedWorkout generateLog() {
    final loggedWorkout = loggedWorkoutFromWorkout(workout: activeWorkout);

    loggedWorkout.loggedWorkoutSections =
        activeWorkout.workoutSections.map((wSection) {
      final sectionIndex = wSection.sortPosition;

      /// If AMRAP or ForTime then save reps.
      int? repScore;

      if (wSection.workoutSectionType.isAMRAP) {
        repScore =
            (getControllerForSection(sectionIndex) as AMRAPSectionController)
                .repsCompleted;
      } else if (wSection.workoutSectionType.name == kForTimeName) {
        repScore =
            (getControllerForSection(sectionIndex) as ForTimeSectionController)
                .repsCompleted;
      }

      final loggedSection = loggedWorkoutSectionFromWorkoutSection(
          workoutSection: wSection,
          repScore: repScore,
          timeTakenSeconds:
              getStopWatchTimerForSection(sectionIndex).secondTime.value);

      /// Add the sectionData that was accumulated as the user did the workout.
      loggedSection.loggedWorkoutSectionData =
          getControllerForSection(wSection.sortPosition).state.sectionData;
      return loggedSection;
    }).toList();

    return loggedWorkout;
  }

  void markWorkoutCompleteAndLogged() {
    workoutCompletedAndLogged = true;
    notifyListeners();
  }

  /// User Inputs End ////

  @override
  Future<void> dispose() async {
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
