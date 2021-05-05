const kBodyweightEquipmentId = 'b95da267-c036-4caa-9294-d1fab9b3d2e8';
const kRestMoveId = '975a5da2-12c7-40d6-b666-eed713f0dadd';

const kFullScreenImageViewerHeroTag = 'kFullScreenImageViewerHeroTag';
const kMiniButtonIconSize = 24.0;
const kWorkoutMoveListItemHeight = 65.0;

/// QueryNames
const kGymProfilesQuery = 'gymProfiles';
const kAuthedUserQuery = 'authedUser';
const kUserWorkoutsQuery = 'userWorkouts';

/// Object Type names for the store.
/// For use in [__typename:id] normalization and store ops.
const kGymProfileType = 'GymProfile';
const kUserType = 'User';
const kWorkoutType = 'Workout';
const kWorkoutSectionType = 'WorkoutSection';
const kWorkoutSetType = 'WorkoutSet';
const kWorkoutMoveType = 'WorkoutMove';

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
