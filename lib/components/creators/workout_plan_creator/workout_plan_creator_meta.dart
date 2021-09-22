import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sofie_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:sofie_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:sofie_ui/components/user_input/number_picker_modal.dart';
import 'package:sofie_ui/components/user_input/pickers/sliding_select.dart';
import 'package:sofie_ui/components/user_input/selectors/workout_tags_selector.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class WorkoutPlanCreatorMeta extends StatelessWidget {
  const WorkoutPlanCreatorMeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _updateWorkoutPlanMeta =
        context.read<WorkoutPlanCreatorBloc>().updateWorkoutPlanMeta;

    final workoutPlanData = context
        .select<WorkoutPlanCreatorBloc, WorkoutPlan>((b) => b.workoutPlan);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            UserInputContainer(
              child: TappableRow(
                  onTap: () => context.showActionSheetPopup(
                          child: NumberPickerModal(
                        initialValue: workoutPlanData.lengthWeeks,
                        min: 1,
                        max: 52,
                        saveValue: (lengthWeeks) {
                          if (lengthWeeks < workoutPlanData.lengthWeeks) {
                            context.showConfirmDialog(
                                title: 'Reduce Length of Plan?',
                                content: const MyText(
                                  'If you have planned workouts in later weeks will be deleted. OK?',
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                ),
                                onConfirm: () => context
                                    .read<WorkoutPlanCreatorBloc>()
                                    .reduceWorkoutPlanlength(lengthWeeks));
                          } else {
                            _updateWorkoutPlanMeta(
                                {'lengthWeeks': lengthWeeks});
                          }
                        },
                        title: 'Weeks',
                      )),
                  display: Row(
                    children: [
                      ContentBox(
                        child: MyText(
                          workoutPlanData.lengthWeeks.toString(),
                          size: FONTSIZE.six,
                          weight: FontWeight.bold,
                          lineHeight: 1.2,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const MyText('weeks')
                    ],
                  ),
                  title: 'Plan Length'),
            ),
            UserInputContainer(
              child: TappableRow(
                  onTap: () => context.showActionSheetPopup(
                          child: NumberPickerModal(
                        initialValue: workoutPlanData.daysPerWeek,
                        min: 1,
                        max: 7,
                        saveValue: (daysPerWeek) => _updateWorkoutPlanMeta(
                            {'daysPerWeek': daysPerWeek}),
                        title: 'Days Per Week',
                      )),
                  display: Row(
                    children: [
                      ContentBox(
                        child: MyText(
                          workoutPlanData.daysPerWeek.toString(),
                          size: FONTSIZE.six,
                          weight: FontWeight.bold,
                          lineHeight: 1.2,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MyText(workoutPlanData.daysPerWeek == 1
                          ? 'day / week'
                          : 'days / week')
                    ],
                  ),
                  title: 'Days Per Week'),
            ),
            UserInputContainer(
              child: EditableTextFieldRow(
                title: 'Name',
                text: workoutPlanData.name,
                onSave: (text) => _updateWorkoutPlanMeta({'name': text}),
                inputValidation: (t) => t.length > 2 && t.length <= 50,
                maxChars: 50,
                validationMessage: 'Required. Min 3 chars. max 50',
              ),
            ),
            UserInputContainer(
              child: EditableTextAreaRow(
                title: 'Description',
                text: workoutPlanData.description ?? '',
                placeholder: 'Add description...',
                onSave: (text) => _updateWorkoutPlanMeta({'description': text}),
                inputValidation: (t) => true,
                maxDisplayLines: 2,
              ),
            ),
            WorkoutTagsSelectorRow(
              selectedWorkoutTags: workoutPlanData.workoutTags,
              updateSelectedWorkoutTags: (tags) => _updateWorkoutPlanMeta(
                  {'WorkoutTags': tags.map((t) => t.toJson()).toList()}),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: UserInputContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText('Audience'),
                    SlidingSelect<ContentAccessScope>(
                        value: workoutPlanData.contentAccessScope,
                        children: <ContentAccessScope, Widget>{
                          for (final v in ContentAccessScope.values.where(
                              (v) => v != ContentAccessScope.artemisUnknown))
                            v: MyText(v.display)
                        },
                        updateValue: (scope) => _updateWorkoutPlanMeta(
                            {'contentAccessScope': scope.apiValue})),
                    const InfoPopupButton(
                        infoWidget: MyText(
                            'Explaining the difrerent scopes and what they mean.')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
