import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Also lets you create a new tag and then select.
class WorkoutTagsSelector extends StatefulWidget {
  final List<WorkoutTag> selectedWorkoutTags;
  final void Function(List<WorkoutTag> updated) updateSelectedWorkoutTags;
  WorkoutTagsSelector(
      {required this.selectedWorkoutTags,
      required this.updateSelectedWorkoutTags});

  @override
  _WorkoutTagsSelectorState createState() => _WorkoutTagsSelectorState();
}

class _WorkoutTagsSelectorState extends State<WorkoutTagsSelector> {
  List<WorkoutTag> _activeSelectedWorkoutTags = [];

  @override
  void initState() {
    super.initState();
    _activeSelectedWorkoutTags = [...widget.selectedWorkoutTags];
  }

  void _updateSelected(WorkoutTag tapped) {
    setState(() {
      _activeSelectedWorkoutTags =
          _activeSelectedWorkoutTags.toggleItem<WorkoutTag>(tapped);
    });
    widget.updateSelectedWorkoutTags(_activeSelectedWorkoutTags);
  }

  void _openCreateNewTag() async {
    context.push(
        child: FullScreenTextEditing(
      title: 'New Tag',
      inputValidation: (text) => text.length > 2 && text.length <= 20,
      validationMessage: 'Min chars: 3, Max chars 20',
      initialValue: '',
      onSave: (text) => print(text),
      maxChars: 20,
      maxInputLines: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: MyText(
              'Done',
              weight: FontWeight.bold,
            ),
            onPressed: () => Navigator.pop(context)),
        middle: NavBarTitle('Workout Tags'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CreateIconButton(onPressed: _openCreateNewTag),
            InfoPopupButton(
              infoWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  'Info about this workout tags.',
                  maxLines: 10,
                ),
              ),
            )
          ],
        ),
      ),
      child: Query(
        options: QueryOptions(
            document: UserWorkoutTagsQuery().document,
            fetchPolicy: FetchPolicy.cacheFirst),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final _workoutTags =
                  UserWorkoutTags$Query.fromJson(result.data ?? {})
                      .userWorkoutTags;
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyText(
                          'Click to select / deselect.',
                          subtext: true,
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: _workoutTags
                              .map((tag) => GestureDetector(
                                    onTap: () => _updateSelected(tag),
                                    child: SelectableTag(
                                      tag: tag,
                                      isSelected: _activeSelectedWorkoutTags
                                          .contains(tag),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class SelectableTag extends StatelessWidget {
  final WorkoutTag tag;
  final bool isSelected;
  SelectableTag({required this.tag, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? Styles.colorOne : null,
          border: Border.all(color: context.theme.primary)),
      child: MyText(tag.tag),
    );
  }
}
