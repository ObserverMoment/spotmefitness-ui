import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_goals_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_tags_selector.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutCreatorMeta extends StatelessWidget {
  final WorkoutData workoutData;

  /// Top level data fields accessed via a key.
  final Function(Map<String, dynamic> data) updateWorkoutMetaData;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  WorkoutCreatorMeta(
      {required this.workoutData,
      required this.updateWorkoutMetaData,
      required this.nameController,
      required this.descriptionController});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoFormSection.insetGrouped(
                    margin: EdgeInsets.zero,
                    children: [
                      MyTextFormFieldRow(
                        placeholder: 'Name (Required - min 3 chars)',
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        validator: () => nameController.text.length > 2,
                      ),
                    ]),
              ),
              EditableTextAreaRow(
                title: 'Description',
                text: descriptionController.text,
                placeholder: 'Add description...',
                onSave: (text) =>
                    descriptionController.value = TextEditingValue(text: text),
                inputValidation: (t) => true,
                maxDisplayLines: 2,
              ),
              SizedBox(height: 6),
              TappableRow(
                  title: 'Goals',
                  display: workoutData.workoutGoals.isEmpty
                      ? MyText(
                          'Add some goals...',
                          subtext: true,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 4,
                                runSpacing: 4,
                                children: workoutData.workoutGoals
                                    .map((g) => Tag(tag: g.name))
                                    .toList(),
                              )),
                        ),
                  onTap: () => context.push(
                          child: WorkoutGoalsSelector(
                        selectedWorkoutGoals: workoutData.workoutGoals,
                        updateSelectedWorkoutGoals: (goals) =>
                            updateWorkoutMetaData({
                          'WorkoutGoals': goals.map((g) => g.toJson()).toList()
                        }),
                      ))),
              SizedBox(height: 16),
              TappableRow(
                  title: 'Tags',
                  display: workoutData.workoutTags.isEmpty
                      ? MyText(
                          'Add some tags...',
                          subtext: true,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 4,
                                runSpacing: 4,
                                children: workoutData.workoutTags
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
                        selectedWorkoutTags: workoutData.workoutTags,
                        updateSelectedWorkoutTags: (tags) =>
                            updateWorkoutMetaData({
                          'WorkoutTags': tags.map((t) => t.toJson()).toList()
                        }),
                      ))),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoSlidingSegmentedControl<ContentAccessScope>(
                      thumbColor: Styles.colorOne,
                      groupValue: workoutData.contentAccessScope,
                      children: <ContentAccessScope, Widget>{
                        for (final v in ContentAccessScope.values.where((v) =>
                            v != ContentAccessScope.artemisUnknown &&
                            v != ContentAccessScope.official))
                          v: MyText(v.display)
                      },
                      onValueChanged: (scope) => updateWorkoutMetaData(
                          {'contentAccessScope': scope?.apiValue})),
                  InfoPopupButton(
                      infoWidget: MyText(
                          'Explaining the difrerent scopes and what they mean.')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
