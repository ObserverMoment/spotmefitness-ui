import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/collection_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';

/// Didn't use [_FilterableCreatedWorkoutPlans] even tho very similar because we need the cards in this list to have context menu functionality - multiple options when clicked.
/// Note: Also has similar functionality to that found in the [WorkoutPlanDetailsPage] with regards to adding and removing from collections.
class FilterableCollectionWorkoutPlans extends StatefulWidget {
  final Collection collection;
  const FilterableCollectionWorkoutPlans({Key? key, required this.collection})
      : super(key: key);

  @override
  _FilterableCollectionWorkoutPlansState createState() =>
      _FilterableCollectionWorkoutPlansState();
}

class _FilterableCollectionWorkoutPlansState
    extends State<FilterableCollectionWorkoutPlans> {
  WorkoutTag? _workoutTagFilter;

  Future<void> _moveToAnotherCollection(WorkoutPlan workoutPlan) async {
    /// Select collection to move to
    await context.showBottomSheet(
        child: CollectionSelector(selectCollection: (collection) async {
      await _removeWorkoutPlanFromCollection(workoutPlan, showToast: false);
      await _addWorkoutPlanToCollection(collection, workoutPlan);
    }));
  }

  Future<void> _copyToAnotherCollection(WorkoutPlan workoutPlan) async {
    /// Select collection to move to
    await context.showBottomSheet(
        child: CollectionSelector(selectCollection: (collection) async {
      await _addWorkoutPlanToCollection(collection, workoutPlan);
    }));
  }

  /// Collection selected via [CollectionSelector]
  Future<void> _addWorkoutPlanToCollection(
      Collection collection, WorkoutPlan workoutPlan) async {
    final updatedCollection = Collection.fromJson(collection.toJson());
    updatedCollection.workoutPlans.add(workoutPlan);

    final variables = AddWorkoutPlanToCollectionArguments(
        data: AddWorkoutPlanToCollectionInput(
            collectionId: collection.id,
            workoutPlan: ConnectRelationInput(id: workoutPlan.id)));

    final result = await context.graphQLStore.mutate<
            AddWorkoutPlanToCollection$Mutation,
            AddWorkoutPlanToCollectionArguments>(
        mutation: AddWorkoutPlanToCollectionMutation(variables: variables),
        optimisticData: updatedCollection.toJson(),
        broadcastQueryIds: [
          UserCollectionsQuery().operationName,
          GQLVarParamKeys.userCollectionByIdQuery(collection.id)
        ]);

    if (result.hasErrors || result.data == null) {
      context
          .showErrorAlert('Sorry there was a problem, the plan was not moved.');
    } else {
      context.showToast(
          message: 'Added ${workoutPlan.name} to ${collection.name}');
    }
  }

  void _confirmRemoveFromCollection(WorkoutPlan workoutPlan) {
    context.showConfirmDialog(
        title: 'Remove from Collection',
        content: MyText(
          'Remove ${workoutPlan.name}?',
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        onConfirm: () => _removeWorkoutPlanFromCollection(workoutPlan));
  }

  Future<void> _removeWorkoutPlanFromCollection(WorkoutPlan workoutPlan,
      {bool showToast = true}) async {
    final updatedCollection = Collection.fromJson(widget.collection.toJson());
    updatedCollection.workoutPlans = widget.collection.workoutPlans
        .where((w) => w.id != workoutPlan.id)
        .toList();

    final variables = RemoveWorkoutPlanFromCollectionArguments(
        data: RemoveWorkoutPlanFromCollectionInput(
            collectionId: widget.collection.id,
            workoutPlan: ConnectRelationInput(id: workoutPlan.id)));

    final result = await context.graphQLStore.mutate<
            RemoveWorkoutPlanFromCollection$Mutation,
            RemoveWorkoutPlanFromCollectionArguments>(
        mutation: RemoveWorkoutPlanFromCollectionMutation(variables: variables),
        optimisticData: updatedCollection.toJson(),
        broadcastQueryIds: [
          UserCollectionsQuery().operationName,
          GQLVarParamKeys.userCollectionByIdQuery(widget.collection.id)
        ]);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the plan was not removed.');
    } else {
      if (showToast) {
        context.showToast(message: 'Removed ${workoutPlan.name}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final allPlans = widget.collection.workoutPlans;
    final allTags = allPlans
        .fold<List<WorkoutTag>>(
            [], (acum, next) => [...acum, ...next.workoutTags])
        .toSet()
        .toList();

    final filteredPlans = _workoutTagFilter == null
        ? allPlans
        : allPlans.where((wp) => wp.workoutTags.contains(_workoutTagFilter));

    final sortedPlans =
        filteredPlans.sortedBy<DateTime>((w) => w.createdAt).reversed.toList();

    return Column(
      children: [
        if (allTags.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, top: 4, bottom: 10, right: 4),
            child: SizedBox(
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allTags.length,
                    itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SelectableTag(
                            text: allTags[i].tag,
                            selectedColor: Styles.infoBlue,
                            isSelected: allTags[i] == _workoutTagFilter,
                            onPressed: () => setState(() => _workoutTagFilter =
                                allTags[i] == _workoutTagFilter
                                    ? null
                                    : allTags[i]),
                          ),
                        ))),
          ),
        Expanded(
            child: _CollectionWorkoutPlansList(
          workoutPlans: sortedPlans,
          moveToCollection: _moveToAnotherCollection,
          copyToCollection: _copyToAnotherCollection,
          removeFromCollection: _confirmRemoveFromCollection,
        )),
      ],
    );
  }
}

class _CollectionWorkoutPlansList extends StatelessWidget {
  final List<WorkoutPlan> workoutPlans;
  final void Function(WorkoutPlan workoutPlan) moveToCollection;
  final void Function(WorkoutPlan workoutPlan) copyToCollection;
  final void Function(WorkoutPlan workoutPlan) removeFromCollection;
  const _CollectionWorkoutPlansList(
      {required this.workoutPlans,
      required this.moveToCollection,
      required this.copyToCollection,
      required this.removeFromCollection});

  @override
  Widget build(BuildContext context) {
    return workoutPlans.isEmpty
        ? Padding(padding: const EdgeInsets.all(24), child: MyText('No plans'))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: workoutPlans.length,
                itemBuilder: (c, i) => ContextMenu(
                      key: Key(workoutPlans[i].id),
                      actions: [
                        ContextMenuAction(
                            text: 'View details',
                            iconData: CupertinoIcons.eye,
                            onTap: () => context.navigateTo(
                                WorkoutPlanDetailsRoute(
                                    id: workoutPlans[i].id))),
                        ContextMenuAction(
                            text: 'Move to collection',
                            iconData: CupertinoIcons.tray_arrow_up,
                            onTap: () => moveToCollection(workoutPlans[i])),
                        ContextMenuAction(
                            text: 'Copy to collection',
                            iconData: CupertinoIcons.doc_on_doc,
                            onTap: () => copyToCollection(workoutPlans[i])),
                        ContextMenuAction(
                            text: 'Remove',
                            iconData: CupertinoIcons.delete_simple,
                            destructive: true,
                            onTap: () => removeFromCollection(workoutPlans[i]))
                      ],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10.0),
                        child: WorkoutPlanCard(workoutPlans[i]),
                      ),
                      menuChild: WorkoutPlanCard(
                        workoutPlans[i],
                      ),
                    )),
          );
  }
}
