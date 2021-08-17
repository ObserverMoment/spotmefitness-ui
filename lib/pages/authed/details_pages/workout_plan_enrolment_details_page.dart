import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:screenshot/screenshot.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/review_card.dart';
import 'package:spotmefitness_ui/components/creators/workout_plan_review_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_goals.dart';
import 'package:spotmefitness_ui/components/workout_plan/workout_plan_participants.dart';
import 'package:spotmefitness_ui/components/workout_plan_enrolment/workout_plan_enrolment_progress_summary.dart';
import 'package:spotmefitness_ui/components/workout_plan_enrolment/workout_plan_enrolment_workouts_progress.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutPlanEnrolmentDetailsPage extends StatefulWidget {
  final String id;
  const WorkoutPlanEnrolmentDetailsPage(
      {Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _WorkoutPlanEnrolmentDetailsPageState createState() =>
      _WorkoutPlanEnrolmentDetailsPageState();
}

class _WorkoutPlanEnrolmentDetailsPageState
    extends State<WorkoutPlanEnrolmentDetailsPage> {
  ScrollController _scrollController = ScrollController();
  ScreenshotController screenshotController = ScreenshotController();

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

  Future<void> _updateStartDate(WorkoutPlanEnrolment enrolment) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: enrolment.startDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      helpText: 'Select a date',
      builder: (context, child) {
        return buildDateTimePickerTheme(context, child!);
      },
    );
    if (newDate != null) {
      final variables = UpdateWorkoutPlanEnrolmentArguments(
          data: UpdateWorkoutPlanEnrolmentInput(id: ''));

      final result = await context.graphQLStore.mutate<
              UpdateWorkoutPlanEnrolment$Mutation,
              UpdateWorkoutPlanEnrolmentArguments>(
          mutation: UpdateWorkoutPlanEnrolmentMutation(variables: variables),
          broadcastQueryIds: [
            GQLVarParamKeys.userWorkoutPlanEnrolmentById(enrolment.id),
            UserWorkoutPlanEnrolmentsQuery().operationName,
          ],
          customVariablesMap: {
            'data': {
              'id': enrolment.id,
              'startDate': newDate.millisecondsSinceEpoch
            }
          });

      if (result.hasErrors) {
        context
            .showErrorAlert('Something went wrong, the update did not work.');
      } else {
        context.showToast(message: 'Start date updated.');
      }
    }
  }

  void _confirmResetPlan() {
    context.showConfirmDialog(
        title: 'Reset Plan Progress?',
        content: MyText(
          'All completed workout progress will be cleared. OK?',
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        onConfirm: _resetCompletedWorkoutPlanDayWorkoutIds);
  }

  Future<void> _resetCompletedWorkoutPlanDayWorkoutIds() async {
    final variables = UpdateWorkoutPlanEnrolmentArguments(
        data: UpdateWorkoutPlanEnrolmentInput(id: ''));

    final result = await context.graphQLStore.mutate<
            UpdateWorkoutPlanEnrolment$Mutation,
            UpdateWorkoutPlanEnrolmentArguments>(
        mutation: UpdateWorkoutPlanEnrolmentMutation(variables: variables),
        broadcastQueryIds: [
          GQLVarParamKeys.userWorkoutPlanEnrolmentById(widget.id),
          UserWorkoutPlanEnrolmentsQuery().operationName,
        ],
        customVariablesMap: {
          'data': {'id': widget.id, 'completedPlanDayWorkoutIds': []}
        });

    if (result.hasErrors) {
      context.showErrorAlert('Something went wrong, the update did not work.');
    } else {
      context.showToast(message: 'Plan progress reset');
    }
  }

  /// This code is duplicated in [WorkoutPlanDetails].
  /// Not abtracted as [WorkoutPlanDetails] share may end up being different.
  Future<void> _shareWorkoutPlan(WorkoutPlan workoutPlan) async {
    SharingAndLinking.shareImageRenderOfWidget(
        context: context,
        text: '${kDeepLinkSchema}workout-plan/${workoutPlan.id}',
        subject: 'Check out this workout plan!',
        widgetForImageCapture: SizedBox(
          height: 100,
          width: 100,
          child: workoutPlan.coverImageUri != null
              ? SizedUploadcareImage(
                  workoutPlan.coverImageUri!,
                  displaySize: Size(300, 300),
                )
              : Image.asset(
                  'assets/home_page_images/home_page_plans.jpg',
                  fit: BoxFit.cover,
                ),
        ));
  }

  void _confirmLeavePlan() {
    context.showConfirmDialog(
        title: 'Leave Plan?',
        content: MyText(
          'Progress will not be saved but logged workouts will not be affected. OK?',
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        onConfirm: _deleteWorkoutPlanEnrolmentById);
  }

  /// I.e unenrol the user from the plan.
  Future<void> _deleteWorkoutPlanEnrolmentById() async {
    context.showLoadingAlert('Leaving...',
        icon: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi),
          child: Icon(
            Icons.directions_walk,
          ),
        ));

    final variables = DeleteWorkoutPlanEnrolmentByIdArguments(id: widget.id);

    final result = await context.graphQLStore.delete<
            DeleteWorkoutPlanEnrolmentById$Mutation,
            DeleteWorkoutPlanEnrolmentByIdArguments>(
        objectId: widget.id,
        typename: kWorkoutPlanEnrolmentTypename,
        mutation: DeleteWorkoutPlanEnrolmentByIdMutation(variables: variables),
        removeRefFromQueries: [UserWorkoutPlanEnrolmentsQuery().operationName]);

    if (result.hasErrors) {
      context.pop(); // The showLoadingAlert
      context.showErrorAlert(
          'Something went wrong, there was an issue leaving the plan.');
    } else {
      context.pop(); // The showLoadingAlert
      context.pop(); // This screen.
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = UserWorkoutPlanEnrolmentByIdQuery(
        variables: UserWorkoutPlanEnrolmentByIdArguments(id: widget.id));

    return QueryObserver<UserWorkoutPlanEnrolmentById$Query,
            UserWorkoutPlanEnrolmentByIdArguments>(
        key: Key(
            'WorkoutPlanEnrolmentDetailsPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final enrolment = data.userWorkoutPlanEnrolmentById;
          final workoutPlan = enrolment.workoutPlan;

          final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
          final WorkoutPlanReview? loggedInUserReview = authedUserId == null
              ? null
              : enrolment.workoutPlan.workoutPlanReviews
                  .firstWhereOrNull((r) => r.user.id == authedUserId);

          return CupertinoPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: NavBarTitle(enrolment.workoutPlan.name),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(CupertinoIcons.ellipsis_circle),
                  onPressed: () => context.showBottomSheet(
                      child: BottomSheetMenu(
                          header: BottomSheetMenuHeader(
                            name: enrolment.workoutPlan.name,
                            subtitle: 'Plan progress',
                            imageUri: enrolment.workoutPlan.coverImageUri,
                          ),
                          items: [
                        BottomSheetMenuItem(
                          text: 'Leave review',
                          icon: Icon(CupertinoIcons.star),
                          onPressed: () => context.showBottomSheet(
                              child: WorkoutPlanReviewCreator(
                            parentWorkoutPlanEnrolmentId: enrolment.id,
                            parentWorkoutPlanId: workoutPlan.id,
                          )),
                        ),
                        BottomSheetMenuItem(
                            text: 'Reset progress',
                            icon: Icon(CupertinoIcons.refresh_bold),
                            onPressed: _confirmResetPlan),
                        BottomSheetMenuItem(
                            text: 'Change start date',
                            icon: Icon(CupertinoIcons.calendar_today),
                            onPressed: () => _updateStartDate(enrolment)),
                        BottomSheetMenuItem(
                            text: 'Share plan',
                            icon: Icon(CupertinoIcons.paperplane),
                            onPressed: () =>
                                _shareWorkoutPlan(enrolment.workoutPlan)),
                        BottomSheetMenuItem(
                            text: 'Leave plan',
                            isDestructive: true,
                            icon: Icon(
                              CupertinoIcons.square_arrow_right,
                              color: Styles.errorRed,
                            ),
                            onPressed: _confirmLeavePlan),
                      ])),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: WorkoutPlanEnrolmentProgressSummary(
                        workoutPlanEnrolment: enrolment),
                  ),
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
                                                .workoutPlanDays.isNotEmpty &&
                                            workoutPlan.calcDifficulty != null)
                                          DifficultyLevelTag(
                                              workoutPlan.calcDifficulty!),
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
                                          if (workoutPlan.introVideoUri != null)
                                            VideoThumbnailPlayer(
                                              videoUri:
                                                  workoutPlan.introVideoUri,
                                              videoThumbUri: workoutPlan
                                                  .introVideoThumbUri,
                                              displaySize: _kthumbDisplaySize,
                                            ),
                                          if (workoutPlan.introAudioUri != null)
                                            AudioThumbnailPlayer(
                                              audioUri:
                                                  workoutPlan.introAudioUri!,
                                              displaySize: _kthumbDisplaySize,
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
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: MyTabBarNav(
                                    titles: [
                                      'Progress',
                                      'Goals',
                                      'Review',
                                      'Social',
                                    ],
                                    handleTabChange: _handleTabChange,
                                    activeTabIndex: _activeTabIndex)),
                            Expanded(
                              child: PageView(
                                  controller: _pageController,
                                  children: [
                                    WorkoutPlanEnrolmentWorkoutsProgress(
                                      workoutPlanEnrolment: enrolment,
                                    ),
                                    WorkoutPlanGoals(
                                      workoutPlan: workoutPlan,
                                    ),
                                    _YourReviewDisplay(
                                      enrolment: enrolment,
                                      loggedInUserReview: loggedInUserReview,
                                      workoutPlan: workoutPlan,
                                    ),
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
              ));
        });
  }
}

class _YourReviewDisplay extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  final WorkoutPlanEnrolment enrolment;
  final WorkoutPlanReview? loggedInUserReview;
  const _YourReviewDisplay(
      {Key? key,
      required this.workoutPlan,
      required this.enrolment,
      required this.loggedInUserReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: loggedInUserReview != null
              ? Column(
                  children: [
                    MyText('Your Review'),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: WorkoutPlanReviewCard(
                        review: loggedInUserReview!,
                      ),
                    ),
                    SizedBox(height: 10),
                    BorderButton(
                      mini: true,
                      prefix: Icon(
                        CupertinoIcons.star_fill,
                        color: Styles.starGold,
                        size: 14,
                      ),
                      text: 'Edit Review',
                      onPressed: () => context.showBottomSheet(
                          child: WorkoutPlanReviewCreator(
                        parentWorkoutPlanEnrolmentId: enrolment.id,
                        parentWorkoutPlanId: workoutPlan.id,
                        workoutPlanReview: loggedInUserReview,
                      )),
                    ),
                  ],
                )
              : BorderButton(
                  mini: true,
                  prefix: Icon(
                    CupertinoIcons.star_fill,
                    color: Styles.starGold,
                    size: 14,
                  ),
                  text: 'Leave Review',
                  onPressed: () => context.showBottomSheet(
                      child: WorkoutPlanReviewCreator(
                    parentWorkoutPlanEnrolmentId: enrolment.id,
                    parentWorkoutPlanId: workoutPlan.id,
                  )),
                )),
    );
  }
}
