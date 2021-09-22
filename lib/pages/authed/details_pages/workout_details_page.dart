import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/animated_like_heart.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/collections/collection_manager.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:sofie_ui/components/media/images/user_avatar.dart';
import 'package:sofie_ui/components/media/video/video_thumbnail_player.dart';
import 'package:sofie_ui/components/navigation.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:sofie_ui/components/workout/workout_section_display.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/enum.dart';
import 'package:sofie_ui/model/toast_request.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/graphql_operation_names.dart';
import 'package:sofie_ui/services/sharing_and_linking.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String id;
  const WorkoutDetailsPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  int _activeSectionTabIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  final _kthumbDisplaySize = const Size(80, 80);

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
        content: const MyText(
          'Note: Media and tags will not be copied across.',
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Making a copy...',
              icon: const Icon(CupertinoIcons.doc_on_doc));
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
    final result = await context.pushRoute(ScheduledWorkoutCreatorRoute(
      workout: workout,
    ));
    if (result is ToastRequest) {
      context.showToast(message: result.message, toastType: result.type);
    }
  }

  Future<void> _shareWorkout(Workout workout) async {
    await SharingAndLinking.shareLink(
        'workout/${workout.id}', 'Check out this workout!');
  }

  Future<void> _archiveWorkout(String id) async {
    await context.showConfirmDialog(
        title: 'Archive this workout?',
        content: const MyText(
          'It will be moved to your archive where it can be retrieved if needed.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Archiving...',
              icon: const Icon(
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
                GQLVarParamKeys.workoutByIdQuery(widget.id),
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
            context.showToast(message: 'Workout archived');
          }
        });
  }

  Future<void> _unarchiveWorkout(String id) async {
    await context.showConfirmDialog(
        title: 'Unarchive this workout?',
        content: const MyText(
          'It will be moved back into your workouts.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Unarchiving...',
              icon: const Icon(
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
                GQLVarParamKeys.workoutByIdQuery(widget.id),
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
                message: 'Workout unarchived', toastType: ToastType.success);
          }
        });
  }

  Widget _buildAvatar(Workout workout, bool isOwner) {
    const size = 36.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAvatar(
          avatarUri: workout.user.avatarUri,
          size: size,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(workout.user.displayName, size: FONTSIZE.two),
              if (isOwner)
                MyText(
                  '${workout.contentAccessScope.display} workout',
                  color: Styles.colorTwo,
                  size: FONTSIZE.one,
                  lineHeight: 1.4,
                )
            ],
          ),
        ),
        if (workout.archived)
          const FadeIn(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
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
        key: Key('WorkoutDetailsPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: const ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (workoutData) {
          return QueryObserver<UserCollections$Query, json.JsonSerializable>(
              key: Key(
                  'WorkoutDetailsPage - ${UserCollectionsQuery().operationName}'),
              query: UserCollectionsQuery(),
              fetchPolicy: QueryFetchPolicy.storeFirst,
              loadingIndicator:
                  const ShimmerDetailsPage(title: 'Getting Ready'),
              builder: (collectionsData) {
                final Workout workout = workoutData.workoutById;

                final List<Collection> collections = collectionsData
                    .userCollections
                    .where((collection) => collection.workouts
                        .map((w) => w.id)
                        .contains(workout.id))
                    .toList();

                final List<WorkoutSection> sortedWorkoutSections = workout
                    .workoutSections
                    .sortedBy<num>((ws) => ws.sortPosition);

                final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
                final bool isOwner = workout.user.id == authedUserId;

                return CupertinoPageScaffold(
                  navigationBar: MyNavBar(
                    middle: NavBarTitle(workout.name),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.ellipsis),
                      onPressed: () => openBottomSheetMenu(
                          context: context,
                          child: BottomSheetMenu(
                              header: BottomSheetMenuHeader(
                                name: workout.name,
                                subtitle: 'Workout',
                                imageUri: workout.coverImageUri,
                              ),
                              items: [
                                if (!isOwner &&
                                    workout.user.userProfileScope ==
                                        UserProfileScope.public)
                                  BottomSheetMenuItem(
                                      text: 'View creator',
                                      icon: const Icon(
                                          CupertinoIcons.profile_circled),
                                      onPressed: () => context.navigateTo(
                                          UserPublicProfileDetailsRoute(
                                              userId: workout.user.id))),
                                BottomSheetMenuItem(
                                    text: 'Log it',
                                    icon:
                                        const Icon(CupertinoIcons.graph_square),
                                    onPressed: () => context.navigateTo(
                                        LoggedWorkoutCreatorRoute(
                                            workout: workout))),
                                if (workout.contentAccessScope ==
                                    ContentAccessScope.public)
                                  BottomSheetMenuItem(
                                      text: 'Share',
                                      icon:
                                          const Icon(CupertinoIcons.paperplane),
                                      onPressed: () => _shareWorkout(workout)),
                                if (isOwner)
                                  BottomSheetMenuItem(
                                      text: 'Edit',
                                      icon: const Icon(CupertinoIcons.pencil),
                                      onPressed: () => context.navigateTo(
                                          WorkoutCreatorRoute(
                                              workout: workout))),
                                if (isOwner ||
                                    workout.contentAccessScope ==
                                        ContentAccessScope.public)
                                  BottomSheetMenuItem(
                                      text: 'Copy',
                                      icon:
                                          const Icon(CupertinoIcons.doc_on_doc),
                                      onPressed: () =>
                                          _copyWorkout(workout.id)),
                                BottomSheetMenuItem(
                                    text: 'Export',
                                    icon: const Icon(
                                        CupertinoIcons.download_circle),
                                    onPressed: () => printLog('export')),
                                if (isOwner)
                                  BottomSheetMenuItem(
                                      text: workout.archived
                                          ? 'Unarchive'
                                          : 'Archive',
                                      icon: Icon(
                                        CupertinoIcons.archivebox,
                                        color: workout.archived
                                            ? null
                                            : Styles.errorRed,
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
                              _buildAvatar(workout, isOwner),
                              Row(
                                children: [
                                  DoItButton(
                                      onPressed: () => context.navigateTo(
                                          DoWorkoutWrapperRoute(
                                              id: widget.id))),
                                  const SizedBox(width: 4),
                                  CupertinoButton(
                                      pressedOpacity: 1.0,
                                      padding: EdgeInsets.zero,
                                      onPressed: () => CollectionManager
                                          .addOrRemoveObjectFromCollection(
                                              context, workout,
                                              alreadyInCollections:
                                                  collections),
                                      child: AnimatedLikeHeart(
                                        active: collections.isNotEmpty,
                                      )),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () =>
                                        _openScheduleWorkout(workout),
                                    child: const Icon(
                                      CupertinoIcons.calendar_badge_plus,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const HorizontalLine(),
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
                                                difficultyLevel:
                                                    workout.difficultyLevel,
                                                fontSize: FONTSIZE.one,
                                              ),
                                              ...workout.workoutGoals
                                                  .map((g) => Tag(tag: g.name)),
                                              ...workout.workoutTags
                                                  .map((t) => Tag(
                                                        tag: t.tag,
                                                        color: Styles.colorOne,
                                                        textColor: Styles.white,
                                                      ))
                                            ].toList(),
                                          ),
                                        ),
                                        if (Utils.textNotNull(
                                            workout.description))
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ViewMoreFullScreenTextBlock(
                                              text: workout.description!,
                                              title: workout.name,
                                              maxLines: 6,
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
                                                if (workout.introVideoUri !=
                                                    null)
                                                  VideoThumbnailPlayer(
                                                    videoUri:
                                                        workout.introVideoUri,
                                                    videoThumbUri: workout
                                                        .introVideoThumbUri,
                                                    displaySize:
                                                        _kthumbDisplaySize,
                                                  ),
                                                if (workout.introAudioUri !=
                                                    null)
                                                  AudioThumbnailPlayer(
                                                    audioUri:
                                                        workout.introAudioUri!,
                                                    displaySize:
                                                        _kthumbDisplaySize,
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
                                if (workout.workoutSections.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: MyText('Nothing here yet...'),
                                  ),
                                if (workout.workoutSections.length > 1)
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8, left: 8, right: 8),
                                      child: MyTabBarNav(
                                          titles: _sectionTitles(
                                              sortedWorkoutSections),
                                          handleTabChange: _handleTabChange,
                                          alignment: Alignment.center,
                                          activeTabIndex:
                                              _activeSectionTabIndex)),
                                if (workout.workoutSections.length == 1 &&
                                    Utils.textNotNull(
                                        workout.workoutSections[0].name))
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6, bottom: 8),
                                    child: UnderlineTitle(
                                        workout.workoutSections[0].name!),
                                  ),
                                if (sortedWorkoutSections.isNotEmpty)
                                  Expanded(
                                    child: PageView(
                                      controller: _pageController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
        });
  }
}
