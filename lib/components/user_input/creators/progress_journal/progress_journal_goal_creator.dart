import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/creators/progress_journal/progress_journal_goal_tags_manager.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ProgressJournalGoalCreator extends StatefulWidget {
  final ProgressJournalGoal? progressJournalGoal;
  ProgressJournalGoalCreator({this.progressJournalGoal});
  @override
  _ProgressJournalGoalCreatorState createState() =>
      _ProgressJournalGoalCreatorState();
}

class _ProgressJournalGoalCreatorState
    extends State<ProgressJournalGoalCreator> {
  late ProgressJournalGoal _activeProgressJournalGoal;
  late bool _isEditing;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.progressJournalGoal != null;
    _activeProgressJournalGoal = _isEditing
        ? widget.progressJournalGoal!
        : DefaultObjectfactory.defaultProgressJournalGoal();
  }

  void _updateName(String name) =>
      setState(() => _activeProgressJournalGoal.name = name);

  void _updateDescription(String description) =>
      setState(() => _activeProgressJournalGoal.description = description);

  void _updateDeadline(DateTime deadline) =>
      setState(() => _activeProgressJournalGoal.deadline = deadline);

  void _toggleSelectTag(ProgressJournalGoalTag tag) =>
      setState(() => _activeProgressJournalGoal.progressJournalGoalTags =
          _activeProgressJournalGoal.progressJournalGoalTags
              .toggleItem<ProgressJournalGoalTag>(tag));

  void _handelSave() {
    setState(() => _isLoading = true);

    print('save to api and update store');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
          leading: NavBarCancelButton(context.pop),
          middle: NavBarTitle(_isEditing ? 'Update Goal' : 'Add Goal'),
          trailing: AnimatedSwitcher(
            duration: kStandardAnimationDuration,
            child: _isLoading
                ? LoadingDots(size: 12)
                : NavBarSaveButton(_handelSave),
          )),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              EditableTextFieldRow(
                  title: 'Name',
                  text: _activeProgressJournalGoal.name,
                  onSave: _updateName,
                  validationMessage: 'Min 3, max 30 characters',
                  maxChars: 30,
                  inputValidation: (t) => t.length > 3 && t.length < 31),
              EditableTextAreaRow(
                  title: 'Description',
                  text: _activeProgressJournalGoal.description ?? '',
                  onSave: _updateDescription,
                  inputValidation: (t) => true),
              DatePickerDisplay(
                dateTime: _activeProgressJournalGoal.deadline,
                updateDateTime: _updateDeadline,
                title: 'Deadline',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      'Tags',
                    ),
                    InfoPopupButton(infoWidget: MyText('Info about tags'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: MyText(
                  _activeProgressJournalGoal.progressJournalGoalTags.isEmpty
                      ? 'No tags selected'
                      : '${_activeProgressJournalGoal.progressJournalGoalTags.length} tags selected',
                  subtext: true,
                ),
              ),
              QueryObserver<ProgressJournalGoalTags$Query,
                      json.JsonSerializable>(
                  key: Key(
                      'ProgressJournalGoalCreator - ${ProgressJournalGoalTagsQuery().operationName}'),
                  query: ProgressJournalGoalTagsQuery(),
                  builder: (data) {
                    final tags = data.progressJournalGoalTags;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: tags
                            .map((tag) => SelectableTag(
                                  text: tag.tag,
                                  selectedColor: HexColor.fromHex(tag.hexColor),
                                  onPressed: () => _toggleSelectTag(tag),
                                  isSelected: _activeProgressJournalGoal
                                      .progressJournalGoalTags
                                      .contains(tag),
                                ))
                            .toList(),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CreateTextIconButton(
                    text: 'New Tag',
                    onPressed: () =>
                        context.push(child: ProgressJournalGoalTagsManager())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
