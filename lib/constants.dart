const kBodyweightEquipmentId = 'b95da267-c036-4caa-9294-d1fab9b3d2e8';
const kRestMoveId = '975a5da2-12c7-40d6-b666-eed713f0dadd';

const kFullScreenImageViewerHeroTag = 'kFullScreenImageViewerHeroTag';
const kMiniButtonIconSize = 24.0;
const kWorkoutMoveListItemHeight = 65.0;

/// QueryNames
/// TODO: Move to using new syntax like QueryName().operationName
const kGymProfilesQuery = 'gymProfiles';
const kAuthedUserQuery = 'authedUser';
const kUserWorkoutsQuery = 'userWorkouts';
const kUserCustomMovesQuery = 'userCustomMoves';
const kUserWorkoutTagsQuery = 'userWorkoutTags';
const kWorkoutByIdQuery = 'workoutById';

/// Object Type names for the store.
/// For use in [__typename:id] normalization and store ops.
const kGymProfileTypename = 'GymProfile';
const kUserTypename = 'User';
const kWorkoutTypename = 'Workout';
const kScheduledWorkoutTypename = 'ScheduledWorkout';
const kWorkoutSectionTypename = 'WorkoutSection';
const kWorkoutSetTypename = 'WorkoutSet';
const kWorkoutMoveTypename = 'WorkoutMove';

const kLoggedWorkoutSetTypename = 'LoggedWorkoutSet';

const kExcludeFromNormalization = [
  kWorkoutSectionTypename,
  kWorkoutSetTypename,
  kWorkoutMoveTypename
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

/// Move Filters ///
const String kSettingsHiveBoxMoveFiltersKey = 'move_filters';
