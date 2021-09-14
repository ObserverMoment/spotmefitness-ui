import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/logged_workout_creator_section_details.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/number_picker.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/gym_profile_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutCreatorWithSections extends StatelessWidget {
  const LoggedWorkoutCreatorWithSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoggedWorkoutCreatorBloc>();

    final note = context
        .select<LoggedWorkoutCreatorBloc, String?>((b) => b.loggedWorkout.note);

    final gymProfile = context.select<LoggedWorkoutCreatorBloc, GymProfile?>(
        (b) => b.loggedWorkout.gymProfile);

    final completedOn = context.select<LoggedWorkoutCreatorBloc, DateTime>(
        (b) => b.loggedWorkout.completedOn);

    final loggedWorkoutSections =
        context.select<LoggedWorkoutCreatorBloc, List<LoggedWorkoutSection>>(
            (b) => b.loggedWorkout.loggedWorkoutSections);

    return ListView(
      children: [
        UserInputContainer(
          child: DateTimePickerDisplay(
            dateTime: completedOn,
            saveDateTime: bloc.updateCompletedOn,
          ),
        ),
        UserInputContainer(
          child: GymProfileSelectorDisplay(
            clearGymProfile: () => bloc.updateGymProfile(null),
            gymProfile: gymProfile,
            selectGymProfile: bloc.updateGymProfile,
          ),
        ),
        UserInputContainer(
          child: EditableTextAreaRow(
            title: 'Note',
            text: note ?? '',
            onSave: (t) => bloc.updateNote(t),
            inputValidation: (t) => true,
            maxDisplayLines: 6,
          ),
        ),
        ...loggedWorkoutSections
            .map((lws) => Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: _SelectedLoggedWorkoutSection(
                      sectionIndex: lws.sortPosition),
                ))
            .toList()
      ],
    );
  }
}

class _SelectedLoggedWorkoutSection extends StatelessWidget {
  final int sectionIndex;
  const _SelectedLoggedWorkoutSection({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedWorkoutSection =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex]);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Utils.textNotNull(loggedWorkoutSection.name))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: MyHeaderText(loggedWorkoutSection.name!),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: MyText(
                        loggedWorkoutSection.workoutSectionType.name,
                        color: Styles.colorTwo,
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () => context.push(
                    child: LoggedWorkoutCreatorSectionDetails(
                        loggedWorkoutSection: loggedWorkoutSection)),
                child: Icon(CupertinoIcons.list_number),
              ),
            ],
          ),
          Row(
            children: [
              ContentBox(
                backgroundColor: context.theme.background,
                child: NumberPickerInt(
                  contentBoxColor: context.theme.background,
                  number: loggedWorkoutSection.repScore,
                  saveValue: (repScore) => context
                      .read<LoggedWorkoutCreatorBloc>()
                      .updateRepScore(
                          loggedWorkoutSection.sortPosition, repScore),
                  fontSize: FONTSIZE.LARGE,
                  prefix: Icon(
                    CupertinoIcons.chart_bar_alt_fill,
                    size: 22,
                  ),
                  suffix: MyText(
                    'reps',
                    size: FONTSIZE.SMALL,
                  ),
                ),
              ),
              SizedBox(width: 16),
              ContentBox(
                backgroundColor: context.theme.background,
                child: DurationPickerDisplay(
                    modalTitle: 'Update Duration',
                    duration: Duration(
                        seconds: loggedWorkoutSection.timeTakenSeconds),
                    updateDuration: (duration) => context
                        .read<LoggedWorkoutCreatorBloc>()
                        .updateTimeTakenSeconds(
                            loggedWorkoutSection.sortPosition,
                            duration.inSeconds)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
