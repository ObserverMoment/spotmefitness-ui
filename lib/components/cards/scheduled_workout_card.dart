import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/cards/workout_card_minimal.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/menus/context_menu.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/enum.dart';
import 'package:sofie_ui/model/toast_request.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/utils.dart';

class ScheduledWorkoutCard extends StatelessWidget {
  final ScheduledWorkout scheduledWorkout;
  const ScheduledWorkoutCard({Key? key, required this.scheduledWorkout})
      : super(key: key);

  Widget? _buildMarker() {
    final hasLog = scheduledWorkout.loggedWorkoutId != null;

    final color = hasLog
        ? Styles.colorOne // Done
        : scheduledWorkout.scheduledAt.isBefore(DateTime.now())
            ? Styles.errorRed // Missed
            : Styles.infoBlue; // Upcoming
    final IconData icon = hasLog
        ? CupertinoIcons.checkmark_alt_circle // Done
        : scheduledWorkout.scheduledAt.isBefore(DateTime.now())
            ? CupertinoIcons.exclamationmark_circle // Missed
            : CupertinoIcons.clock; // Upcoming

    return Icon(
      icon,
      size: 18,
      color: color,
    );
  }

  Future<void> _reschedule(BuildContext context) async {
    final result = await context.pushRoute(ScheduledWorkoutCreatorRoute(
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
        icon: const Icon(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyText(
                  '${scheduledWorkout.scheduledAt.minimalDateString}, ${scheduledWorkout.scheduledAt.timeString}',
                  lineHeight: 1.3,
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
                size: FONTSIZE.two,
              ),
          ],
        ),
        if (showNote && Utils.textNotNull(scheduledWorkout.note))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ViewMoreFullScreenTextBlock(
              text: scheduledWorkout.note!,
              title: 'Note',
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasLog = scheduledWorkout.loggedWorkoutId != null;
    final isPartOfPlan = scheduledWorkout.workoutPlanEnrolmentId != null;

    return ContextMenu(
      key: Key('ScheduledWorkoutCard ${scheduledWorkout.id}'),
      menuChild: Card(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: _buildCardHeader(context, false),
            ),
            const HorizontalLine(
              verticalPadding: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: MinimalWorkoutCard(
                scheduledWorkout.workout!,
                withBoxShadow: false,
              ),
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
                scheduledWorkout: scheduledWorkout)),
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
      child: Card(
        padding: EdgeInsets.zero,
        child: scheduledWorkout.workout == null
            ? Center(
                child: Column(
                  children: const [
                    MyText(
                      'No workout specified!',
                      maxLines: 4,
                    ),
                    MyText(
                      '(The workout may have been deleted)',
                      maxLines: 4,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 8, left: 12, right: 12),
                    child: _buildCardHeader(context, true),
                  ),
                  const HorizontalLine(
                    verticalPadding: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2.0, bottom: 6, left: 4, right: 4),
                    child: MinimalWorkoutCard(
                      scheduledWorkout.workout!,
                      withBoxShadow: false,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
