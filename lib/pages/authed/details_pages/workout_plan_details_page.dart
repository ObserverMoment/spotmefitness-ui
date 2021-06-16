import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_like_heart.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/collection_selector.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_goals.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_participants.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_reviews.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_workout_schedule.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutPlanDetailsPage extends StatefulWidget {
  final String id;
  WorkoutPlanDetailsPage({@PathParam('id') required this.id});

  @override
  _WorkoutPlanDetailsPageState createState() => _WorkoutPlanDetailsPageState();
}

class _WorkoutPlanDetailsPageState extends State<WorkoutPlanDetailsPage> {
  ScrollController _scrollController = ScrollController();

  /// 0 = Schedule List. 1 = Goals HeatMap / Calendar. 2 = Participants. 3 = reviews.
  int _activeTabIndex = 0;
  PageController _pageController = PageController();

  final _kthumbDisplaySize = Size(80, 80);

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
        icon: Icon(
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
          icon: Icon(Icons.thumb_up, color: Styles.white),
          message: 'Plan joined! Congratulations!',
          toastType: ToastType.success);
    }
  }

  /// Either removes the workoutPlan from its current collection ([collection] is not null)
  /// Or Adds to an existing collection.
  /// Or adds to a newly created collection.
  Future<void> _toggleSavedWorkoutPlan(
      WorkoutPlan workoutPlan, Collection? collection) async {
    if (collection != null) {
      context.showConfirmDialog(
          title: 'Remove from Saved',
          content: MyText(
            'Remove from: ${collection.name}?',
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
          onConfirm: () =>
              _removeWorkoutPlanFromCollection(collection, workoutPlan));
    } else {
      /// Add to collection flow.
      /// First choose a collection
      await context.showBottomSheet(
          useRootNavigator: true,
          expand: true,
          child: CollectionSelector(
              selectCollection: (collection) =>
                  _addWorkoutPlanToCollection(collection, workoutPlan)));
    }
  }

  Future<void> _addWorkoutPlanToCollection(
      Collection collection, WorkoutPlan workoutPlan) async {
    final updatedCollection = Collection.fromJson(collection.toJson());
    updatedCollection.workoutPlans.add(workoutPlan);

    final variables = AddWorkoutPlanToCollectionArguments(
        data: AddWorkoutPlanToCollectionInput(
            collectionId: collection.id,
            workoutPlan: ConnectRelationInput(id: workoutPlan.id)));

    final result = await context.graphQLStore.mutate<
            AddWorkoutPlanToCollection$Mutation,
            AddWorkoutPlanToCollectionArguments>(
        mutation: AddWorkoutPlanToCollectionMutation(variables: variables),
        optimisticData: updatedCollection.toJson(),
        broadcastQueryIds: [
          UserCollectionsQuery().operationName,
          GQLVarParamKeys.userCollectionByIdQuery(collection.id)
        ]);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the workout plan was not added');
    } else {
      context.showToast(message: 'Saved to collection: ${collection.name}');
    }
  }

  Future<void> _removeWorkoutPlanFromCollection(
      Collection collection, WorkoutPlan workoutPlan) async {
    final updatedCollection = Collection.fromJson(collection.toJson());
    updatedCollection.workoutPlans =
        collection.workoutPlans.where((wp) => wp.id != workoutPlan.id).toList();

    final variables = RemoveWorkoutPlanFromCollectionArguments(
        data: RemoveWorkoutPlanFromCollectionInput(
            collectionId: collection.id,
            workoutPlan: ConnectRelationInput(id: workoutPlan.id)));

    final result = await context.graphQLStore.mutate<
            RemoveWorkoutPlanFromCollection$Mutation,
            RemoveWorkoutPlanFromCollectionArguments>(
        mutation: RemoveWorkoutPlanFromCollectionMutation(variables: variables),
        optimisticData: updatedCollection.toJson(),
        broadcastQueryIds: [
          UserCollectionsQuery().operationName,
          GQLVarParamKeys.userCollectionByIdQuery(collection.id)
        ]);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the workout plan was not removed');
    } else {
      context.showToast(message: 'Removed from collection: ${collection.name}');
    }
  }

  Future<void> _archiveWorkoutPlan(String id) async {
    await context.showConfirmDialog(
        title: 'Archive this workout plan?',
        content: MyText(
          'It will be moved to your archive where it can be retrieved if needed.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Archiving...',
              icon: Icon(
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
        content: MyText(
          'It will be moved back into your plans.',
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
        onConfirm: () async {
          context.showLoadingAlert('Unarchiving...',
              icon: Icon(
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

  Widget _displayName(String text) => Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: MyText(text, weight: FontWeight.bold, size: FONTSIZE.SMALL),
      );

  Widget _buildAvatar(WorkoutPlan workoutPlan) {
    final size = 40.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserAvatar(
          avatarUri: workoutPlan.user.avatarUri,
          size: size,
        ),
        if (workoutPlan.user.displayName != '')
          _displayName(workoutPlan.user.displayName),
        if (workoutPlan.archived)
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
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (workoutPlanData) {
          return QueryObserver<UserCollections$Query, json.JsonSerializable>(
              key: Key(
                  'WorkoutPlanDetailsPage - ${UserCollectionsQuery().operationName}'),
              query: UserCollectionsQuery(),
              fetchPolicy: QueryFetchPolicy.storeFirst,
              loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
              builder: (collectionsData) {
                final workoutPlan = workoutPlanData.workoutPlanById;

                final Collection? collection = collectionsData.userCollections
                    .firstWhereOrNull((collection) =>
                        collection.workoutPlans.contains(workoutPlan));

                final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
                final bool isOwner = workoutPlan.user.id == authedUserId;

                return CupertinoPageScaffold(
                  navigationBar: BorderlessNavBar(
                    middle: NavBarTitle(workoutPlan.name),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(CupertinoIcons.ellipsis_circle),
                      onPressed: () => context.showBottomSheet(
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
                                  icon: Icon(CupertinoIcons.profile_circled),
                                  onPressed: () => context.navigateTo(
                                      UserPublicProfileDetailsRoute(
                                          userId: workoutPlan.user.id))),
                            BottomSheetMenuItem(
                                text: 'Share',
                                icon: Icon(CupertinoIcons.share),
                                onPressed: () => print('share')),
                            if (isOwner)
                              BottomSheetMenuItem(
                                  text: 'Edit',
                                  icon: Icon(CupertinoIcons.pencil),
                                  onPressed: () => context.navigateTo(
                                      WorkoutPlanCreatorRoute(
                                          workoutPlan: workoutPlan))),
                            BottomSheetMenuItem(
                                text: 'Export',
                                icon: Icon(CupertinoIcons.download_circle),
                                onPressed: () => print('export')),
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
                                      ? _unarchiveWorkoutPlan(workoutPlan.id)
                                      : _archiveWorkoutPlan(workoutPlan.id)),
                          ])),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAvatar(workoutPlan),
                              Row(
                                children: [
                                  QueryObserver<UserWorkoutPlanEnrolments$Query,
                                          json.JsonSerializable>(
                                      key: Key(
                                          'WorkoutPlanDetailsPage - ${UserWorkoutPlanEnrolmentsQuery().operationName}'),
                                      query: UserWorkoutPlanEnrolmentsQuery(),
                                      loadingIndicator: LoadingDots(size: 16),
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
                                      onPressed: () => _toggleSavedWorkoutPlan(
                                          workoutPlan, collection),
                                      child: AnimatedLikeHeart(
                                        active: collection != null,
                                      )),
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
                                              if (workoutPlan
                                                  .workoutPlanDays.isNotEmpty)
                                                DifficultyLevelTag(
                                                    workoutPlan.calcDifficulty),
                                              Tag(
                                                tag: workoutPlan.lengthString,
                                                color: Styles.white,
                                                textColor: Styles.black,
                                              ),
                                              Tag(
                                                tag:
                                                    '${workoutPlan.sessionsPerWeek} days / week',
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
                                                    videoUri: workoutPlan
                                                        .introVideoUri,
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
                            body: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 8),
                                    child: MyTabBarNav(
                                        titles: [
                                          'Workouts',
                                          'Goals',
                                          'Reviews',
                                          'Participants',
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
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
