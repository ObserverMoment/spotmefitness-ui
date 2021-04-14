import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/tags.dart';
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
  @override
  Widget build(BuildContext context) {
    final _updateWorkoutMeta =
        context.read<WorkoutCreatorBloc>().updateWorkoutMeta;
    final _workoutData = context.watch<WorkoutCreatorBloc>().workoutData;

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
                        initialValue: _workoutData.name,
                        onChanged: (text) => _updateWorkoutMeta({'name': text}),
                        validator: () => _workoutData.name.length > 2,
                      ),
                    ]),
              ),
              EditableTextAreaRow(
                title: 'Description',
                text: _workoutData.description ?? '',
                placeholder: 'Add description...',
                onSave: (text) => _updateWorkoutMeta({'description': text}),
                inputValidation: (t) => true,
                maxDisplayLines: 2,
              ),
              SizedBox(height: 6),
              TappableRow(
                  title: 'Goals',
                  display: _workoutData.workoutGoals.isEmpty
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
                                children: _workoutData.workoutGoals
                                    .map((g) => Tag(tag: g.name))
                                    .toList(),
                              )),
                        ),
                  onTap: () => context.push(
                          child: WorkoutGoalsSelector(
                        selectedWorkoutGoals: _workoutData.workoutGoals,
                        updateSelectedWorkoutGoals: (goals) =>
                            _updateWorkoutMeta({
                          'WorkoutGoals': goals.map((g) => g.toJson()).toList()
                        }),
                      ))),
              SizedBox(height: 16),
              TappableRow(
                  title: 'Tags',
                  display: _workoutData.workoutTags.isEmpty
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
                                children: _workoutData.workoutTags
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
                        selectedWorkoutTags: _workoutData.workoutTags,
                        updateSelectedWorkoutTags: (tags) =>
                            _updateWorkoutMeta({
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
                    CupertinoSlidingSegmentedControl<ContentAccessScope>(
                        thumbColor: Styles.colorOne,
                        groupValue: _workoutData.contentAccessScope,
                        children: <ContentAccessScope, Widget>{
                          for (final v in ContentAccessScope.values.where((v) =>
                              v != ContentAccessScope.artemisUnknown &&
                              v != ContentAccessScope.official))
                            v: MyText(v.display)
                        },
                        onValueChanged: (scope) => _updateWorkoutMeta(
                            {'contentAccessScope': scope?.apiValue})),
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