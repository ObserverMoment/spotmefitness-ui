import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/cards/logged_workout_section_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class LoggedWorkoutDetailsPage extends StatelessWidget {
  final String id;
  LoggedWorkoutDetailsPage({@PathParam('id') required this.id});

  void _updateCompletedOn(LoggedWorkoutCreatorBloc bloc, DateTime date) {
    bloc.updateCompletedOn(date);
  }

  Future<void> _deleteLoggedWorkout(BuildContext context) async {
    await context.showConfirmDialog(
        title: 'Delete this workout log?',
        content: MyText(
          'This cannot be undone.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Deleting...',
              icon: Icon(
                CupertinoIcons.delete_simple,
                color: Styles.errorRed,
              ));

          final result = await context.graphQLStore
              .delete<DeleteLoggedWorkoutById$Mutation, json.JsonSerializable>(
            typename: kLoggedWorkoutTypename,
            objectId: id,
            mutation: DeleteLoggedWorkoutByIdMutation(
              variables: DeleteLoggedWorkoutByIdArguments(id: id),
            ),
            clearQueryDataAtKeys: [
              getParameterizedQueryId(LoggedWorkoutByIdQuery(
                  variables: LoggedWorkoutByIdArguments(id: id)))
            ],
            removeRefFromQueries: [GQLNullVarsKeys.userLoggedWorkoutsQuery],
          );
          context.pop(); // The showLoadingAlert

          if (result.hasErrors) {
            context.showErrorAlert(
                'Something went wrong, the log was not deleted correctly');
          } else {
            context.pop(); // The screen.
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final query =
        LoggedWorkoutByIdQuery(variables: LoggedWorkoutByIdArguments(id: id));

    return QueryObserver<LoggedWorkoutById$Query, LoggedWorkoutByIdArguments>(
        key: Key('LoggedWorkoutDetailsPage - ${query.operationName}'),
        query: query,
        parameterizeQuery: true,
        fetchPolicy: QueryFetchPolicy.networkOnly,
        loadingIndicator: ShimmerDetailsPage(title: 'Finding log...'),
        builder: (data) {
          final log = data.loggedWorkoutById;

          return MyText('Logged Workout Details');

          // return ChangeNotifierProvider(
          //   create: (context) => LoggedWorkoutCreatorBloc(
          //       context: context, initialLoggedWorkout: log),
          //   builder: (context, child) {
          //     final bloc = context.read<LoggedWorkoutCreatorBloc>();

          //     final sortedSections = context
          //         .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
          //             (b) => b.loggedWorkout.loggedWorkoutSections)
          //         .sortedBy<num>((s) => s.sortPosition);

          //     final workoutGoals =
          //         context.select<LoggedWorkoutCreatorBloc, List<WorkoutGoal>>(
          //             (b) => b.loggedWorkout.workoutGoals);

          //     final name = context.select<LoggedWorkoutCreatorBloc, String>(
          //         (b) => b.loggedWorkout.name);

          //     final note = context.select<LoggedWorkoutCreatorBloc, String?>(
          //         (b) => b.loggedWorkout.note);

          //     final gymProfile =
          //         context.select<LoggedWorkoutCreatorBloc, GymProfile?>(
          //             (b) => b.loggedWorkout.gymProfile);

          //     final completedOn =
          //         context.select<LoggedWorkoutCreatorBloc, DateTime>(
          //             (b) => b.loggedWorkout.completedOn);

          //     return MyPageScaffold(
          //       navigationBar: MyNavBar(
          //         middle: NavBarTitle(log.name),
          //         trailing: CupertinoButton(
          //           padding: EdgeInsets.zero,
          //           child: Icon(CupertinoIcons.ellipsis),
          //           onPressed: () => openBottomSheetMenu(
          //               context: context,
          //               child: BottomSheetMenu(
          //                   header: BottomSheetMenuHeader(
          //                     name: name,
          //                     subtitle: 'Logged Workout',
          //                   ),
          //                   items: [
          //                     /// TODO.
          //                     // BottomSheetMenuItem(
          //                     //     text: 'Share',
          //                     //     icon: Icon(CupertinoIcons.paperplane),
          //                     //     onPressed: () => SharingAndLinking
          //                     //         .shareImageRenderOfWidget(
          //                     //             padding: const EdgeInsets.all(16),
          //                     //             context: context,
          //                     //             text: 'Just nailed this workout!',
          //                     //             subject: 'Just nailed this workout!',
          //                     //             widgetForImageCapture:
          //                     //                 _buildLoggedWorkoutSummaryForSharing(
          //                     //                     sortedSections))),
          //                     /// TODO.
          //                     // BottomSheetMenuItem(
          //                     //     text: 'View workout',
          //                     //     icon: Icon(CupertinoIcons.arrow_right_square),
          //                     //     onPressed: () =>
          //                     //         print('view original workout')),

          //                     /// TODO.
          //                     // BottomSheetMenuItem(
          //                     //     text: 'Export',
          //                     //     icon: Icon(CupertinoIcons.download_circle),
          //                     //     onPressed: () => print('export')),
          //                     BottomSheetMenuItem(
          //                         text: 'Delete',
          //                         icon: Icon(
          //                           CupertinoIcons.delete_simple,
          //                           color: Styles.errorRed,
          //                         ),
          //                         isDestructive: true,
          //                         onPressed: () =>
          //                             _deleteLoggedWorkout(context)),
          //                   ])),
          //         ),
          //       ),
          //       child: ListView(
          //         shrinkWrap: true,
          //         children: [
          //           Column(
          //             children: [
          //               UserInputContainer(
          //                 child: DateTimePickerDisplay(
          //                   dateTime: completedOn,
          //                   saveDateTime: (d) => _updateCompletedOn(bloc, d),
          //                 ),
          //               ),
          //               UserInputContainer(
          //                 child: GymProfileSelectorDisplay(
          //                   clearGymProfile: () => bloc.updateGymProfile(null),
          //                   gymProfile: gymProfile,
          //                   selectGymProfile: bloc.updateGymProfile,
          //                 ),
          //               ),
          //               UserInputContainer(
          //                 child: EditableTextAreaRow(
          //                   title: 'Note',
          //                   text: note ?? '',
          //                   onSave: (t) => bloc.updateNote(t),
          //                   inputValidation: (t) => true,
          //                   maxDisplayLines: 6,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           if (workoutGoals.isNotEmpty)
          //             UserInputContainer(
          //               child: Wrap(
          //                 spacing: 6,
          //                 runSpacing: 6,
          //                 children: workoutGoals
          //                     .map((goal) => Tag(tag: goal.name))
          //                     .toList(),
          //               ),
          //             ),
          //           if (sortedSections.isNotEmpty)
          //             ...sortedSections
          //                 .map((s) => Padding(
          //                       padding:
          //                           const EdgeInsets.symmetric(vertical: 6.0),
          //                       child: LoggedWorkoutSectionCard(
          //                           loggedWorkoutSection: s),
          //                     ))
          //                 .toList(),
          //         ],
          //       ),
          //     );
          //   },
          // );
        });
  }
}
