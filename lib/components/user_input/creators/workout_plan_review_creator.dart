import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/my_text_field.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutPlanReviewCreator extends StatefulWidget {
  final String parentWorkoutPlanId;
  final String parentWorkoutPlanEnrolmentId;
  final WorkoutPlanReview? workoutPlanReview;
  const WorkoutPlanReviewCreator(
      {Key? key,
      this.workoutPlanReview,
      required this.parentWorkoutPlanId,
      required this.parentWorkoutPlanEnrolmentId})
      : super(key: key);

  @override
  _WorkoutPlanReviewCreatorState createState() =>
      _WorkoutPlanReviewCreatorState();
}

class _WorkoutPlanReviewCreatorState extends State<WorkoutPlanReviewCreator> {
  double? _score;
  String? _comment;
  bool _loading = false;

  @override
  void initState() {
    _score = widget.workoutPlanReview?.score;
    _comment = widget.workoutPlanReview?.comment;

    super.initState();
  }

  void _handleSave() {
    if (_score != null) {
      if (widget.workoutPlanReview != null) {
        _updateWorkoutPlanReview();
      } else {
        _createWorkoutPlanReview();
      }
    }
  }

  Future<void> _createWorkoutPlanReview() async {
    if (_score != null) {
      setState(() => _loading = true);

      final variables = CreateWorkoutPlanReviewArguments(
          data: CreateWorkoutPlanReviewInput(
              score: _score!,
              comment: _comment,
              workoutPlan:
                  ConnectRelationInput(id: widget.parentWorkoutPlanId)));

      final result = await context.graphQLStore.mutate<
              CreateWorkoutPlanReview$Mutation,
              CreateWorkoutPlanReviewArguments>(
          // Use _writeReviewToStore method to write to nested field
          // within WorkoutPlan.workoutplanReviews
          writeToStore: false,
          mutation: CreateWorkoutPlanReviewMutation(variables: variables));

      setState(() => _loading = false);

      if (result.hasErrors || result.data == null) {
        context.showToast(
            message: 'Sorry, there was a problem creating this review',
            toastType: ToastType.destructive);
      } else {
        _writeReviewToStore(
            review: result.data!.createWorkoutPlanReview, isCreate: true);
        context.pop();
      }
    }
  }

  Future<void> _updateWorkoutPlanReview() async {
    if (_score != null) {
      setState(() => _loading = true);

      final variables = UpdateWorkoutPlanReviewArguments(
          data: UpdateWorkoutPlanReviewInput(
              id: widget.workoutPlanReview!.id,
              score: _score!,
              comment: _comment));

      final result = await context.graphQLStore.mutate<
              UpdateWorkoutPlanReview$Mutation,
              UpdateWorkoutPlanReviewArguments>(
          // Use _writeReviewToStore method to write to nested field
          // within WorkoutPlan.workoutplanReviews
          writeToStore: false,
          mutation: UpdateWorkoutPlanReviewMutation(variables: variables));

      setState(() => _loading = false);

      if (result.hasErrors || result.data == null) {
        context.showToast(
            message: 'Sorry, there was a problem updating this review',
            toastType: ToastType.destructive);
      } else {
        _writeReviewToStore(
            review: result.data!.updateWorkoutPlanReview, isCreate: false);
        context.pop();
      }
    }
  }

  /// WorkoutPlanReviews are not normalized. They live nested inside the normalized WorkoutPlan objects in the store. We need to retrieve the workout plan data from store - update it - then re-write it with the review added / updated.
  /// We can then broadcast new data to query observers so that UI updates.
  /// We must broadcast to lists queries for Enrolments and WorkoutPlans, and details pages for WorkoutPlan and WorkoutPlanEnrolment.
  void _writeReviewToStore(
      {required WorkoutPlanReview review, required bool isCreate}) {
    final parentData = context.graphQLStore.readDenomalized(
      '$kWorkoutPlanTypename:${widget.parentWorkoutPlanId}',
    );

    final updatedParentWorkoutPlan = WorkoutPlan.fromJson(parentData);

    if (isCreate) {
      /// Add the review.
      updatedParentWorkoutPlan.workoutPlanReviews.add(review);
    } else {
      /// Replace the old review.
      updatedParentWorkoutPlan.workoutPlanReviews = updatedParentWorkoutPlan
          .workoutPlanReviews
          .map((r) => r.id == review.id ? review : r)
          .toList();
    }

    context.graphQLStore.writeDataToStore(
      data: updatedParentWorkoutPlan.toJson(),
      broadcastQueryIds: [
        UserWorkoutPlansQuery().operationName,
        GQLVarParamKeys.workoutPlanByIdQuery(widget.parentWorkoutPlanId),
        UserWorkoutPlanEnrolmentsQuery().operationName,
        GQLVarParamKeys.userWorkoutPlanEnrolmentById(
            widget.parentWorkoutPlanEnrolmentId),
      ],
    );
  }

  void _cancel() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.theme.modalBackground,
      navigationBar: BorderlessNavBar(
        backgroundColor: context.theme.modalBackground,
        customLeading: NavBarCancelButton(_cancel),
        middle: NavBarTitle('Leave Review'),
        trailing: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: _loading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoadingDots(
                        size: 12,
                        color: Styles.infoBlue,
                      ),
                    ],
                  )
                : _score != null
                    ? NavBarSaveButton(_handleSave)
                    : Container(width: 0)),
      ),
      // Use SafeArea as this screen can be opened as a bottom sheet.
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar.builder(
                initialRating: _score ?? 0.0,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                glowRadius: 0.5,
                updateOnDrag: true,
                unratedColor: Styles.starGold.withOpacity(0.2),
                itemBuilder: (context, _) => Icon(
                  CupertinoIcons.star_fill,
                  color: Styles.starGold,
                ),
                onRatingUpdate: (rating) {
                  setState(() => _score = rating);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularBox(
                color: Styles.starGold,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: MyText(
                    _score != null
                        ? _score!.roundMyDouble(1).toString()
                        : ' - ',
                    color: Styles.white,
                    weight: FontWeight.bold,
                    size: FONTSIZE.HUGE,
                    lineHeight: 1.2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            EditableTextAreaRow(
              text: _comment ?? '',
              inputValidation: (_) => true,
              onSave: (t) => setState(() => _comment = t),
              title: 'Comment',
              placeholder: 'Add a comment...',
              maxDisplayLines: 10,
            ),
            SizedBox(height: 100),
          ],
        )),
      )),
    );
  }
}
