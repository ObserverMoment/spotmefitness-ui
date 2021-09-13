// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc_archived.dart';
// import 'package:spotmefitness_ui/components/buttons.dart';
// import 'package:spotmefitness_ui/components/layout.dart';
// import 'package:spotmefitness_ui/components/text.dart';
// import 'package:spotmefitness_ui/components/user_input/logging/reps_score_picker.dart';
// import 'package:spotmefitness_ui/components/user_input/pickers/date_time_pickers.dart';
// import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
// import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
// import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
// import 'package:spotmefitness_ui/constants.dart';
// import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
// import 'package:spotmefitness_ui/extensions/context_extensions.dart';
// import 'package:spotmefitness_ui/extensions/type_extensions.dart';
// import 'package:spotmefitness_ui/services/data_utils.dart';
// import 'package:spotmefitness_ui/services/utils.dart';
// import 'package:provider/provider.dart';

// class LoggedWorkoutCreatorMeta extends StatefulWidget {
//   @override
//   _LoggedWorkoutCreatorMetaState createState() =>
//       _LoggedWorkoutCreatorMetaState();
// }

// class _LoggedWorkoutCreatorMetaState extends State<LoggedWorkoutCreatorMeta> {
//   late LoggedWorkoutCreatorBloc _bloc;

//   @override
//   void initState() {
//     super.initState();
//     _bloc = context.read<LoggedWorkoutCreatorBloc>();
//   }

//   void _updateCompletedOnDate(DateTime date) {
//     _bloc.updateCompletedOn(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final includedSectionIds =
//         context.select<LoggedWorkoutCreatorBloc, List<String>>(
//             (b) => b.includedSectionIds);

//     final loggedWorkoutSections =
//         context.select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
//             (b) => b.loggedWorkout.loggedWorkoutSections);

//     final note = context
//         .select<LoggedWorkoutCreatorBloc, String?>((b) => b.loggedWorkout.note);

//     final gymProfile = context.select<LoggedWorkoutCreatorBloc, GymProfile?>(
//         (b) => b.loggedWorkout.gymProfile);

//     final completedOn = context.select<LoggedWorkoutCreatorBloc, DateTime>(
//         (b) => b.loggedWorkout.completedOn);

//     return Column(
//       children: [
//         DateTimePickerDisplay(
//           dateTime: completedOn,
//           saveDateTime: _updateCompletedOnDate,
//         ),
//         GymProfileSelectorDisplay(
//           clearGymProfile: () => _bloc.updateGymProfile(null),
//           gymProfile: gymProfile,
//           selectGymProfile: _bloc.updateGymProfile,
//         ),
//         EditableTextAreaRow(
//           title: 'Note',
//           text: note ?? '',
//           onSave: (t) => _bloc.updateNote(t),
//           inputValidation: (t) => true,
//           maxDisplayLines: 6,
//         ),
//         HorizontalLine(),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: MyText(
//             'Select sections to include',
//             weight: FontWeight.bold,
//           ),
//         ),
//         Flexible(
//           child: ListView.separated(
//               itemBuilder: (c, i) => IncludeWorkoutSectionSelector(
//                     loggedWorkoutSection: loggedWorkoutSections[i],
//                     isSelected: includedSectionIds
//                         .contains(loggedWorkoutSections[i].id),
//                     toggleSelection: () =>
//                         _bloc.toggleIncludeSection(loggedWorkoutSections[i]),
//                   ),
//               separatorBuilder: (c, i) => HorizontalLine(),
//               itemCount: loggedWorkoutSections.length),
//         ),
//       ],
//     );
//   }
// }

// class IncludeWorkoutSectionSelector extends StatelessWidget {
//   final LoggedWorkoutSection loggedWorkoutSection;
//   final bool isSelected;
//   final void Function() toggleSelection;
//   IncludeWorkoutSectionSelector(
//       {required this.loggedWorkoutSection,
//       required this.isSelected,
//       required this.toggleSelection});

//   void _updateScore(BuildContext context, int repScore) {
//     context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
//         loggedWorkoutSection.sortPosition, {'repScore': repScore});
//   }

//   void _updateDuration(BuildContext context, int timeTakenMs) {
//     context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
//         loggedWorkoutSection.sortPosition, {'timeTakenMs': timeTakenMs});
//   }

//   void _toggleSelection(BuildContext context) {
//     if (isSelected) {
//       toggleSelection();
//     } else {
//       if (kAMRAPName == loggedWorkoutSection.workoutSectionType.name &&
//           loggedWorkoutSection.repScore == null) {
//         context.showBottomSheet(
//             expand: false,
//             child: RepsScorePicker(
//               score: loggedWorkoutSection.repScore,
//               section: loggedWorkoutSection,
//               updateScore: (score) {
//                 toggleSelection();
//                 _updateScore(context, score);
//               },
//             ));
//       } else if ([kFreeSessionName, kForTimeName]
//               .contains(loggedWorkoutSection.workoutSectionType.name) &&
//           loggedWorkoutSection.timeTakenMs == null) {
//         context.showBottomSheet(
//             expand: false,
//             child: DurationPicker(
//               duration: null,
//               updateDuration: (duration) {
//                 _updateDuration(context, duration.inMilliseconds);
//                 toggleSelection();
//               },
//               title: 'Workout duration?',
//             ));
//       } else {
//         toggleSelection();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: MyText(
//                     Utils.textNotNull(loggedWorkoutSection.name)
//                         ? loggedWorkoutSection.name!
//                         : '${loggedWorkoutSection.sortPosition + 1}. ${loggedWorkoutSection.workoutSectionType.name}',
//                     subtext: !isSelected,
//                   ),
//                 ),
//               ),
//               AnimatedOpacity(
//                 duration: Duration(milliseconds: 250),
//                 opacity: isSelected ? 1 : 0.5,
//                 child: Row(
//                   children: [
//                     if ([kEMOMName, kHIITCircuitName, kTabataName]
//                         .contains(loggedWorkoutSection.workoutSectionType.name))
//                       MyText(
//                         'Duration: ${DataUtils.calculateTimedLoggedSectionDuration(loggedWorkoutSection).compactDisplay()}',
//                         weight: FontWeight.bold,
//                       ),
//                     if (kAMRAPName ==
//                         loggedWorkoutSection.workoutSectionType.name)
//                       RepsScoreDisplay<LoggedWorkoutSection>(
//                         score: loggedWorkoutSection.repScore,
//                         section: loggedWorkoutSection,
//                         updateScore: (int score) =>
//                             _updateScore(context, score),
//                       ),
//                     if ([kForTimeName, kFreeSessionName]
//                         .contains(loggedWorkoutSection.workoutSectionType.name))
//                       DurationPickerDisplay(
//                         modalTitle: 'Workout Duration',
//                         duration: loggedWorkoutSection.timeTakenMs != null
//                             ? Duration(
//                                 milliseconds: loggedWorkoutSection.timeTakenMs!)
//                             : null,
//                         updateDuration: (duration) =>
//                             _updateDuration(context, duration.inMilliseconds),
//                       )
//                   ],
//                 ),
//               ),
//               CircularCheckbox(
//                   onPressed: (_) => _toggleSelection(context),
//                   isSelected: isSelected)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
