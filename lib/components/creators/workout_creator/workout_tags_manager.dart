import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Allows the user to CRUD their set of [WorkoutTags]
/// Works via a [QueryObserver] and the [GraphQL store] directly to update state.
class WorkoutTagsManager extends StatefulWidget {
  /// When accessing this widget during the flow of adding tags to some other object we do not need the user to be able to update / delete all of their tags.
  /// However, if being accessed from their profile or similar (i.e. they want to really manage their tags rather than just add a new tag to something) then this can be set false to give full functionality.
  final bool allowCreateTagOnly;
  const WorkoutTagsManager({this.allowCreateTagOnly = true});

  @override
  WorkoutTagsManagerState createState() => WorkoutTagsManagerState();
}

class WorkoutTagsManagerState extends State<WorkoutTagsManager> {
  late TextEditingController _tagNameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tagNameController = TextEditingController();
    _tagNameController.addListener(() {
      setState(() {});
    });
  }

  bool get _canSaveNewTag => _tagNameController.text.length > 2;

  Future<void> _createNewTag() async {
    setState(() => _isLoading = true);

    final variables = CreateWorkoutTagArguments(
        data: CreateWorkoutTagInput(tag: _tagNameController.text));

    final result = await context.graphQLStore.create(
        mutation: CreateWorkoutTagMutation(variables: variables),
        addRefToQueries: [UserWorkoutTagsQuery().operationName]);

    setState(() => _isLoading = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'Sorry, there was a problem creating the tag',
          toastType: ToastType.destructive);
    } else {
      /// When creating only it makes sense to leave as soon as this is done.
      if (widget.allowCreateTagOnly) {
        context.pop();
      } else {
        context.showToast(
            message: 'New tag created!', toastType: ToastType.success);
        setState(() {
          _tagNameController.text = '';
        });
      }
    }
  }

  Future<void> _updateTag(WorkoutTag tag) async {
    setState(() => _isLoading = true);

    final variables = UpdateWorkoutTagArguments(
        data: UpdateWorkoutTagInput(id: tag.id, tag: tag.tag));

    final result = await context.graphQLStore
        .mutate<UpdateWorkoutTag$Mutation, UpdateWorkoutTagArguments>(
            mutation: UpdateWorkoutTagMutation(variables: variables),
            broadcastQueryIds: [
          UserWorkoutTagsQuery().operationName,
          GQLOpNames.workoutByIdQuery,
        ]);

    setState(() => _isLoading = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'Sorry, there was a problem updating the tag',
          toastType: ToastType.destructive);
    } else {
      context.showToast(message: 'Tag updated');
    }
  }

  void _handleTagDelete(WorkoutTag tag) {
    context.showConfirmDeleteDialog(
        itemType: 'Workout Tag',
        message:
            'This tag will be removed from anything it has been assigned to. OK?',
        onConfirm: () => _deleteWorkoutTag(tag));
  }

  void _deleteWorkoutTag(WorkoutTag tag) async {
    setState(() => _isLoading = true);

    final variables = DeleteWorkoutTagByIdArguments(id: tag.id);
    final result = await context.graphQLStore.delete(
        mutation: DeleteWorkoutTagByIdMutation(variables: variables),
        objectId: tag.id,
        typename: kWorkoutTagTypename,
        removeAllRefsToId: true,
        removeRefFromQueries: [
          UserWorkoutTagsQuery().operationName
        ],
        broadcastQueryIds: [
          UserWorkoutsQuery().operationName,
        ]);

    setState(() => _isLoading = false);
    if (result.hasErrors || result.data?.deleteWorkoutTagById != tag.id) {
      context.showToast(
          message: 'Sorry, there was a problem deleting the tag',
          toastType: ToastType.destructive);
    } else {
      context.showToast(
        message: 'Tag Deleted',
      );
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
      navigationBar: BorderlessNavBar(
        automaticallyImplyLeading: !_isLoading,
        middle: NavBarTitle(
            widget.allowCreateTagOnly ? 'Create Tag' : 'Manage Tags'),
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
      child: QueryObserver<UserWorkoutTags$Query, json.JsonSerializable>(
          key: Key(
              'WorkoutTagsManager - ${UserWorkoutTagsQuery().operationName}'),
          query: UserWorkoutTagsQuery(),
          builder: (data) {
            final tags = data.userWorkoutTags;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12),
                CupertinoFormSection.insetGrouped(children: [
                  MyTextFormFieldRow(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    placeholder: 'Enter new tag',
                    controller: _tagNameController,
                    validationMessage: 'Min 3, max 30 characters',
                    validator: () =>
                        _tagNameController.text.length > 2 &&
                        _tagNameController.text.length < 31,
                  ),
                ]),
                GrowInOut(
                  show: _canSaveNewTag,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BorderButton(
                            prefix: Icon(
                              CupertinoIcons.add,
                              size: 20,
                            ),
                            loading: _isLoading,
                            text: 'Create Tag',
                            onPressed: _createNewTag),
                      ],
                    ),
                  ),
                ),
                if (!widget.allowCreateTagOnly)
                  Expanded(
                    child: Column(
                      children: [
                        HorizontalLine(),
                        Expanded(
                          child: _CurrentTagsList(
                            handleTagDelete: _handleTagDelete,
                            tags: tags,
                            updateTag: _updateTag,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
    );
  }
}

class _CurrentTagsList extends StatelessWidget {
  final List<WorkoutTag> tags;
  final void Function(WorkoutTag tag) handleTagDelete;
  final void Function(WorkoutTag updatedTag) updateTag;
  _CurrentTagsList(
      {required this.tags,
      required this.handleTagDelete,
      required this.updateTag});
  @override
  Widget build(BuildContext context) {
    final sortedTags = tags.reversed.toList();
    return sortedTags.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              'No Tags yet. Create one above.',
              subtext: true,
            ),
          )
        : ImplicitlyAnimatedList<WorkoutTag>(
            shrinkWrap: true,
            items: sortedTags,
            itemBuilder: (context, animation, tag, index) {
              return SizeFadeTransition(
                sizeFraction: 0.7,
                curve: Curves.easeInOut,
                animation: animation,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  onPressed: () => context.push(
                                      child: FullScreenTextEditing(
                                          title: 'Update Tag',
                                          initialValue: tag.tag,
                                          onSave: (text) {
                                            tag.tag = text;
                                            updateTag(tag);
                                          },
                                          validationMessage:
                                              'Min 3, max 30 characters',
                                          inputValidation: (t) =>
                                              t.length > 2)),
                                  child: ContentBox(
                                      child: MyText(
                                    tag.tag,
                                    weight: FontWeight.bold,
                                  ))),
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
                ),
              );
            },
            areItemsTheSame: (a, b) => a == b);
  }
}
