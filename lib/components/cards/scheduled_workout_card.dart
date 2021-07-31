import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/creators/scheduled_workout_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/model/toast_request.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ScheduledWorkoutCard extends StatelessWidget {
  final ScheduledWorkout scheduledWorkout;
  ScheduledWorkoutCard(this.scheduledWorkout);

  Widget? _buildMarker() {
    final hasLog = scheduledWorkout.loggedWorkoutId != null;

    final color = hasLog
        ? Styles.colorOne // Done
        : scheduledWorkout.scheduledAt.isBefore(DateTime.now())
            ? Styles.errorRed // Missed
            : Styles.colorFour; // Upcoming
    final IconData icon = hasLog
        ? CupertinoIcons.checkmark_alt // Done
        : scheduledWorkout.scheduledAt.isBefore(DateTime.now())
            ? CupertinoIcons.exclamationmark // Missed
            : CupertinoIcons.clock; // Upcoming

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        Icon(
          icon,
          size: 12,
          color: Styles.white,
        )
      ],
    );
  }

  Future<void> _reschedule(BuildContext context) async {
    final result = await context.showBottomSheet(
        showDragHandle: false,
        useRootNavigator: true,
        child: ScheduledWorkoutCreator(
          scheduledWorkout: scheduledWorkout,
        ));
    if (result is ToastRequest) {
      context.showToast(message: result.message, toastType: result.type);
    }
  }

  void _confirmUnschedule(BuildContext context) {
    context.showConfirmDeleteDialog(
        itemType: 'Scheduled Workout', onConfirm: () => _unschedule(context));
  }

  Future<void> _unschedule(BuildContext context) async {
    context.showLoadingAlert('Unscheduling...',
        icon: Icon(
          CupertinoIcons.calendar_badge_minus,
          color: Styles.errorRed,
        ));

    final variables =
        DeleteScheduledWorkoutByIdArguments(id: scheduledWorkout.id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteScheduledWorkoutByIdMutation(variables: variables),
        objectId: scheduledWorkout.id,
        typename: kScheduledWorkoutTypename,
        removeRefFromQueries: [UserScheduledWorkoutsQuery().operationName]);

    context.pop(); // Pop showLoadingAlert.

    if (result.hasErrors) {
      context.showErrorAlert(
          'Sorry there was a problem, the schedule was not updated.');
    } else {
      context.showToast(
          message: 'Workout unscheduled.', toastType: ToastType.destructive);
    }
  }

  Widget _buildCardHeader(BuildContext context, bool showNote) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyText(
                  '${scheduledWorkout.scheduledAt.minimalDateString}, ${scheduledWorkout.scheduledAt.timeString}',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: _buildMarker(),
                ),
              ],
            ),
            if (scheduledWorkout.gymProfile != null)
              MyText(
                scheduledWorkout.gymProfile!.name,
                color: Styles.infoBlue,
                size: FONTSIZE.SMALL,
              ),
          ],
        ),
        if (showNote && Utils.textNotNull(scheduledWorkout.note))
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: MyText(
                scheduledWorkout.note!,
                size: FONTSIZE.SMALL,
                maxLines: 4,
                lineHeight: 1.4,
              ),
              onPressed: () => context.showBottomSheet(
                  useRootNavigator: true,
                  expand: true,
                  child: TextViewer(scheduledWorkout.note!, 'Note'))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLog = scheduledWorkout.loggedWorkoutId != null;
    final isPartOfPlan = scheduledWorkout.workoutPlanEnrolmentId != null;

    return ContextMenu(
      key: Key('ScheduledWorkoutCard ${scheduledWorkout.id}'),
      child: Card(
        child: scheduledWorkout.workout == null
            ? Column(
                children: [
                  MyText(
                    'No workout specified!',
                    maxLines: 4,
                  ),
                  MyText(
                    '(The workout may have been deleted)',
                    maxLines: 4,
                  ),
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                    child: _buildCardHeader(context, true),
                  ),
                  HorizontalLine(),
                  WorkoutCard(
                    scheduledWorkout.workout!,
                    withBoxShadow: false,
                    hideBackgroundImage: true,
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 4, right: 4),
                  )
                ],
              ),
      ),
      menuChild: Card(
        child: Column(
          children: [
            _buildCardHeader(context, false),
            HorizontalLine(),
            WorkoutCard(
              scheduledWorkout.workout!,
              withBoxShadow: false,
              showEquipment: false,
              showMoves: false,
              hideBackgroundImage: true,
              padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
            )
          ],
        ),
      ),
      actions: [
        if (!hasLog)
          ContextMenuAction(
            text: 'Do it',
            onTap: () => context.navigateTo(DoWorkoutWrapperRoute(
                id: scheduledWorkout.workout!.id,
                scheduledWorkoutId: scheduledWorkout.id)),
            iconData: CupertinoIcons.arrow_right_square,
          ),
        if (!hasLog)
          ContextMenuAction(
            text: 'Log it',
            onTap: () => context.navigateTo(LoggedWorkoutCreatorRoute(
                workout: scheduledWorkout.workout!,
                scheduledWorkout: scheduledWorkout)),
            iconData: CupertinoIcons.doc_chart,
          ),
        ContextMenuAction(
            text: 'View Workout',
            iconData: CupertinoIcons.eye,
            onTap: () => context.navigateTo(
                WorkoutDetailsRoute(id: scheduledWorkout.workout!.id))),
        if (isPartOfPlan)
          ContextMenuAction(
            text: 'View Plan',
            onTap: () => context.navigateTo(WorkoutPlanEnrolmentDetailsRoute(
                id: scheduledWorkout.workoutPlanEnrolmentId!)),
            iconData: CupertinoIcons.list_bullet,
          ),
        if (hasLog)
          ContextMenuAction(
            text: 'View log',
            onTap: () => context.navigateTo(LoggedWorkoutDetailsRoute(
                id: scheduledWorkout.loggedWorkoutId!)),
            iconData: CupertinoIcons.doc_chart,
          ),
        if (!hasLog)
          ContextMenuAction(
            text: 'Edit Schedule',
            onTap: () => _reschedule(context),
            iconData: CupertinoIcons.calendar_badge_plus,
          ),
        if (!hasLog)
          ContextMenuAction(
            text: 'Unschedule',
            onTap: () => _confirmUnschedule(context),
            iconData: CupertinoIcons.calendar_badge_minus,
            destructive: true,
          )
      ],
    );
  }
}
