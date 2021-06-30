import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/logging/reps_score_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
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
    final includedSectionIds =
        context.select<LoggedWorkoutCreatorBloc, List<String>>(
            (b) => b.includedSectionIds);

    final loggedWorkoutSections =
        context.select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
            (b) => b.loggedWorkout.loggedWorkoutSections);

    final note = context
        .select<LoggedWorkoutCreatorBloc, String?>((b) => b.loggedWorkout.note);

    final gymProfile = context.select<LoggedWorkoutCreatorBloc, GymProfile?>(
        (b) => b.loggedWorkout.gymProfile);

    final completedOn = context.select<LoggedWorkoutCreatorBloc, DateTime>(
        (b) => b.loggedWorkout.completedOn);

    return Column(
      children: [
        DatePickerDisplay(
          dateTime: completedOn,
          updateDateTime: _updateCompletedOnDate,
        ),
        SizedBox(height: 12),
        TimePickerDisplay(
          timeOfDay: TimeOfDay.fromDateTime(completedOn),
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
          text: note ?? '',
          onSave: (t) => _bloc.updateNote(t),
          inputValidation: (t) => true,
          maxDisplayLines: 6,
        ),
        HorizontalLine(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyText(
            'Select sections to include',
            weight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: ListView.separated(
              itemBuilder: (c, i) => IncludeWorkoutSectionSelector(
                    loggedWorkoutSection: loggedWorkoutSections[i],
                    isSelected: includedSectionIds
                        .contains(loggedWorkoutSections[i].id),
                    toggleSelection: () =>
                        _bloc.toggleIncludeSection(loggedWorkoutSections[i]),
                  ),
              separatorBuilder: (c, i) => HorizontalLine(),
              itemCount: loggedWorkoutSections.length),
        ),
      ],
    );
  }
}

class IncludeWorkoutSectionSelector extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  final bool isSelected;
  final void Function() toggleSelection;
  IncludeWorkoutSectionSelector(
      {required this.loggedWorkoutSection,
      required this.isSelected,
      required this.toggleSelection});

  void _updateScore(BuildContext context, int repScore) {
    context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
        loggedWorkoutSection.sortPosition, {'repScore': repScore});
  }

  void _updateDuration(BuildContext context, int timeTakenMs) {
    context.read<LoggedWorkoutCreatorBloc>().editLoggedWorkoutSection(
        loggedWorkoutSection.sortPosition, {'timeTakenMs': timeTakenMs});
  }

  void _toggleSelection(BuildContext context) {
    if (isSelected) {
      toggleSelection();
    } else {
      if ([kAMRAPName, kLastStandingName]
              .contains(loggedWorkoutSection.workoutSectionType.name) &&
          loggedWorkoutSection.repScore == null) {
        context.showBottomSheet(
            expand: true,
            child: RepsScorePicker(
              score: loggedWorkoutSection.repScore,
              section: loggedWorkoutSection,
              updateScore: (score) {
                _updateScore(context, score);
                toggleSelection();
              },
            ));
      } else if ([kFreeSessionName, kForTimeName]
              .contains(loggedWorkoutSection.workoutSectionType.name) &&
          loggedWorkoutSection.timeTakenMs == null) {
        context.showBottomSheet(
            child: DurationPicker(
          duration: null,
          updateDuration: (duration) {
            _updateDuration(context, duration.inMilliseconds);
            toggleSelection();
          },
          title: 'Workout duration?',
        ));
      } else {
        toggleSelection();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  Utils.textNotNull(loggedWorkoutSection.name)
                      ? '${loggedWorkoutSection.sortPosition + 1}. ${loggedWorkoutSection.name}'
                      : '${loggedWorkoutSection.sortPosition + 1}. ${loggedWorkoutSection.workoutSectionType.name}',
                  subtext: !isSelected,
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: isSelected ? 1 : 0.5,
                child: Row(
                  children: [
                    if ([kEMOMName, kHIITCircuitName, kTabataName]
                        .contains(loggedWorkoutSection.workoutSectionType.name))
                      MyText(
                        'Duration: ${DataUtils.calculateTimedLoggedSectionDuration(loggedWorkoutSection).compactDisplay()}',
                        weight: FontWeight.bold,
                      ),
                    if ([kAMRAPName, kLastStandingName]
                        .contains(loggedWorkoutSection.workoutSectionType.name))
                      RepsScoreDisplay<LoggedWorkoutSection>(
                        score: loggedWorkoutSection.repScore,
                        section: loggedWorkoutSection,
                        updateScore: (int score) =>
                            _updateScore(context, score),
                      ),
                    if ([kForTimeName, kFreeSessionName]
                        .contains(loggedWorkoutSection.workoutSectionType.name))
                      DurationPickerDisplay(
                        modalTitle: 'Workout duration',
                        duration: loggedWorkoutSection.timeTakenMs != null
                            ? Duration(
                                milliseconds: loggedWorkoutSection.timeTakenMs!)
                            : null,
                        updateDuration: (duration) =>
                            _updateDuration(context, duration.inMilliseconds),
                      )
                  ],
                ),
              ),
              CircularCheckbox(
                  onPressed: (_) => _toggleSelection(context),
                  isSelected: isSelected)
            ],
          ),
        ],
      ),
    );
  }
}
