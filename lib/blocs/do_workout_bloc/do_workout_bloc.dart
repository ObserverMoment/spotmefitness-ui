import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/amrap_section_controller.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/timed_section_controller.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Delegates to the correct sub bloc types for each workout section
/// As required by the workoutSectionType
class DoWorkoutBloc extends ChangeNotifier {
  late BuildContext _context;
  late List<WorkoutSection> _sortedWorkoutSections;
  late LoggedWorkout loggedWorkout;

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

  DoWorkoutBloc({required BuildContext context, required Workout workout}) {
    _context = context;
    loggedWorkout = DefaultObjectfactory.defaultLoggedWorkout(workout: workout);

    _sortedWorkoutSections = workout.workoutSections
        .sortedBy<num>((wSection) => wSection.sortPosition);

    completedSections = _sortedWorkoutSections.map((wSection) => null).toList();
    startedSections = _sortedWorkoutSections.map((wSection) => false).toList();

    /// One per section.
    _stopWatchTimers =
        _sortedWorkoutSections.map((wSection) => StopWatchTimer()).toList();

    /// One per section.
    controllers = _sortedWorkoutSections
        .map((wSection) => _mapSectionTypeToControllerType(wSection))
        .toList();

    /// One per section. Create null filled list then call async function to generate the required audio players.
    _audioPlayers = _sortedWorkoutSections.map((wSection) => null).toList();
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
  void generatePartialLog() {
    startedSections.forEachIndexed((index, started) {
      if (started) {
        final sectionLog = _genLoggedWorkoutSection(index);
        loggedWorkout.loggedWorkoutSections.add(sectionLog);
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
    notifyListeners();
  }

  void resetWorkout() {
    _sortedWorkoutSections.forEach((ws) {
      final i = ws.sortPosition;
      startedSections[i] = false;
      _stopWatchTimers[i].onExecute.add(StopWatchExecute.reset);
      completedSections[i] = null;
      controllers[i].reset();
      _audioPlayers[i]?.stop();
      _audioPlayers[i]?.seek(Duration.zero);
    });
    allSectionsComplete = false;
    loggedWorkout.loggedWorkoutSections = [];
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
  }

  StopWatchTimer getStopWatchTimerForSection(int index) =>
      _stopWatchTimers[index];

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
  }

  void pauseSection(int index) {
    if (_stopWatchTimers[index].isRunning) {
      _stopWatchTimers[index].onExecute.add(StopWatchExecute.stop);
      _context.showToast(message: 'Workout Paused');
    }

    _audioPlayers[index]?.pause();
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
        return AMRAPSectionController(workoutSection: workoutSection);

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

/// Abstract parent for all workout section type sub controllers.
abstract class WorkoutSectionController {
  /// Broadcast changes to the progress state.
  StreamController<WorkoutSectionProgressState> progressStateController =
      StreamController<WorkoutSectionProgressState>.broadcast();

  Stream<WorkoutSectionProgressState> get progressStream =>
      progressStateController.stream;

  late WorkoutSectionProgressState state;

  WorkoutSectionController(WorkoutSection workoutSection) {
    state = WorkoutSectionProgressState(workoutSection);
    progressStateController.add(state);
  }

  /// The log that will be generated incrementally as the workout progresses.
  /// Can be retrieved by the [DoWorkoutBloc] at any stage to be added to the main [LoggedWorkout.loggedWorkoutSections] list.
  late LoggedWorkoutSection loggedWorkoutSection;

  void reset();

  void dispose();
}

class WorkoutSectionProgressState {
  late int _numberSets;

  /// Add a lapTime at the [currentSectionRound] and [currentSetIndex]
  void addSetLapTime(int lapTimeMs) {
    final prevSectionData = lapTimesMs[currentSectionRound.toString()] ?? {};
    final prevSetData = prevSectionData['setLapTimesMs'] ?? {};

    lapTimesMs = {
      ...lapTimesMs,
      currentSectionRound.toString(): {
        ...prevSectionData,
        'setLapTimesMs': {
          ...prevSetData,
          currentSetIndex.toString(): lapTimeMs
        },
      }
    };
  }

  void addSectionRoundLapTime(int lapTimeMs) {
    final prevSectionData = lapTimesMs[currentSectionRound.toString()] ?? {};
    lapTimesMs = {
      ...lapTimesMs,
      currentSectionRound.toString(): {
        ...prevSectionData,
        'lapTimeMs': lapTimeMs,
      }
    };
  }

  void moveToNextSet() {
    if (currentSetIndex == _numberSets - 1) {
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

  int currentSectionRound = 0;
  int currentSetIndex = 0;

  /// Shape of this map matches the shape required by the Joi validation that runs before JSON blob is saved to the DB.
  /// {
  ///   [sectionRoundNumber.toString()]: {
  ///     lapTimeMs: int, (lap time for section round)
  ///     setLapTimesMs: {
  ///       [currentSetIndex.toString()]: int (lap time for set at sortPosition [currentSetIndex] within round)
  ///     }
  ///   }
  /// }
  Map<String, Map<String, dynamic>> lapTimesMs = {};

  /// Used for timed workouts or timecaps.
  int? setTimeRemainingMs;

  /// Must be a double between 0.0 and 1.0 inclusive.
  /// How this is calculated will depend on the type of workout / workout controller.
  /// For example timed workouts are just curTime / totalTime.
  /// ForTime and Free Session workouts are based on rounds and sets complete vs total rounds and set in the workout.
  double percentComplete = 0.0;

  WorkoutSectionProgressState(WorkoutSection workoutSection) {
    _numberSets = workoutSection.workoutSets.length;
  }

  /// This is invoked each time a new state is generated.
  /// So make sure if you add any fields that they also get added to this copy method!
  WorkoutSectionProgressState.copy(WorkoutSectionProgressState o)
      : currentSectionRound = o.currentSectionRound,
        currentSetIndex = o.currentSetIndex,
        lapTimesMs = o.lapTimesMs,
        percentComplete = o.percentComplete,
        setTimeRemainingMs = o.setTimeRemainingMs;
}
