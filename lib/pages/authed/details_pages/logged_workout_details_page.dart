import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/cards/logged_wokout_section_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_details_editable.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class LoggedWorkoutDetailsPage extends StatelessWidget {
  final String id;
  LoggedWorkoutDetailsPage({@PathParam('id') required this.id});

  void _updateCompletedOn(LoggedWorkoutCreatorBloc bloc, DateTime date) {
    bloc.updateCompletedOn(date);
  }

  Widget _buildLoggedWorkoutSummaryForSharing(
      List<LoggedWorkoutSection> sortedSections) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: sortedSections
          .map((s) => Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(
                        Utils.textNotNull(s.name)
                            ? s.name!
                            : 'Section ${(s.sortPosition + 1).toString()}',
                        weight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: LoggedWorkoutSectionSummaryCard(
                        loggedWorkoutSection: s,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Future<void> _deleteLoggedWorkout(BuildContext context) async {
    await context.showConfirmDialog(
        title: 'Delete this workout log?',
        content: MyText(
          'This cannot be undone.',
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

  Future<void> _deleteLoggedWorkoutSection(
      LoggedWorkoutCreatorBloc bloc, int sectionIndex) async {
    await bloc.deleteLoggedWorkoutSection(sectionIndex);
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

          return ChangeNotifierProvider(
            create: (context) => LoggedWorkoutCreatorBloc(
                context: context, initialLoggedWorkout: log),
            builder: (context, child) {
              final bloc = context.read<LoggedWorkoutCreatorBloc>();

              final sortedSections = context
                  .select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
                      (b) => b.loggedWorkout.loggedWorkoutSections)
                  .sortedBy<num>((s) => s.sortPosition);

              final name = context.select<LoggedWorkoutCreatorBloc, String>(
                  (b) => b.loggedWorkout.name);

              final note = context.select<LoggedWorkoutCreatorBloc, String?>(
                  (b) => b.loggedWorkout.note);

              final gymProfile =
                  context.select<LoggedWorkoutCreatorBloc, GymProfile?>(
                      (b) => b.loggedWorkout.gymProfile);

              final completedOn =
                  context.select<LoggedWorkoutCreatorBloc, DateTime>(
                      (b) => b.loggedWorkout.completedOn);

              return MyPageScaffold(
                key: Key('LoggedWorkoutDetailsPage - CupertinoPageScaffold'),
                navigationBar: BorderlessNavBar(
                  key: Key('LoggedWorkoutDetailsPage - BasicNavBar'),
                  middle: NavBarTitle(log.name),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(CupertinoIcons.ellipsis),
                    onPressed: () => openBottomSheetMenu(
                        context: context,
                        child: BottomSheetMenu(
                            header: BottomSheetMenuHeader(
                              name: name,
                              subtitle: 'Logged Workout',
                            ),
                            items: [
                              BottomSheetMenuItem(
                                  text: 'Share',
                                  icon: Icon(CupertinoIcons.paperplane),
                                  onPressed: () => SharingAndLinking
                                      .shareImageRenderOfWidget(
                                          padding: const EdgeInsets.all(16),
                                          context: context,
                                          text: 'Just nailed this workout!',
                                          subject: 'Just nailed this workout!',
                                          widgetForImageCapture:
                                              _buildLoggedWorkoutSummaryForSharing(
                                                  sortedSections))),
                              BottomSheetMenuItem(
                                  text: 'Export',
                                  icon: Icon(CupertinoIcons.download_circle),
                                  onPressed: () => print('export')),
                              BottomSheetMenuItem(
                                  text: 'Delete',
                                  icon: Icon(
                                    CupertinoIcons.delete_simple,
                                    color: Styles.errorRed,
                                  ),
                                  isDestructive: true,
                                  onPressed: () =>
                                      _deleteLoggedWorkout(context)),
                            ])),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        DateTimePickerDisplay(
                          dateTime: completedOn,
                          saveDateTime: (d) => _updateCompletedOn(bloc, d),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TappableRow(
                                onTap: () => context.push(
                                    child: GymProfileSelector(
                                  selectedGymProfile: gymProfile,
                                  selectGymProfile: (p) =>
                                      bloc.updateGymProfile(p),
                                )),
                                title: 'Gym Profile',
                                display: gymProfile == null
                                    ? MyText(
                                        'Select...',
                                        subtext: true,
                                      )
                                    : MyText(gymProfile.name),
                              ),
                            ),
                            if (gymProfile != null)
                              FadeIn(
                                child: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      CupertinoIcons.clear_thick,
                                      color: Styles.errorRed,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        bloc.updateGymProfile(null)),
                              )
                          ],
                        ),
                        EditableTextAreaRow(
                          title: 'Note',
                          text: note ?? '',
                          onSave: (t) => bloc.updateNote(t),
                          inputValidation: (t) => true,
                          maxDisplayLines: 6,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: MyText(
                        'Logged Sections',
                        weight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    HorizontalLine(verticalPadding: 0),
                    ...sortedSections
                        .map((s) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (c) => ChangeNotifierProvider.value(
                                        value: context
                                            .read<LoggedWorkoutCreatorBloc>(),
                                        child:
                                            LoggedWorkoutSectionDetailsEditable(
                                                s.sortPosition)))),
                            child: AnimatedSlidable(
                                key: Key('Index - ${s.sortPosition} - ${s.id}'),
                                child: _LoggedWorkoutSectionSummary(s),
                                removeItem: (index) =>
                                    _deleteLoggedWorkoutSection(bloc, index),
                                secondaryActions: [],
                                index: s.sortPosition,
                                confirmMessage:
                                    'This cannot be undone. Are you sure?',
                                itemType: 'Logged Section')))
                        .toList()
                  ],
                ),
              );
            },
          );
        });
  }
}

class _LoggedWorkoutSectionSummary extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final bool showBodyAreas;
  _LoggedWorkoutSectionSummary(this.loggedWorkoutSection,
      {this.showBodyAreas = true});
  @override
  Widget build(BuildContext context) {
    Set<BodyArea> bodyAreas = {};
    Set<MoveType> moveTypes = {};

    for (final workoutSet in loggedWorkoutSection.loggedWorkoutSets) {
      for (final workoutMove in workoutSet.loggedWorkoutMoves) {
        bodyAreas.addAll(workoutMove.move.bodyAreaMoveScores
            .map((bams) => bams.bodyArea)
            .toList());
        moveTypes.add(workoutMove.move.moveType);
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoggedWorkoutSectionSummaryTag(
                  loggedWorkoutSection,
                ),
              ),
              if (Utils.textNotNull(loggedWorkoutSection.name))
                MyText(
                  '"${loggedWorkoutSection.name!}"',
                  lineHeight: 1.5,
                  weight: FontWeight.bold,
                ),
              if (Utils.textNotNull(loggedWorkoutSection.note))
                MyText(
                  loggedWorkoutSection.note!,
                  lineHeight: 1.5,
                  maxLines: 3,
                  size: FONTSIZE.SMALL,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      ...moveTypes
                          .map((moveType) => Tag(
                                tag: moveType.name,
                                withBorder: true,
                                color: context.theme.background,
                                textColor: context.theme.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                              ))
                          .toList(),
                    ]),
              ),
              if (showBodyAreas)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        ...bodyAreas
                            .map((bodyArea) => Tag(
                                tag: bodyArea.name,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4)))
                            .toList(),
                      ]),
                ),
            ],
          ),
        ),
        HorizontalLine(verticalPadding: 0)
      ],
    );
  }
}
