import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:provider/provider.dart';

class LoggedWorkoutCreatorMeta extends StatefulWidget {
  @override
  _LoggedWorkoutCreatorMetaState createState() =>
      _LoggedWorkoutCreatorMetaState();
}

class _LoggedWorkoutCreatorMetaState extends State<LoggedWorkoutCreatorMeta> {
  late LoggedWorkoutCreatorBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LoggedWorkoutCreatorBloc>();
  }

  void _updateCompletedOnDate(DateTime date) {
    final prev = _bloc.loggedWorkout.completedOn;
    _bloc.updateCompletedOn(DateTime(
        date.year, date.month, date.day, prev.hour, prev.minute, prev.second));
  }

  void _updateCompletedOnTime(TimeOfDay time) {
    final prev = _bloc.loggedWorkout.completedOn;
    _bloc.updateCompletedOn(
        DateTime(prev.year, prev.month, prev.day, time.hour, time.minute));
  }

  @override
  Widget build(BuildContext context) {
    final sectionsToInclude =
        context.select<LoggedWorkoutCreatorBloc, List<WorkoutSection>>(
            (b) => b.sectionsToIncludeInLog);
    final loggedWorkout =
        context.select<LoggedWorkoutCreatorBloc, CreateLoggedWorkoutInput>(
            (b) => b.loggedWorkout);
    final gymProfile = context
        .select<LoggedWorkoutCreatorBloc, GymProfile?>((b) => b.gymProfile);
    final workout =
        context.select<LoggedWorkoutCreatorBloc, Workout>((b) => b.workout);

    return Column(
      children: [
        DatePickerDisplay(
          dateTime: loggedWorkout.completedOn,
          updateDateTime: _updateCompletedOnDate,
        ),
        SizedBox(height: 12),
        TimePickerDisplay(
          timeOfDay: TimeOfDay.fromDateTime(loggedWorkout.completedOn),
          updateTimeOfDay: _updateCompletedOnTime,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TappableRow(
                onTap: () => context.showBottomSheet(
                    child: SafeArea(
                        child: GymProfileSelector(
                  selectedGymProfile: gymProfile,
                  selectGymProfile: (p) => _bloc.updateGymProfile(p),
                ))),
                title: 'Gym Profile',
                display: gymProfile == null
                    ? MyText(
                        'Select...',
                        subtext: true,
                      )
                    : MyText(gymProfile.name),
              ),
            ),
            CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.clear_thick,
                  color: Styles.errorRed,
                  size: 20,
                ),
                onPressed: () => _bloc.updateGymProfile(null))
          ],
        ),
        EditableTextAreaRow(
          title: 'Note',
          text: loggedWorkout.note ?? '',
          onSave: (t) => _bloc.updateNote(t),
          inputValidation: (t) => true,
          maxDisplayLines: 6,
        ),
        HorizontalLine(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyText('Choose sections to include in the log.'),
        ),
        Flexible(
          child: ListView.separated(
              itemBuilder: (c, i) => IncludeWorkoutSectionSelector(
                    workoutSection: workout.workoutSections[i],
                    isSelected:
                        sectionsToInclude.contains(workout.workoutSections[i]),
                    toggleSelection: () =>
                        _bloc.toggleIncludeSection(workout.workoutSections[i]),
                  ),
              separatorBuilder: (c, i) => HorizontalLine(),
              itemCount: workout.workoutSections.length),
        ),
      ],
    );
  }
}

class IncludeWorkoutSectionSelector extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool isSelected;
  final void Function() toggleSelection;
  IncludeWorkoutSectionSelector(
      {required this.workoutSection,
      required this.isSelected,
      required this.toggleSelection});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              Utils.textNotNull(workoutSection.name)
                  ? workoutSection.name!
                  : 'Section ${workoutSection.sortPosition}',
              subtext: !isSelected,
            ),
          ),
          CircularCheckbox(
              onPressed: (_) => toggleSelection(), isSelected: isSelected)
        ],
      ),
    );
  }
}
