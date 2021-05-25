import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/scheduled_workout/scheduled_workout_creator.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/model/toast_request.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String id;
  WorkoutDetailsPage({@PathParam('id') required this.id});

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  int _activeSectionTabIndex = 0;
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  final _kthumbDisplaySize = Size(80, 80);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_activeSectionTabIndex != _pageController.page!.round()) {
        setState(() {
          _activeSectionTabIndex = _pageController.page!.round();
        });
      }
    });
  }

  void _handleTabChange(int index) {
    if (_pageController.page != index) {
      _pageController.jumpToPage(index);
    }
    setState(() => _activeSectionTabIndex = index);
  }

  Future<void> _copyWorkout(String id) async {
    await context.showConfirmDialog(
        title: 'Make a copy of this Workout?',
        content: MyText(
          'Note: Any media on this workout will not be copied across.',
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Making a copy...',
              icon: Icon(CupertinoIcons.doc_on_doc));
          final result = await context.graphQLStore.create<
                  DuplicateWorkoutById$Mutation, DuplicateWorkoutByIdArguments>(
              mutation: DuplicateWorkoutByIdMutation(
                  variables: DuplicateWorkoutByIdArguments(id: id)),
              addRefToQueries: [UserWorkoutsQuery().operationName]);

          if (result.hasErrors) {
            context.pop(); // The showLoadingAlert
            context.showErrorAlert(
                'Something went wrong, the workout was not duplicated correctly.');
          } else {
            context.pop(); // The showLoadingAlert
            context.pop(
                result: ToastRequest(
                    type: ToastType.success,
                    message:
                        'Workout copy created.')); // Main screen - back to userWorkouts
          }
        });
  }

  Future<void> _openScheduleWorkout(Workout workout) async {
    final result = await context.showBottomSheet(
        showDragHandle: false,
        child: ScheduledWorkoutCreator(
          workout: workout,
        ));
    if (result is ToastRequest) {
      context.showToast(message: result.message, toastType: result.type);
    }
  }

  Future<void> _archiveWorkout(String id) async {
    await context.showConfirmDialog(
        title: 'Archive this workout?',
        content: MyText(
          'It will be moved to your archive where it can be retrieved if needed.',
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Archiving...',
              icon: Icon(
                CupertinoIcons.archivebox,
                color: Styles.errorRed,
              ));

          final result = await context.graphQLStore
              .mutate<UpdateWorkout$Mutation, UpdateWorkoutArguments>(
                  mutation: UpdateWorkoutMutation(
                    variables: UpdateWorkoutArguments(
                        data: UpdateWorkoutInput(id: id, archived: true)),
                  ),
                  removeRefFromQueries: [
                UserWorkoutsQuery().operationName
              ],
                  broadcastQueryIds: [
                getParameterizedQueryId(WorkoutByIdQuery(
                    variables: WorkoutByIdArguments(id: widget.id)))
              ],
                  customVariablesMap: {
                'data': {'id': id, 'archived': true}
              });

          if (result.hasErrors) {
            context.pop(); // The showLoadingAlert
            context.showErrorAlert(
                'Something went wrong, the workout was not archived correctly');
          } else {
            context.pop(); // The showLoadingAlert
            context.showToast(
                message: 'Workout archived.', toastType: ToastType.destructive);
          }
        });
  }

  Future<void> _unarchiveWorkout(String id) async {
    await context.showConfirmDialog(
        title: 'Unarchive this workout?',
        content: MyText(
          'It will be moved back into your workouts.',
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Unarchiving...',
              icon: Icon(
                CupertinoIcons.archivebox,
                color: Styles.infoBlue,
              ));

          final result = await context.graphQLStore
              .mutate<UpdateWorkout$Mutation, UpdateWorkoutArguments>(
                  mutation: UpdateWorkoutMutation(
                    variables: UpdateWorkoutArguments(
                        data: UpdateWorkoutInput(id: id, archived: false)),
                  ),
                  addRefToQueries: [
                UserWorkoutsQuery().operationName
              ],
                  broadcastQueryIds: [
                getParameterizedQueryId(WorkoutByIdQuery(
                    variables: WorkoutByIdArguments(id: widget.id)))
              ],
                  customVariablesMap: {
                'data': {'id': id, 'archived': false}
              });

          if (result.hasErrors) {
            context.pop(); // The showLoadingAlert
            context.showErrorAlert(
                'Something went wrong, the workout was not unarchived correctly');
          } else {
            context.pop(); // The showLoadingAlert
            context.showToast(
                message: 'Workout unarchived.', toastType: ToastType.success);
          }
        });
  }

  Widget _displayName(String text) => Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: MyText(text, weight: FontWeight.bold, size: FONTSIZE.SMALL),
      );

  Widget _buildAvatar(Workout workout) {
    final radius = 40.0;

    return Row(
      children: [
        UserAvatar(
          avatarUri: workout.user.avatarUri!,
          radius: radius,
        ),
        if (workout.user.displayName != '')
          _displayName(workout.user.displayName),
        if (workout.archived)
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                CupertinoIcons.archivebox,
                color: Styles.errorRed,
              ),
            ),
          )
      ],
    );
  }

  List<String> _sectionTitles(List<WorkoutSection> sortedWorkoutSections) {
    return sortedWorkoutSections
        .map((ws) => ws.name ?? 'Section ${(ws.sortPosition + 1).toString()}')
        .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query =
        WorkoutByIdQuery(variables: WorkoutByIdArguments(id: widget.id));

    return QueryObserver<WorkoutById$Query, WorkoutByIdArguments>(
        key: Key('YourWorkoutsPage - ${query.operationName}-${widget.id}'),
        query: query,
        fetchPolicy: QueryFetchPolicy.storeAndNetwork,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Workout Details'),
        builder: (data) {
          final Workout workout = data.workoutById;

          final List<WorkoutSection> sortedWorkoutSections =
              workout.workoutSections.sortedBy<num>((ws) => ws.sortPosition);

          final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
          final bool isOwner = workout.user.id == authedUserId;

          return CupertinoPageScaffold(
            key: Key('WorkoutDetailsPage - CupertinoPageScaffold'),
            navigationBar: BasicNavBar(
              key: Key('WorkoutDetailsPage - BasicNavBar'),
              middle: NavBarTitle(workout.name),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.ellipsis_circle),
                onPressed: () => context.showBottomSheet(
                    child: BottomSheetMenu(
                        header: Row(
                          children: [
                            if (Utils.textNotNull(workout.coverImageUri))
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedUploadcareImage(
                                    workout.coverImageUri!,
                                    displaySize: Size(70, 70),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MyText(
                                    workout.name,
                                    weight: FontWeight.bold,
                                    size: FONTSIZE.BIG,
                                  ),
                                  MyText(
                                    'Workout',
                                    subtext: true,
                                    weight: FontWeight.bold,
                                    size: FONTSIZE.BIG,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        items: [
                      BottomSheetMenuItem(
                          text: 'Log',
                          icon: Icon(CupertinoIcons.graph_square),
                          onPressed: () => context.navigateTo(
                              LoggedWorkoutCreatorRoute(workout: workout))),
                      BottomSheetMenuItem(
                          text: 'Share',
                          icon: Icon(CupertinoIcons.share),
                          onPressed: () => print('share')),
                      if (isOwner)
                        BottomSheetMenuItem(
                            text: 'Edit',
                            icon: Icon(CupertinoIcons.pencil),
                            onPressed: () =>
                                context.navigateTo(WorkoutCreatorRoute())),
                      if (isOwner ||
                          workout.contentAccessScope ==
                              ContentAccessScope.public)
                        BottomSheetMenuItem(
                            text: 'Copy',
                            icon: Icon(CupertinoIcons.doc_on_doc),
                            onPressed: () => _copyWorkout(workout.id)),
                      BottomSheetMenuItem(
                          text: 'Export',
                          icon: Icon(CupertinoIcons.download_circle),
                          onPressed: () => print('export')),
                      if (isOwner)
                        BottomSheetMenuItem(
                            text: workout.archived ? 'Unarchive' : 'Archive',
                            icon: Icon(
                              CupertinoIcons.archivebox,
                              color: workout.archived ? null : Styles.errorRed,
                            ),
                            isDestructive: !workout.archived,
                            onPressed: () => workout.archived
                                ? _unarchiveWorkout(workout.id)
                                : _archiveWorkout(workout.id)),
                    ])),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAvatar(workout),
                        Row(
                          children: [
                            DoItButton(onPressed: () => print('do workout')),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => print('save to collection'),
                                child: Icon(CupertinoIcons.heart)),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _openScheduleWorkout(workout),
                              child: Icon(CupertinoIcons.calendar_badge_plus),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  HorizontalLine(),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: workout.coverImageUri != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              context.theme.cardBackground
                                                  .withOpacity(0.2),
                                              BlendMode.dstATop),
                                          image: UploadcareImageProvider(
                                              workout.coverImageUri!))
                                      : null),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        DifficultyLevelTag(
                                            workout.difficultyLevel),
                                        ...workout.workoutGoals
                                            .map((g) => Tag(tag: g.name)),
                                        ...workout.workoutTags.map((t) => Tag(
                                              tag: t.tag,
                                              color: Styles.colorOne,
                                              textColor: Styles.white,
                                            ))
                                      ].toList(),
                                    ),
                                  ),
                                  if (Utils.textNotNull(workout.description))
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: MyText(
                                        workout.description!,
                                        maxLines: 10,
                                        lineHeight: 1.3,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  if (Utils.anyNotNull([
                                    workout.introAudioUri,
                                    workout.introVideoUri
                                  ]))
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12.0, top: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (workout.introVideoUri != null)
                                            VideoThumbnailPlayer(
                                              videoUri: workout.introVideoUri,
                                              videoThumbUri:
                                                  workout.introVideoThumbUri,
                                              displaySize: _kthumbDisplaySize,
                                            ),
                                          if (workout.introAudioUri != null)
                                            AudioThumbnailPlayer(
                                              audioUri: workout.introAudioUri!,
                                              displaySize: _kthumbDisplaySize,
                                              playerTitle:
                                                  '${workout.name} - Intro',
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ])),
                        ];
                      },
                      body: Column(
                        children: [
                          HorizontalLine(),
                          if (workout.workoutSections.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: MyText('Nothing here yet...'),
                            ),
                          if (workout.workoutSections.length > 1)
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 8),
                                child: MyTabBarNav(
                                    titles:
                                        _sectionTitles(sortedWorkoutSections),
                                    handleTabChange: _handleTabChange,
                                    activeTabIndex: _activeSectionTabIndex)),
                          if (workout.workoutSections.length == 1 &&
                              Utils.textNotNull(
                                  workout.workoutSections[0].name))
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 8),
                              child: UnderlineTitle(
                                  workout.workoutSections[0].name!),
                            ),
                          if (sortedWorkoutSections.isNotEmpty)
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                children: sortedWorkoutSections
                                    .map((ws) => SingleChildScrollView(
                                        child: WorkoutDetailsSection(ws)))
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
