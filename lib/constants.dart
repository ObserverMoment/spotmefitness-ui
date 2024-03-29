import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';

/// Deep Linking schema.
/// Standard sharing format should be:
/// [kDeepLinkSchema][route] - where the user will be routed to the named route [route]
/// E.g. ['spotmefitness://workout/{workoutId}']
const kDeepLinkSchema = 'spotmefitness://';

/// When generating an image to share with a link or other content, this is the temp location where it should be stored.
const kTempShareImageFileName = 'temp-share-image.png';

const kBodyweightEquipmentId = 'b95da267-c036-4caa-9294-d1fab9b3d2e8';
const kRestMoveId = '975a5da2-12c7-40d6-b666-eed713f0dadd';

/// Layout
const kAssumedDefaultTopNotchHeight = 54.0;
const kAssumedFloatingButtonHeight = 68.0;
const kDockedAudioPlayerHeight = 64.0;
const kMiniButtonIconSize = 26.0;
const kWorkoutMoveListItemHeight = 65.0;

const kDefaultTagHeight = 28.0;
const kDefaultTagPadding = EdgeInsets.symmetric(horizontal: 11, vertical: 6);

const kFullScreenImageViewerHeroTag = 'FullScreenImageViewerHeroTag';

const kStandardCardPadding = EdgeInsets.symmetric(vertical: 8, horizontal: 12);
const kCardBorderRadiusValue = 8.0;
final kStandardCardBorderRadius = BorderRadius.circular(kCardBorderRadiusValue);

const kStandardAnimationDuration = Duration(milliseconds: 250);

/// Object Type names for the store.
/// For use in [__typename:id] normalization and store ops.
const kCollectionTypename = 'Collection';
const kClubTypeName = 'Club';
const kClubInviteTokenTypeName = 'ClubInviteToken';
const kBodyTransformationPhotoTypename = 'BodyTransformationPhoto';
const kGymProfileTypename = 'GymProfile';
const kMoveTypename = 'Move';
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
const kUserBenchmarkTagTypename = 'UserBenchmarkTag';

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
const kAMRAPName = 'AMRAP';
const kTabataName = 'Tabata Style';

/// Do Workout Settings
const kSectionTypesWithFinishLine = [
  kForTimeName,
  kHIITCircuitName,
  kEMOMName,
  kTabataName,
  kFreeSessionName
];

/// BodyArea selector SVG viewbox sizes.
/// Required to correctly render custom path clips on top of graphical SVG elements.
const double kBodyAreaSelectorSvgWidth = 93.6;
const double kBodyAreaSelectorSvgHeight = 213.43;

/// GetStream Chat ///
const String kMessagingChannelName = 'messaging';
const String kClubMembersChannelName = 'club_members';

/// GetStream Feeds ///
// Global user posts which are open to all
const String kUserPostVerbName = 'post';
// Posts to club feeds - they are private.
const String kClubMembersPostVerbName = 'club-post';

const String kUserFeedName = 'user_feed'; // Post to this.
const String kUserTimelineName =
    'user_timeline'; // View this / follow other feeds with this.
const String kUserNotificationName =
    'user_notification'; // System notifications
const String kClubMembersFeedName =
    'club_members_feed'; // Club members can follow this (optionally) with their timeline.
const String kLikeReactionName = 'like'; // Activity reaction type.
const String kShareReactionName = 'share'; // Activity reaction type.

/// Hive
const String kSettingsHiveBoxName = 'settings_box';

/// Theme ///
const String kSettingsHiveBoxThemeKey = 'theme_name';
const String kSettingsLightThemeKey = 'light';
const String kSettingsDarkThemeKey = 'dark';

/// Journal Entry Scoring ///
const Color kGoodScoreColor = Styles.infoBlue;
const Color kBadScoreColor = Styles.errorRed;

/// Move Filters ///
const String kSettingsHiveBoxMoveFiltersKey = 'move_filters';
const String kSettingsHiveBoxWorkoutFiltersKey = 'workout_filters';
const String kSettingsHiveBoxWorkoutPlanFiltersKey = 'workout_plan_filters';

/// Messages ///
const String kDefaultErrorMessage = "Sorry, that didn't work";
