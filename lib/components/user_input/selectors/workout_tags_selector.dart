import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/tag_managers/workout_tags_manager.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Also lets you create a new tag and then select it via [WorkoutTagsManager].
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
        child: WorkoutTagsManager(
      allowCreateTagOnly: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BorderlessNavBar(
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
              final workoutTags = data.userWorkoutTags.reversed.toList();
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        workoutTags.isEmpty
                            ? MyText('No tags created yet...')
                            : MyText(
                                'Click to select / deselect.',
                                size: FONTSIZE.SMALL,
                              ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: workoutTags
                              .map((tag) => GestureDetector(
                                    onTap: () => _updateSelected(tag),
                                    child: FadeIn(
                                      child: _SelectableWorkoutTag(
                                        tag: tag,
                                        isSelected: _activeSelectedWorkoutTags
                                            .contains(tag),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 8),
                        CreateTextIconButton(
                            text: 'New Tag', onPressed: _openCreateNewTag),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class _SelectableWorkoutTag extends StatelessWidget {
  final WorkoutTag tag;
  final bool isSelected;
  _SelectableWorkoutTag({required this.tag, this.isSelected = false});
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
