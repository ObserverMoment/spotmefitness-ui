import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
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

/// Didn't use [_FilterableCreatedWorkouts] even tho very similar because we need the cards in this list to have context menu functionality - multiple options when clicked.
/// Note: Also has similar functionality to that found in the [WorkoutDetailsPage] with regards to adding and removing from collections.
class FilterableCollectionWorkouts extends StatefulWidget {
  final Collection collection;
  const FilterableCollectionWorkouts({Key? key, required this.collection})
      : super(key: key);

  @override
  _FilterableCollectionWorkoutsState createState() =>
      _FilterableCollectionWorkoutsState();
}

class _FilterableCollectionWorkoutsState
    extends State<FilterableCollectionWorkouts> {
  WorkoutTag? _workoutTagFilter;

  Future<void> _moveToAnotherCollection(Workout workout) async {
    /// Select collection to move to
    await context.showBottomSheet(
        expand: true,
        child: CollectionSelector(selectCollection: (collection) async {
          await _removeWorkoutFromCollection(workout, showToast: false);
          await _addWorkoutToCollection(collection, workout);
        }));
  }

  Future<void> _copyToAnotherCollection(Workout workout) async {
    /// Select collection to move to
    await context.showBottomSheet(
        expand: true,
        child: CollectionSelector(selectCollection: (collection) async {
          await _addWorkoutToCollection(collection, workout);
        }));
  }

  /// Collection selected via [CollectionSelector]
  Future<void> _addWorkoutToCollection(
      Collection collection, Workout workout) async {
    final updatedCollection = Collection.fromJson(collection.toJson());
    updatedCollection.workouts.add(workout);

    final variables = AddWorkoutToCollectionArguments(
        data: AddWorkoutToCollectionInput(
            collectionId: collection.id,
            workout: ConnectRelationInput(id: workout.id)));

    final result = await context.graphQLStore.mutate<
            AddWorkoutToCollection$Mutation, AddWorkoutToCollectionArguments>(
        mutation: AddWorkoutToCollectionMutation(variables: variables),
        optimisticData: updatedCollection.toJson(),
        broadcastQueryIds: [
          UserCollectionsQuery().operationName,
          GQLVarParamKeys.userCollectionByIdQuery(collection.id)
        ]);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the workout was not moved.');
    } else {
      context.showToast(message: 'Added ${workout.name} to ${collection.name}');
    }
  }

  void _confirmRemoveFromCollection(Workout workout) {
    context.showConfirmDialog(
        title: 'Remove from Collection',
        content: MyText(
          'Remove ${workout.name}?',
          textAlign: TextAlign.center,
          maxLines: 4,
        ),
        onConfirm: () => _removeWorkoutFromCollection(workout));
  }

  Future<void> _removeWorkoutFromCollection(Workout workout,
      {bool showToast = true}) async {
    final updatedCollection = Collection.fromJson(widget.collection.toJson());
    updatedCollection.workouts =
        widget.collection.workouts.where((w) => w.id != workout.id).toList();

    final variables = RemoveWorkoutFromCollectionArguments(
        data: RemoveWorkoutFromCollectionInput(
            collectionId: widget.collection.id,
            workout: ConnectRelationInput(id: workout.id)));

    final result = await context.graphQLStore.mutate<
            RemoveWorkoutFromCollection$Mutation,
            RemoveWorkoutFromCollectionArguments>(
        mutation: RemoveWorkoutFromCollectionMutation(variables: variables),
        optimisticData: updatedCollection.toJson(),
        broadcastQueryIds: [
          UserCollectionsQuery().operationName,
          GQLVarParamKeys.userCollectionByIdQuery(widget.collection.id)
        ]);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the workout was not removed.');
    } else {
      if (showToast) {
        context.showToast(message: 'Removed ${workout.name}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final allWorkouts = widget.collection.workouts;
    final allTags = allWorkouts
        .fold<List<WorkoutTag>>(
            [], (acum, next) => [...acum, ...next.workoutTags])
        .toSet()
        .toList();

    final filteredWorkouts = _workoutTagFilter == null
        ? allWorkouts
        : allWorkouts.where((w) => w.workoutTags.contains(_workoutTagFilter));

    final sortedWorkouts = filteredWorkouts
        .sortedBy<DateTime>((w) => w.createdAt)
        .reversed
        .toList();

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
            child: _CollectionWorkoutsList(
          workouts: sortedWorkouts,
          moveToCollection: _moveToAnotherCollection,
          copyToCollection: _copyToAnotherCollection,
          removeFromCollection: _confirmRemoveFromCollection,
        )),
      ],
    );
  }
}

class _CollectionWorkoutsList extends StatelessWidget {
  final List<Workout> workouts;
  final void Function(Workout workout) moveToCollection;
  final void Function(Workout workout) copyToCollection;
  final void Function(Workout workout) removeFromCollection;
  const _CollectionWorkoutsList(
      {required this.workouts,
      required this.moveToCollection,
      required this.copyToCollection,
      required this.removeFromCollection});

  @override
  Widget build(BuildContext context) {
    return workouts.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(24), child: MyText('No workouts'))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: workouts.length,
                itemBuilder: (c, i) => ContextMenu(
                      key: Key(workouts[i].id),
                      actions: [
                        ContextMenuAction(
                            text: 'View details',
                            iconData: CupertinoIcons.eye,
                            onTap: () => context.navigateTo(
                                WorkoutDetailsRoute(id: workouts[i].id))),
                        ContextMenuAction(
                            text: 'Move to collection',
                            iconData: CupertinoIcons.tray_arrow_up,
                            onTap: () => moveToCollection(workouts[i])),
                        ContextMenuAction(
                            text: 'Copy to collection',
                            iconData: CupertinoIcons.doc_on_doc,
                            onTap: () => copyToCollection(workouts[i])),
                        ContextMenuAction(
                            text: 'Remove',
                            iconData: CupertinoIcons.delete_simple,
                            destructive: true,
                            onTap: () => removeFromCollection(workouts[i]))
                      ],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10.0),
                        child: WorkoutCard(workouts[i]),
                      ),
                      menuChild: WorkoutCard(
                        workouts[i],
                      ),
                    )),
          );
  }
}
