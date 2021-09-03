import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/abstract_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/amrap_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/fortime_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/free_session_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/last_standing_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/timed_section_controller.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Delegates to the correct sub bloc types for each workout section
/// As required by the workoutSectionType
class DoWorkoutBloc extends ChangeNotifier {
  final BuildContext context;
  late List<WorkoutSection> _sortedWorkoutSections;
  late LoggedWorkout loggedWorkout;

  /// AMRAP, ForTime and LastStanding types will use this.
  /// Initialise all to zero in constructor.
  late List<int> totalReps;

  /// List of timers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  late List<StopWatchTimer> _stopWatchTimers;

  /// [AudioPlayer]s for any sections which have [classAudioUri]. Null if no audio.
  /// One for each section. Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  late List<AudioPlayer?> _audioPlayers;

  /// List of controllers - one for each workoutSection.
  /// Sorted by sortPosition. Index [0] == sortPosition of [0] etc.
  /// Each section type has a sub controller that extends [WorkoutSectionController]
  /// Need to ensure that one only at a time is playing.
  late List<WorkoutSectionController> controllers;

  /// At completed LoggedWorkoutSection at index [workoutSection.sortPosition] when completed.
  late List<LoggedWorkoutSection?> completedSections;
  bool allSectionsComplete = false;

  /// If false then an intro modal will show over the section page letting the user start the workout with countdown.
  late List<bool> startedSections;

  /// This is true whenever any section is in progress. False
  bool workoutInProgress = false;

  DoWorkoutBloc({
    required BuildContext this.context,
    required Workout workout,
  }) {
    loggedWorkout = DefaultObjectfactory.defaultLoggedWorkout(workout: workout);

    _sortedWorkoutSections = workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition);

    completedSections = _sortedWorkoutSections.map((_) => null).toList();
    startedSections = _sortedWorkoutSections.map((_) => false).toList();
    totalReps = _sortedWorkoutSections.map((_) => 0).toList();

    /// One per section.
    _stopWatchTimers =
        _sortedWorkoutSections.map((_) => StopWatchTimer()).toList();

    /// One per section.
    controllers = _sortedWorkoutSections
        .map((wSection) => _mapSectionTypeToControllerType(wSection))
        .toList();

    /// One per section. Create null filled list then call async function to generate the required audio players.
    _audioPlayers = _sortedWorkoutSections.map((_) => null).toList();
    initAudioPlayers();
  }

  /// Constructor async helper ///
  Future<void> initAudioPlayers() async {
    for (final section in _sortedWorkoutSections) {
      if (Utils.textNotNull(section.classAudioUri)) {
        final player = await AudioPlayerController.init(
            audioUri: section.classAudioUri!, player: AudioPlayer());

        _audioPlayers = _audioPlayers
            .mapIndexed(
                (i, original) => i == section.sortPosition ? player : original)
            .toList();

        notifyListeners();
      }
    }
  }

  //// User inputs - Public ////
  /// Used for workouts where the user is stepping through sets as they complete them.
  /// [AMRAP], [ForTime], [LastStanding]
  void markCurrentWorkoutSetAsComplete(int sectionIndex) {
    controllers[sectionIndex].markCurrentWorkoutSetAsComplete();
    _calculateTotalReps(sectionIndex);
  }

  void _calculateTotalReps(int sectionIndex) {
    totalReps[sectionIndex] =
        DataUtils.totalRepsInSection<LoggedWorkoutSection>(
            controllers[sectionIndex].loggedWorkoutSection);

    controllers[sectionIndex].loggedWorkoutSection.repScore =
        totalReps[sectionIndex];

    notifyListeners();
  }

  void generatePartialLog() {
    startedSections.forEachIndexed((index, started) {
      if (started) {
        final sectionLog = _genLoggedWorkoutSection(index);
        loggedWorkout.loggedWorkoutSections.add(sectionLog);
        _calculateTotalReps(index);
      }
    });

    /// This will prompt the UI to route to the workout log screen.
    allSectionsComplete = true;
    notifyListeners();
  }

  void resetSection(int sectionIndex) {
    startedSections[sectionIndex] = false;
    _stopWatchTimers[sectionIndex].onExecute.add(StopWatchExecute.reset);
    completedSections[sectionIndex] = null;
    controllers[sectionIndex].reset();
    loggedWorkout.loggedWorkoutSections = loggedWorkout.loggedWorkoutSections
        .where((lws) => lws.sortPosition != sectionIndex)
        .toList();
    _audioPlayers[sectionIndex]?.stop();
    _audioPlayers[sectionIndex]?.seek(Duration.zero);
    allSectionsComplete = false;
    _calculateTotalReps(sectionIndex);
    workoutInProgress = false;
    notifyListeners();
  }

  void resetWorkout() {
    _sortedWorkoutSections.forEach((ws) {
      resetSection(ws.sortPosition);
    });
    allSectionsComplete = false;
    loggedWorkout.loggedWorkoutSections = [];
    workoutInProgress = false;
    notifyListeners();
  }
  /////

  //// State progress updates and logged workout section generators ////
  /// Generate the log from the section state.
  /// Then add it to completedSections and loggedWorkout.loggedWorkoutSections.
  void _markSectionComplete(int sectionIndex) {
    /// Pause audio and stop timer if necessary.
    _audioPlayers[sectionIndex]?.stop();
    _stopWatchTimers[sectionIndex].onExecute.add(StopWatchExecute.stop);

    final sectionLog = _genLoggedWorkoutSection(sectionIndex);
    completedSections = completedSections
        .mapIndexed((index, nullableLog) =>
            index == sectionIndex ? sectionLog : nullableLog)
        .toList();

    loggedWorkout.loggedWorkoutSections.add(sectionLog);

    if (completedSections.whereType<LoggedWorkoutSection>().length ==
        _sortedWorkoutSections.length) {
      allSectionsComplete = true;
    }
    workoutInProgress = false;
    notifyListeners();
  }

  LoggedWorkoutSection _genLoggedWorkoutSection(int sectionIndex) {
    final LoggedWorkoutSection sectionLog =
        controllers[sectionIndex].loggedWorkoutSection;
    sectionLog.timeTakenMs = _stopWatchTimers[sectionIndex].rawTime.value;
    sectionLog.lapTimesMs = controllers[sectionIndex].state.lapTimesMs;
    return sectionLog;
  }

  void addNoteToLoggedWorkoutSection(int sectionIndex, String note) {
    final prev = loggedWorkout.loggedWorkoutSections[sectionIndex].toJson();
    loggedWorkout.loggedWorkoutSections[sectionIndex] =
        LoggedWorkoutSection.fromJson({...prev, 'note': note});
    notifyListeners();
  }
  ////////

  //// Timer and Audio related ////
  /// Audio playback is synced to timer progress so play / pause the timer causes play / pause the audio.
  /// Pause all timers and audio.
  void pauseWorkout() {
    _stopWatchTimers.forEach((timer) {
      timer.onExecute.add(StopWatchExecute.stop);
    });

    _audioPlayers.forEach((player) {
      player?.pause();
    });

    workoutInProgress = false;
    notifyListeners();
  }

  StopWatchTimer getStopWatchTimerForSection(int index) =>
      _stopWatchTimers[index];

  LoggedWorkoutSection getLoggedWorkoutSectionForSection(int index) =>
      controllers[index].loggedWorkoutSection;

  /// For when user first starts the section from the StartSectionModal.
  /// For play / pause use [playSection(int)]
  void startSection(int index) {
    startedSections[index] = true;
    playSection(index);
    notifyListeners();
  }

  void playSection(int index) {
    if (!_stopWatchTimers[index].isRunning) {
      _stopWatchTimers[index].onExecute.add(StopWatchExecute.start);
    }

    _audioPlayers[index]?.play();
    workoutInProgress = true;
    notifyListeners();
  }

  void pauseSection(int index) {
    if (_stopWatchTimers[index].isRunning) {
      _stopWatchTimers[index].onExecute.add(StopWatchExecute.stop);
      context.showToast(message: 'Workout Paused');
    }

    _audioPlayers[index]?.pause();
    workoutInProgress = false;
    notifyListeners();
  }

  AudioPlayer? getAudioPlayerForSection(int index) => _audioPlayers[index];
  //// Timer and Audio related ////

  //// Generate controllers for all sections in the workout using this mapping ////
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
          markSectionComplete: () =>
              _markSectionComplete(workoutSection.sortPosition),
        );
      case kAMRAPName:
        return AMRAPSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () =>
              _markSectionComplete(workoutSection.sortPosition),
        );
      case kForTimeName:
        return ForTimeSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () =>
              _markSectionComplete(workoutSection.sortPosition),
        );
      case kFreeSessionName:
        return FreeSessionSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () =>
              _markSectionComplete(workoutSection.sortPosition),
        );
      case kLastStandingName:
        return LastStandingSectionController(
          workoutSection: workoutSection,
          stopWatchTimer: _stopWatchTimers[workoutSection.sortPosition],
          markSectionComplete: () =>
              _markSectionComplete(workoutSection.sortPosition),
        );
      default:
        throw Exception(
            'No mapping exists for workout section type $typeName.');
    }
  }
  ////////

  @override
  void dispose() async {
    for (final c in controllers) {
      c.dispose();
    }
    for (final t in _stopWatchTimers) {
      await t.dispose();
    }
    for (final p in _audioPlayers) {
      await p?.dispose();
    }
    super.dispose();
  }
}
