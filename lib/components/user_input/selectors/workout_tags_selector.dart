import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Also lets you create a new tag and then select it.
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

  void _openCreateNewTag() {
    context.push(
        child: FullScreenTextEditing(
      title: 'New Tag',
      inputValidation: (text) => text.length > 2 && text.length <= 20,
      validationMessage: 'Min chars: 3, Max chars 20',
      initialValue: '',
      onSave: (text) => _createNewTag(text),
      maxChars: 20,
      maxInputLines: 1,
    ));
  }

  Future<void> _createNewTag(String tag) async {
    final variables =
        CreateWorkoutTagArguments(data: CreateWorkoutTagInput(tag: tag));

    await context.graphQLStore.create(
        mutation: CreateWorkoutTagMutation(variables: variables),
        addRefToQueries: [UserWorkoutTagsQuery().operationName]);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BasicNavBar(
          customLeading: CupertinoButton(
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
        child: QueryObserver<UserWorkoutTags$Query, json.JsonSerializable>(
            key: Key(
                'WorkoutTagsSelector - ${UserWorkoutTagsQuery().operationName}'),
            query: UserWorkoutTagsQuery(),
            fetchPolicy: QueryFetchPolicy.storeFirst,
            builder: (data) {
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
                          size: FONTSIZE.SMALL,
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: data.userWorkoutTags.reversed
                              .map((tag) => GestureDetector(
                                    onTap: () => _updateSelected(tag),
                                    child: FadeIn(
                                      child: SelectableWorkoutTag(
                                        tag: tag,
                                        isSelected: _activeSelectedWorkoutTags
                                            .contains(tag),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class SelectableWorkoutTag extends StatelessWidget {
  final WorkoutTag tag;
  final bool isSelected;
  SelectableWorkoutTag({required this.tag, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? Styles.colorOne : null,
          border: Border.all(
              width: 2,
              color: isSelected
                  ? Styles.colorOne
                  : context.theme.primary.withOpacity(0.65))),
      child: MyText(
        tag.tag,
        color: isSelected ? Styles.white : null,
      ),
    );
  }
}
