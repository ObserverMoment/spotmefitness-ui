import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/animated_like_heart.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/collections/collection_manager.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:sofie_ui/components/media/images/user_avatar.dart';
import 'package:sofie_ui/components/media/video/video_thumbnail_player.dart';
import 'package:sofie_ui/components/navigation.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:sofie_ui/components/workout_plan/workout_plan_goals.dart';
import 'package:sofie_ui/components/workout_plan/workout_plan_participants.dart';
import 'package:sofie_ui/components/workout_plan/workout_plan_reviews.dart';
import 'package:sofie_ui/components/workout_plan/workout_plan_workout_schedule.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/enum.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/graphql_operation_names.dart';
import 'package:sofie_ui/services/sharing_and_linking.dart';
import 'package:sofie_ui/services/store/graphql_store.dart';
import 'package:sofie_ui/services/store/query_observer.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class WorkoutPlanDetailsPage extends StatefulWidget {
  final String id;
  const WorkoutPlanDetailsPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _WorkoutPlanDetailsPageState createState() => _WorkoutPlanDetailsPageState();
}

class _WorkoutPlanDetailsPageState extends State<WorkoutPlanDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  /// 0 = Schedule List. 1 = Goals HeatMap / Calendar. 2 = Participants. 3 = reviews.
  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  Size get _kthumbDisplaySize => const Size(80, 80);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_activeTabIndex != _pageController.page!.round()) {
        setState(() {
          _activeTabIndex = _pageController.page!.round();
        });
      }
    });
  }

  void _handleTabChange(int index) {
    if (_pageController.page != index) {
      _pageController.jumpToPage(index);
    }
    setState(() => _activeTabIndex = index);
  }

  /// I.e. enrol the user in the plan.
  Future<void> _createWorkoutPlanEnrolment() async {
    context.showLoadingAlert('Joining Plan...',
        icon: const Icon(
          Icons.directions_run,
        ));

    final variables =
        CreateWorkoutPlanEnrolmentArguments(workoutPlanId: widget.id);

    final result = await context.graphQLStore.mutate<
            CreateWorkoutPlanEnrolment$Mutation,
            CreateWorkoutPlanEnrolmentArguments>(
        mutation: CreateWorkoutPlanEnrolmentMutation(variables: variables),
        addRefToQueries: [UserWorkoutPlanEnrolmentsQuery().operationName]);

    if (result.hasErrors) {
      context.pop(); // The showLoadingAlert
      context.showErrorAlert(
          'Something went wrong, there was an issue joining the plan.');
    } else {
      context.pop(); // The showLoadingAlert
      context.showToast(
          icon: const Icon(Icons.thumb_up, color: Styles.white),
          message: 'Plan joined! Congratulations!',
          toastType: ToastType.success);
    }
  }

  Future<void> _shareWorkoutPlan(WorkoutPlan workoutPlan) async {
    await SharingAndLinking.shareLink(
        'workout-plan/${workoutPlan.id}', 'Check out this workout plan!');
  }

  Future<void> _archiveWorkoutPlan(String id) async {
    await context.showConfirmDialog(
        title: 'Archive this workout plan?',
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
              .mutate<UpdateWorkoutPlan$Mutation, UpdateWorkoutPlanArguments>(
                  mutation: UpdateWorkoutPlanMutation(
                    variables: UpdateWorkoutPlanArguments(
                        data: UpdateWorkoutPlanInput(id: id, archived: true)),
                  ),
                  removeRefFromQueries: [
                UserWorkoutPlansQuery().operationName
              ],
                  broadcastQueryIds: [
                GQLVarParamKeys.workoutPlanByIdQuery(widget.id),
              ],
                  customVariablesMap: {
                'data': {'id': id, 'archived': true}
              });

          if (result.hasErrors) {
            context.pop(); // The showLoadingAlert
            context.showErrorAlert(
                'Something went wrong, the workout plan was not archived correctly');
          } else {
            context.pop(); // The showLoadingAlert
            context.showToast(message: 'Workout plan archived.');
          }
        });
  }

  Future<void> _unarchiveWorkoutPlan(String id) async {
    await context.showConfirmDialog(
        title: 'Unarchive this workout plan?',
        content: const MyText(
          'It will be moved back into your plans.',
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
              .mutate<UpdateWorkoutPlan$Mutation, UpdateWorkoutPlanArguments>(
                  mutation: UpdateWorkoutPlanMutation(
                    variables: UpdateWorkoutPlanArguments(
                        data: UpdateWorkoutPlanInput(id: id, archived: false)),
                  ),
                  addRefToQueries: [
                UserWorkoutPlansQuery().operationName
              ],
                  broadcastQueryIds: [
                GQLVarParamKeys.workoutPlanByIdQuery(widget.id),
              ],
                  customVariablesMap: {
                'data': {'id': id, 'archived': false}
              });

          if (result.hasErrors) {
            context.pop(); // The showLoadingAlert
            context.showErrorAlert(
                'Something went wrong, the workout plan was not unarchived correctly');
          } else {
            context.pop(); // The showLoadingAlert
            context.showToast(message: 'Workout plan unarchived.');
          }
        });
  }

  Widget _buildAvatar(WorkoutPlan workoutPlan, bool isOwner) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAvatar(
          avatarUri: workoutPlan.user.avatarUri,
          size: 34,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(workoutPlan.user.displayName, size: FONTSIZE.two),
              if (isOwner)
                MyText('${workoutPlan.contentAccessScope.display} plan',
                    color: Styles.colorTwo,
                    size: FONTSIZE.one,
                    lineHeight: 1.4),
            ],
          ),
        ),
        if (workoutPlan.archived)
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

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = WorkoutPlanByIdQuery(
        variables: WorkoutPlanByIdArguments(id: widget.id));

    return QueryObserver<WorkoutPlanById$Query, WorkoutPlanByIdArguments>(
        key: Key('YourWorkoutPlansPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: const ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (workoutPlanData) {
          return QueryObserver<UserCollections$Query, json.JsonSerializable>(
              key: Key(
                  'WorkoutPlanDetailsPage - ${UserCollectionsQuery().operationName}'),
              query: UserCollectionsQuery(),
              fetchPolicy: QueryFetchPolicy.storeFirst,
              loadingIndicator:
                  const ShimmerDetailsPage(title: 'Getting Ready'),
              builder: (collectionsData) {
                final workoutPlan = workoutPlanData.workoutPlanById;

                final List<Collection> collections = collectionsData
                    .userCollections
                    .where((collection) =>
                        collection.workoutPlans.contains(workoutPlan))
                    .toList();

                final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
                final bool isOwner = workoutPlan.user.id == authedUserId;

                return CupertinoPageScaffold(
                  navigationBar: MyNavBar(
                    middle: NavBarTitle(workoutPlan.name),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.ellipsis),
                      onPressed: () => openBottomSheetMenu(
                          context: context,
                          child: BottomSheetMenu(
                              header: BottomSheetMenuHeader(
                                name: workoutPlan.name,
                                subtitle: 'Workout Plan',
                                imageUri: workoutPlan.coverImageUri,
                              ),
                              items: [
                                if (!isOwner &&
                                    workoutPlan.user.userProfileScope ==
                                        UserProfileScope.public)
                                  BottomSheetMenuItem(
                                      text: 'View creator',
                                      icon: const Icon(
                                          CupertinoIcons.profile_circled),
                                      onPressed: () => context.navigateTo(
                                          UserPublicProfileDetailsRoute(
                                              userId: workoutPlan.user.id))),
                                BottomSheetMenuItem(
                                    text: 'Share',
                                    icon: const Icon(CupertinoIcons.paperplane),
                                    onPressed: () =>
                                        _shareWorkoutPlan(workoutPlan)),
                                if (isOwner)
                                  BottomSheetMenuItem(
                                      text: 'Edit',
                                      icon: const Icon(CupertinoIcons.pencil),
                                      onPressed: () => context.navigateTo(
                                          WorkoutPlanCreatorRoute(
                                              workoutPlan: workoutPlan))),
                                BottomSheetMenuItem(
                                    text: 'Export',
                                    icon: const Icon(
                                        CupertinoIcons.download_circle),
                                    onPressed: () => printLog('export')),
                                if (isOwner)
                                  BottomSheetMenuItem(
                                      text: workoutPlan.archived
                                          ? 'Unarchive'
                                          : 'Archive',
                                      icon: Icon(
                                        CupertinoIcons.archivebox,
                                        color: workoutPlan.archived
                                            ? null
                                            : Styles.errorRed,
                                      ),
                                      isDestructive: !workoutPlan.archived,
                                      onPressed: () => workoutPlan.archived
                                          ? _unarchiveWorkoutPlan(
                                              workoutPlan.id)
                                          : _archiveWorkoutPlan(
                                              workoutPlan.id)),
                              ])),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAvatar(workoutPlan, isOwner),
                            Row(
                              children: [
                                QueryObserver<UserWorkoutPlanEnrolments$Query,
                                        json.JsonSerializable>(
                                    key: Key(
                                        'WorkoutPlanDetailsPage - ${UserWorkoutPlanEnrolmentsQuery().operationName}'),
                                    query: UserWorkoutPlanEnrolmentsQuery(),
                                    loadingIndicator:
                                        const LoadingDots(size: 16),
                                    // Otherwise every single plan details page that you open will run a network query for all of your plan enrolments.
                                    fetchPolicy: QueryFetchPolicy.storeFirst,
                                    builder: (data) {
                                      final enrolments =
                                          data.userWorkoutPlanEnrolments;

                                      /// Is the user already enrolled in this plan?
                                      final enrolmentInPlan =
                                          enrolments.firstWhereOrNull((e) =>
                                              e.workoutPlan.id ==
                                              workoutPlan.id);

                                      if (enrolmentInPlan != null) {
                                        return DoItButton(
                                            text: 'Progress',
                                            onPressed: () => context.navigateTo(
                                                WorkoutPlanEnrolmentDetailsRoute(
                                                    id: enrolmentInPlan.id)));
                                      } else {
                                        return DoItButton(
                                            text: 'Join Plan',
                                            onPressed:
                                                _createWorkoutPlanEnrolment);
                                      }
                                    }),
                                CupertinoButton(
                                    pressedOpacity: 1.0,
                                    padding: EdgeInsets.zero,
                                    onPressed: () => CollectionManager
                                        .addOrRemoveObjectFromCollection(
                                            context, workoutPlan,
                                            alreadyInCollections: collections),
                                    child: AnimatedLikeHeart(
                                      active: collections.isNotEmpty,
                                    )),
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
                                      image: workoutPlan.coverImageUri != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  context.theme.cardBackground
                                                      .withOpacity(0.2),
                                                  BlendMode.dstATop),
                                              image: UploadcareImageProvider(
                                                  workoutPlan.coverImageUri!))
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
                                            if (workoutPlan.workoutPlanDays
                                                    .isNotEmpty &&
                                                workoutPlan.calcDifficulty !=
                                                    null)
                                              DifficultyLevelTag(
                                                  difficultyLevel: workoutPlan
                                                      .calcDifficulty!),
                                            Tag(
                                              tag: workoutPlan.lengthString,
                                              color: Styles.white,
                                              textColor: Styles.black,
                                            ),
                                            Tag(
                                              tag:
                                                  '${workoutPlan.daysPerWeek} days / week',
                                              color: Styles.white,
                                              textColor: Styles.black,
                                            ),
                                            ...workoutPlan.workoutTags
                                                .map((t) => Tag(
                                                      tag: t.tag,
                                                      color: Styles.colorOne,
                                                      textColor: Styles.white,
                                                    ))
                                          ].toList(),
                                        ),
                                      ),
                                      if (Utils.textNotNull(
                                          workoutPlan.description))
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MyText(
                                            workoutPlan.description!,
                                            maxLines: 10,
                                            lineHeight: 1.3,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      if (Utils.anyNotNull([
                                        workoutPlan.introAudioUri,
                                        workoutPlan.introVideoUri
                                      ]))
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0, top: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              if (workoutPlan.introVideoUri !=
                                                  null)
                                                VideoThumbnailPlayer(
                                                  videoUri:
                                                      workoutPlan.introVideoUri,
                                                  videoThumbUri: workoutPlan
                                                      .introVideoThumbUri,
                                                  displaySize:
                                                      _kthumbDisplaySize,
                                                ),
                                              if (workoutPlan.introAudioUri !=
                                                  null)
                                                AudioThumbnailPlayer(
                                                  audioUri: workoutPlan
                                                      .introAudioUri!,
                                                  displaySize:
                                                      _kthumbDisplaySize,
                                                  playerTitle:
                                                      '${workoutPlan.name} - Intro',
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
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14, bottom: 2),
                                    child: MyTabBarNav(
                                        titles: const [
                                          'Workouts',
                                          'Goals',
                                          'Reviews',
                                          'Social',
                                        ],
                                        handleTabChange: _handleTabChange,
                                        activeTabIndex: _activeTabIndex)),
                                Expanded(
                                  child: PageView(
                                      controller: _pageController,
                                      children: [
                                        WorkoutPlanWorkoutSchedule(
                                          workoutPlan: workoutPlan,
                                        ),
                                        WorkoutPlanGoals(
                                          workoutPlan: workoutPlan,
                                        ),
                                        WorkoutPlanReviews(
                                            reviews:
                                                workoutPlan.workoutPlanReviews),
                                        WorkoutPlanParticipants(
                                          userSummaries: workoutPlan.enrolments
                                              .map((e) => e.user)
                                              .toList(),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
