import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';

const kBodyweightEquipmentId = 'b95da267-c036-4caa-9294-d1fab9b3d2e8';
const kRestMoveId = '975a5da2-12c7-40d6-b666-eed713f0dadd';

/// Layout
const kAssumedDefaultTopNotchHeight = 54.0;
const kAssumedFloatingButtonHeight = 72.0;
const kBottomNavBarHeight = 68.0;
const kMiniButtonIconSize = 24.0;
const kWorkoutMoveListItemHeight = 65.0;
const kFullScreenImageViewerHeroTag = 'FullScreenImageViewerHeroTag';

const kStandardAnimationDuration = const Duration(milliseconds: 250);

/// Object Type names for the store.
/// For use in [__typename:id] normalization and store ops.
const kCollectionTypename = 'Collection';
const kGymProfileTypename = 'GymProfile';
const kUserTypename = 'User';
const kWorkoutTypename = 'Workout';
const kWorkoutTagTypename = 'WorkoutTag';
const kScheduledWorkoutTypename = 'ScheduledWorkout';
const kWorkoutSectionTypename = 'WorkoutSection';
const kWorkoutSectionTypeTypename = 'WorkoutSectionType';
const kWorkoutSetTypename = 'WorkoutSet';
const kWorkoutMoveTypename = 'WorkoutMove';

const kWorkoutPlanTypename = 'WorkoutPlan';
const kWorkoutPlanEnrolmentTypename = 'WorkoutPlanEnrolment';
const kWorkoutPlanReviewTypename = 'WorkoutPlanReview';

const kLoggedWorkoutTypename = 'LoggedWorkout';
const kLoggedWorkoutSectionTypename = 'LoggedWorkoutSection';
const kLoggedWorkoutSetTypename = 'LoggedWorkoutSet';
const kLoggedWorkoutMoveTypename = 'LoggedWorkoutMove';

const kProgressJournalTypename = 'ProgressJournal';
const kProgressJournalEntryTypename = 'ProgressJournalEntry';
const kProgressJournalGoalTypename = 'ProgressJournalGoal';
const kProgressJournalGoalTagTypename = 'ProgressJournalGoalTag';

const kUserBenchmarkTypename = 'UserBenchmark';
const kUserBenchmarkEntryTypename = 'UserBenchmarkEntry';

const kExcludeFromNormalization = [
  kWorkoutSectionTypename,
  kWorkoutSetTypename,
  kWorkoutMoveTypename,
  kLoggedWorkoutSectionTypename,
  kLoggedWorkoutSetTypename,
  kLoggedWorkoutMoveTypename,
  kWorkoutPlanReviewTypename
];

/// WorkoutSectionTypeNames
const kFreeSessionName = 'Free Session';
const kHIITCircuitName = 'HIIT Circuit';
const kForTimeName = 'For Time';
const kEMOMName = 'EMOM';
const kLastStandingName = 'Last One Standing';
const kAMRAPName = 'AMRAP';
const kTabataName = 'Tabata Style';

/// BodyArea selector SVG viewbox sizes.
/// Required to correctly render custom path clips on top of graphical SVG elements.
const double kBodyAreaSelector_svg_width = 93.6;
const double kBodyAreaSelector_svg_height = 213.43;

/// Hive
const String kSettingsHiveBoxName = 'settings_box';

/// Theme ///
const String kSettingsHiveBoxThemeKey = 'theme_name';
const String kSettingsLightThemeKey = 'light';
const String kSettingsDarkThemeKey = 'dark';

/// Journal Entry Scoring ///
const Color kGoodScoreColor = Styles.infoBlue;
final Color kBadScoreColor = Styles.errorRed;

/// Move Filters ///
const String kSettingsHiveBoxMoveFiltersKey = 'move_filters';
const String kSettingsHiveBoxWorkoutFiltersKey = 'workout_filters';

/// Messages ///
const String kDefaultErrorMessage = "Sorry, that didn't work";
