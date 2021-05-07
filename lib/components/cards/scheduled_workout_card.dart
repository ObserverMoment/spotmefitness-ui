import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/scheduled_workout/scheduled_workout_creator.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/model/toast_request.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ScheduledWorkoutCard extends StatelessWidget {
  final ScheduledWorkout scheduledWorkout;
  ScheduledWorkoutCard(this.scheduledWorkout);

  Widget? _buildMarker() {
    final color = scheduledWorkout.loggedWorkout != null
        ? Styles.colorOne // Done
        : scheduledWorkout.scheduledAt.isBefore(DateTime.now())
            ? Styles.errorRed // Missed
            : Styles.colorFour; // Upcoming
    final IconData icon = scheduledWorkout.loggedWorkout != null
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
        )
      ],
    );
  }

  Future<void> _reschedule(BuildContext context) async {
    final result = await context.showBottomSheet(
        showDragHandle: false,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(
                        DateFormat('MMM d, H:m')
                            .format(scheduledWorkout.scheduledAt),
                        weight: FontWeight.bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: _buildMarker(),
                      ),
                    ],
                  ),
                  if (scheduledWorkout.gymProfile != null)
                    MyText(
                      '(${scheduledWorkout.gymProfile!.name})',
                      lineHeight: 1.8,
                      color: Styles.colorTwo,
                    ),
                ],
              ),
              Row(
                children: [
                  if (Utils.textNotNull(scheduledWorkout.note))
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: NotesIcon(),
                        onPressed: () => context.showBottomSheet(
                            expand: true,
                            child: TextViewer(scheduledWorkout.note!, 'Note'))),
                  NavBarEllipsisMenu(ellipsisCircled: false, items: [
                    ContextMenuItem(
                      text: 'Do it',
                      onTap: () => print('do it'),
                      iconData: CupertinoIcons.arrow_right_square,
                    ),
                    ContextMenuItem(
                      text: 'Log it',
                      onTap: () => print('log it'),
                      iconData: CupertinoIcons.doc_on_clipboard,
                    ),
                    ContextMenuItem(
                        text: 'View it',
                        iconData: CupertinoIcons.eye,
                        onTap: () => context.router.push(WorkoutDetailsRoute(
                            id: scheduledWorkout.workout.id))),
                    if (scheduledWorkout.loggedWorkout != null)
                      ContextMenuItem(
                        text: 'View log',
                        onTap: () => print('view log'),
                        iconData: CupertinoIcons.doc_richtext,
                      ),
                    ContextMenuItem(
                      text: 'Reschedule',
                      onTap: () => _reschedule(context),
                      iconData: CupertinoIcons.calendar_badge_plus,
                    ),
                    ContextMenuItem(
                      text: 'Unschedule',
                      onTap: () => _confirmUnschedule(context),
                      iconData: CupertinoIcons.calendar_badge_minus,
                      destructive: true,
                    )
                  ])
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          WorkoutCard(
            scheduledWorkout.workout,
            withBoxShadow: false,
          )
        ],
      ),
    );
  }
}
