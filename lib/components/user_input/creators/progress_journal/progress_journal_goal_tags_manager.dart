import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/color_picker.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// Allows the user to CRUD their set of [ProgressJournalGoalTags]
/// Works via a [QueryObserver] and the [GraphQL store] directly to update state.
class ProgressJournalGoalTagsManager extends StatefulWidget {
  ProgressJournalGoalTagsManager();

  @override
  _ProgressJournalGoalTagsManagerState createState() =>
      _ProgressJournalGoalTagsManagerState();
}

class _ProgressJournalGoalTagsManagerState
    extends State<ProgressJournalGoalTagsManager> {
  late TextEditingController _tagNameController;
  Color? _newTagColor;
  bool _isLoading = false;

  final double kNewTagInputHeight = 240;

  @override
  void initState() {
    super.initState();
    _tagNameController = TextEditingController();
    _tagNameController.addListener(() {
      setState(() {});
    });
  }

  void _updateNewTagColor(Color newColor) {
    setState(() => _newTagColor = newColor);
  }

  void _handleTagDelete(ProgressJournalGoalTag tag) {
    context.showConfirmDeleteDialog(
        itemType: 'Goal Tag',
        message: 'This cannot be undone and may affect your journal goals.',
        onConfirm: () => _deleteGoalTag(tag));
  }

  void _deleteGoalTag(ProgressJournalGoalTag tag) async {
    setState(() => _isLoading = true);

    final variables = DeleteProgressJournalGoalTagByIdArguments(id: tag.id);
    final result = await context.graphQLStore.delete(
        mutation:
            DeleteProgressJournalGoalTagByIdMutation(variables: variables),
        objectId: tag.id,
        typename: kProgressJournalGoalTagTypename,
        removeAllRefsToId: true,
        removeRefFromQueries: [
          ProgressJournalGoalTagsQuery().operationName
        ],
        broadcastQueryIds: [
          UserProgressJournalsQuery().operationName,
          // Using the raw string as there is no easy way to get the journal id required for the usual ProgressJournalByIdQuery(variables: ProgressJournalByIdArguments(id: id)) syntax.
          // May need a re-think on this pattern.
          kProgressJournalByIdQuery
        ]);

    setState(() => _isLoading = false);
    if (result.hasErrors ||
        result.data?.deleteProgressJournalGoalTagById != tag.id) {
      context.showToast(
          message: 'Sorry, there was a problem deleting the tag',
          toastType: ToastType.destructive);
    } else {
      context.showToast(
        message: 'Tag Deleted',
      );
    }
  }

  bool get _canSaveNewTag =>
      _tagNameController.text.length > 2 && _newTagColor != null;

  Future<void> _createNewTag() async {
    setState(() => _isLoading = true);

    final variables = CreateProgressJournalGoalTagArguments(
        data: CreateProgressJournalGoalTagInput(
            tag: _tagNameController.text, hexColor: _newTagColor!.toHex()));

    final result = await context.graphQLStore.create(
        mutation: CreateProgressJournalGoalTagMutation(variables: variables),
        addRefToQueries: [ProgressJournalGoalTagsQuery().operationName]);

    setState(() => _isLoading = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'Sorry, there was a problem creating the tag',
          toastType: ToastType.destructive);
    } else {
      context.showToast(
          message: 'New tag created!', toastType: ToastType.success);
      setState(() {
        _tagNameController.text = '';
        _newTagColor = null;
      });
    }
  }

  @override
  void dispose() {
    _tagNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        automaticallyImplyLeading: !_isLoading,
        middle: NavBarTitle('Goal Tags'),
        trailing: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadingDots(
                    size: 14,
                  )
                ],
              )
            : null,
      ),
      child: QueryObserver<ProgressJournalGoalTags$Query,
              json.JsonSerializable>(
          key: Key(
              'ProgressJournalGoalCreator - ${ProgressJournalGoalTagsQuery().operationName}'),
          query: ProgressJournalGoalTagsQuery(),
          builder: (data) {
            final tags = data.progressJournalGoalTags;
            return SingleChildScrollView(
              child: Column(
                children: [
                  MyText('New Tag'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: MyTextFormFieldRow(
                      keyboardType: TextInputType.text,
                      placeholder: 'Tag name',
                      controller: _tagNameController,
                      validationMessage: 'Min 3, max 30 characters',
                      validator: () => _tagNameController.text.length > 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BorderButton(
                          prefix: _newTagColor != null
                              ? Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CircularBox(
                                      color: _newTagColor,
                                      child: SizedBox(height: 9, width: 9)),
                                )
                              : null,
                          text: _newTagColor != null
                              ? 'Change Color'
                              : 'Select Color',
                          disabled: _tagNameController.text.length < 3,
                          onPressed: () async {
                            Utils.hideKeyboard(context);
                            await openColorPickerDialog(
                                context: context,
                                onSave: (color) => _updateNewTagColor(color));
                          },
                          loading: _isLoading,
                        ),
                        BorderButton(
                            prefix: Icon(
                              CupertinoIcons.add,
                              size: 20,
                            ),
                            loading: _isLoading,
                            disabled: !_canSaveNewTag,
                            text: 'Create Tag',
                            onPressed: _createNewTag)
                      ],
                    ),
                  ),
                  HorizontalLine(),
                  SizedBox(height: 12),
                  MyText(
                    'Current Tags',
                    weight: FontWeight.bold,
                  ),
                  CurrentTagsList(
                    handleTagDelete: _handleTagDelete,
                    tags: tags,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CurrentTagsList extends StatelessWidget {
  final List<ProgressJournalGoalTag> tags;
  final void Function(ProgressJournalGoalTag tag) handleTagDelete;
  CurrentTagsList({required this.tags, required this.handleTagDelete});
  @override
  Widget build(BuildContext context) {
    return tags.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              'No Tags yet. Create one above.',
              subtext: true,
            ),
          )
        : ImplicitlyAnimatedList<ProgressJournalGoalTag>(
            shrinkWrap: true,
            items: tags,
            itemBuilder: (context, animation, tag, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                onPressed: () => print('open tag text edit'),
                                child: ContentBox(
                                    child: MyText(
                                  tag.tag,
                                  weight: FontWeight.bold,
                                ))),
                            CupertinoButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              onPressed: () => print('open tag color edit'),
                              child: CircularBox(
                                  child: SizedBox(width: 28, height: 28),
                                  color: HexColor.fromHex(tag.hexColor)),
                            ),
                          ],
                        ),
                        TextButton(
                          text: 'Delete',
                          onPressed: () => handleTagDelete(tag),
                          destructive: true,
                          underline: false,
                        )
                      ],
                    ),
                  ),
                  HorizontalLine()
                ],
              );
            },
            areItemsTheSame: (a, b) => a == b);
  }
}
