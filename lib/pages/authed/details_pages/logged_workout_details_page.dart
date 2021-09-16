import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator_with_sections.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Very simlar to the LoggedWorkoutCreator.
/// Shares most of its components and logic is handled by [LoggedWorkoutCreatorBloc].
class LoggedWorkoutDetailsPage extends StatelessWidget {
  final String id;
  LoggedWorkoutDetailsPage({@PathParam('id') required this.id});

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

  /// Saves all changes to the global graphql store once the user is done with this spage.
  void _handleSaveAndClose(BuildContext context) {
    context.read<LoggedWorkoutCreatorBloc>().writeAllChangesToStore();
    context.pop();
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
          final loggedWorkout = data.loggedWorkoutById;

          return ChangeNotifierProvider(
            create: (context) => LoggedWorkoutCreatorBloc(
              context: context,
              prevLoggedWorkout: loggedWorkout,
            ),
            builder: (context, child) {
              return MyPageScaffold(
                  navigationBar: MyNavBar(
                    customLeading: NavBarBackButtonStandalone(
                      onPressed: () => _handleSaveAndClose(context),
                    ),
                    middle: NavBarTitle(loggedWorkout.name),
                    trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(CupertinoIcons.ellipsis),
                        onPressed: () => openBottomSheetMenu(
                            context: context,
                            child: BottomSheetMenu(
                                header: BottomSheetMenuHeader(
                                  name: loggedWorkout.name,
                                  subtitle: 'Logged Workout',
                                ),
                                items: [
                                  /// TODO.
                                  // BottomSheetMenuItem(
                                  //     text: 'Share',
                                  //     icon: Icon(CupertinoIcons.paperplane),
                                  //     onPressed: () => SharingAndLinking
                                  //         .shareImageRenderOfWidget(
                                  //             padding: const EdgeInsets.all(16),
                                  //             context: context,
                                  //             text: 'Just nailed this workout!',
                                  //             subject: 'Just nailed this workout!',
                                  //             widgetForImageCapture:
                                  //                 _buildLoggedWorkoutSummaryForSharing(
                                  //                     sortedSections))),
                                  // TODO. Not yet querying for workout or workoutId when retrieving the loggedWorkout.
                                  // BottomSheetMenuItem(
                                  //     text: 'View workout',
                                  //     icon: Icon(
                                  //         CupertinoIcons.arrow_right_square),
                                  //     onPressed: () =>
                                  //         print('view original workout')),
                                  BottomSheetMenuItem(
                                      text: 'Delete',
                                      icon: Icon(
                                        CupertinoIcons.delete_simple,
                                        color: Styles.errorRed,
                                      ),
                                      isDestructive: true,
                                      onPressed: () =>
                                          _deleteLoggedWorkout(context)),
                                ]))),
                  ),
                  child: LoggedWorkoutCreatorWithSections());
            },
          );
        });
  }
}
