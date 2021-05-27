import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/model/toast_request.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';

class ScheduledWorkoutCreator extends StatefulWidget {
  final ScheduledWorkout? scheduledWorkout;
  final Workout? workout;
  ScheduledWorkoutCreator({this.scheduledWorkout, this.workout})
      : assert(scheduledWorkout != null || workout != null);

  @override
  _ScheduledWorkoutCreatorState createState() =>
      _ScheduledWorkoutCreatorState();
}

class _ScheduledWorkoutCreatorState extends State<ScheduledWorkoutCreator> {
  late ScheduledWorkout _activeScheduledWorkout;
  late bool _isCreate;
  bool _loading = false;

  ScheduledWorkout _defaultScheduledWorkout() {
    return ScheduledWorkout()
      ..id = 'tempId'
      ..workout = widget.workout!
      ..scheduledAt = DateTime.now();
  }

  @override
  void initState() {
    _isCreate = widget.scheduledWorkout == null;
    _activeScheduledWorkout = widget.scheduledWorkout != null
        ? widget.scheduledWorkout!
        : _defaultScheduledWorkout();
    super.initState();
  }

  String _formatDateTime(DateTime dateTime) =>
      DateFormat("MMMM d 'at' H:m").format(dateTime);

  /// Handles creating a new scheduledWorkout and updating an existing one.
  Future<void> _schedule() async {
    setState(() => _loading = true);
    if (_isCreate) {
      final createVariables = CreateScheduledWorkoutArguments(
          data: CreateScheduledWorkoutInput.fromJson(
              _activeScheduledWorkout.toJson()));

      final result = await context.graphQLStore.create(
          mutation: CreateScheduledWorkoutMutation(variables: createVariables),
          addRefToQueries: [GQLOpNames.userScheduledWorkoutsQuery]);

      if (result.hasErrors || result.data == null) {
        context.showErrorAlert(
            'Sorry there was a problem, the workout was not scheduled.');
      } else {
        final String dateString =
            _formatDateTime(result.data!.createScheduledWorkout.scheduledAt);
        context.pop(
            result: ToastRequest(
                message: 'Workout scheduled for $dateString.',
                type: ToastType.success));
      }
    } else {
      final updateVariables = UpdateScheduledWorkoutArguments(
          data: UpdateScheduledWorkoutInput.fromJson(
              _activeScheduledWorkout.toJson()));

      final result = await context.graphQLStore.mutate(
          mutation: UpdateScheduledWorkoutMutation(variables: updateVariables),
          broadcastQueryIds: [GQLOpNames.userScheduledWorkoutsQuery]);

      if (result.hasErrors || result.data == null) {
        context.showErrorAlert(
            'Sorry there was a problem, the schedule was not updated.');
      } else {
        final String dateString =
            _formatDateTime(result.data!.updateScheduledWorkout.scheduledAt);
        context.pop(
            result: ToastRequest(
                message: 'Workout re-scheduled for $dateString.',
                type: ToastType.success));
      }
    }
    setState(() => _loading = false);
  }

  void _confirmUnschedule() {
    context.showConfirmDeleteDialog(
        itemType: 'Scheduled Workout', onConfirm: _unschedule);
  }

  Future<void> _unschedule() async {
    if (widget.scheduledWorkout != null) {
      setState(() => _loading = true);
      final variables =
          DeleteScheduledWorkoutByIdArguments(id: widget.scheduledWorkout!.id);

      final result = await context.graphQLStore.delete(
          mutation: DeleteScheduledWorkoutByIdMutation(variables: variables),
          objectId: widget.scheduledWorkout!.id,
          typename: kScheduledWorkoutTypename,
          removeRefFromQueries: [GQLOpNames.userScheduledWorkoutsQuery]);

      if (result.hasErrors) {
        context.showErrorAlert(
            'Sorry there was a problem, the schedule was not updated.');
      } else {
        setState(() => _loading = false);
        context.pop(
            result: ToastRequest(
                message: 'Workout unscheduled.', type: ToastType.destructive));
      }
    }
  }

  void _cancel() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.theme.modalBackground,
      navigationBar: BasicNavBar(
        heroTag: 'ScheduledWorkoutCreator',
        backgroundColor: context.theme.modalBackground,
        customLeading: NavBarCancelButton(_cancel),
        middle: NavBarTitle('Schedule Workout'),
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
                : NavBarSaveButton(_schedule)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DatePickerDisplay(
                    dateTime: _activeScheduledWorkout.scheduledAt,
                    updateDateTime: (DateTime d) {
                      final prev = _activeScheduledWorkout.scheduledAt;
                      setState(() {
                        _activeScheduledWorkout.scheduledAt = DateTime(
                            d.year, d.month, d.day, prev.hour, prev.minute);
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  TimePickerDisplay(
                    timeOfDay: TimeOfDay.fromDateTime(
                        _activeScheduledWorkout.scheduledAt),
                    updateTimeOfDay: (TimeOfDay t) {
                      final prev = _activeScheduledWorkout.scheduledAt;
                      setState(() {
                        _activeScheduledWorkout.scheduledAt = DateTime(
                            prev.year, prev.month, prev.day, t.hour, t.minute);
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TappableRow(
                            onTap: () => context.showBottomSheet(
                                    child: SafeArea(
                                  child: GymProfileSelector(
                                      selectedGymProfile:
                                          _activeScheduledWorkout.gymProfile,
                                      selectGymProfile: (p) => setState(() =>
                                          _activeScheduledWorkout.gymProfile =
                                              p)),
                                )),
                            title: 'Gym Profile',
                            display: _activeScheduledWorkout.gymProfile == null
                                ? MyText(
                                    'Select...',
                                    subtext: true,
                                  )
                                : MyText(
                                    _activeScheduledWorkout.gymProfile!.name)),
                      ),
                      if (_activeScheduledWorkout.gymProfile != null)
                        FadeIn(
                          child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                CupertinoIcons.clear_thick,
                                color: Styles.errorRed,
                                size: 20,
                              ),
                              onPressed: () => setState(() =>
                                  _activeScheduledWorkout.gymProfile = null)),
                        )
                    ],
                  ),
                  SizedBox(height: 12),
                  EditableTextAreaRow(
                      title: 'Note',
                      text: _activeScheduledWorkout.note ?? '',
                      onSave: (note) =>
                          setState(() => _activeScheduledWorkout.note = note),
                      maxDisplayLines: 4,
                      inputValidation: (t) => true),
                ],
              ),
              if (!_isCreate)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: DestructiveButton(
                      text: 'Unschedule',
                      suffix: Icon(CupertinoIcons.calendar_badge_minus,
                          color: Styles.white),
                      onPressed: _confirmUnschedule),
                )
            ],
          ),
        ),
      ),
    );
  }
}
