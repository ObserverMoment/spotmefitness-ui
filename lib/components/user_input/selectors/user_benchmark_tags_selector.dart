import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/user_input/tag_managers/user_benchmark_tags_manager.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Also lets you create a new tag and then select it via tag manager.
class UserBenchmarkTagsSelector extends StatefulWidget {
  final List<UserBenchmarkTag> selectedUserBenchmarkTags;
  final void Function(List<UserBenchmarkTag> updated)
      updateSelectedUserBenchmarkTags;
  UserBenchmarkTagsSelector(
      {required this.selectedUserBenchmarkTags,
      required this.updateSelectedUserBenchmarkTags});

  @override
  _UserBenchmarkTagsSelectorState createState() =>
      _UserBenchmarkTagsSelectorState();
}

class _UserBenchmarkTagsSelectorState extends State<UserBenchmarkTagsSelector> {
  List<UserBenchmarkTag> _activeSelectedUserBenchmarkTags = [];

  @override
  void initState() {
    super.initState();
    _activeSelectedUserBenchmarkTags = [...widget.selectedUserBenchmarkTags];
  }

  void _updateSelected(UserBenchmarkTag tapped) {
    setState(() {
      _activeSelectedUserBenchmarkTags =
          _activeSelectedUserBenchmarkTags.toggleItem<UserBenchmarkTag>(tapped);
    });
    widget.updateSelectedUserBenchmarkTags(_activeSelectedUserBenchmarkTags);
  }

  void _openCreateNewTag() {
    context.push(
        child: UserBenchmarkTagsManager(
      allowCreateTagOnly: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BorderlessNavBar(
          customLeading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: MyText(
                'Done',
                weight: FontWeight.bold,
              ),
              onPressed: () => Navigator.pop(context)),
          middle: NavBarTitle('Personal Best Tags'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InfoPopupButton(
                infoWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    'Info about PB tags.',
                    maxLines: 10,
                  ),
                ),
              )
            ],
          ),
        ),
        child: QueryObserver<UserBenchmarkTags$Query, json.JsonSerializable>(
            key: Key(
                'UserBenchmarkTagsSelector - ${UserBenchmarkTagsQuery().operationName}'),
            query: UserBenchmarkTagsQuery(),
            fetchPolicy: QueryFetchPolicy.storeFirst,
            builder: (data) {
              final userBenchmarkTags =
                  data.userBenchmarkTags.reversed.toList();
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        userBenchmarkTags.isEmpty
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
                          children: userBenchmarkTags
                              .map((tag) => GestureDetector(
                                    onTap: () => _updateSelected(tag),
                                    child: FadeIn(
                                      child: _SelectableUserBenchmarkTag(
                                        tag: tag,
                                        isSelected:
                                            _activeSelectedUserBenchmarkTags
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

class _SelectableUserBenchmarkTag extends StatelessWidget {
  final UserBenchmarkTag tag;
  final bool isSelected;
  _SelectableUserBenchmarkTag({required this.tag, this.isSelected = false});
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
        tag.name,
        color: isSelected ? Styles.white : null,
      ),
    );
  }
}
