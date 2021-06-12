import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/number_input_modal.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_tags_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class WorkoutPlanCreatorMeta extends StatelessWidget {
  const WorkoutPlanCreatorMeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _updateWorkoutPlanMeta =
        context.read<WorkoutPlanCreatorBloc>().updateWorkoutPlanMeta;

    final workoutPlanData = context
        .select<WorkoutPlanCreatorBloc, WorkoutPlan>((b) => b.workoutPlan);

    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TappableRow(
                  onTap: () => context.showBottomSheet<int>(
                          child: NumberInputModalInt(
                        value: workoutPlanData.lengthWeeks,
                        // Need to cast to dynamic because of this.
                        // https://github.com/dart-lang/sdk/issues/32042
                        saveValue: (lengthWeeks) {
                          if (lengthWeeks < workoutPlanData.lengthWeeks) {
                            context.showConfirmDialog(
                                title: 'Reduce Length of Plan?',
                                content: MyText(
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
                          size: FONTSIZE.DISPLAY,
                          weight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      MyText('weeks')
                    ],
                  ),
                  title: 'Plan Length'),
              EditableTextFieldRow(
                title: 'Name',
                text: workoutPlanData.name,
                onSave: (text) => _updateWorkoutPlanMeta({'name': text}),
                inputValidation: (t) => t.length > 2 && t.length <= 50,
                isRequired: true,
                maxChars: 50,
                validationMessage: 'Required. Min 3 chars. max 50',
              ),
              EditableTextAreaRow(
                title: 'Description',
                text: workoutPlanData.description ?? '',
                placeholder: 'Add description...',
                onSave: (text) => _updateWorkoutPlanMeta({'description': text}),
                inputValidation: (t) => true,
                maxDisplayLines: 2,
              ),
              SizedBox(height: 8),
              TappableRow(
                  title: 'Tags',
                  display: workoutPlanData.workoutTags.isEmpty
                      ? MyText(
                          'Add some tags...',
                          subtext: true,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                spacing: 4,
                                runSpacing: 4,
                                children: workoutPlanData.workoutTags
                                    .map((t) => Tag(
                                          tag: t.tag,
                                          color: Styles.colorOne,
                                          textColor: Styles.white,
                                        ))
                                    .toList(),
                              )),
                        ),
                  onTap: () => context.push(
                          child: WorkoutTagsSelector(
                        selectedWorkoutTags: workoutPlanData.workoutTags,
                        updateSelectedWorkoutTags: (tags) =>
                            _updateWorkoutPlanMeta({
                          'WorkoutTags': tags.map((t) => t.toJson()).toList()
                        }),
                      ))),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText('Audience'),
                    SlidingSelect<ContentAccessScope>(
                        value: workoutPlanData.contentAccessScope,
                        children: <ContentAccessScope, Widget>{
                          for (final v in ContentAccessScope.values.where(
                              (v) => v != ContentAccessScope.artemisUnknown))
                            v: MyText(v.display)
                        },
                        updateValue: (scope) => _updateWorkoutPlanMeta(
                            {'contentAccessScope': scope.apiValue})),
                    InfoPopupButton(
                        infoWidget: MyText(
                            'Explaining the difrerent scopes and what they mean.')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
