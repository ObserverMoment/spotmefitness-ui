import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/collections/collection_manager.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/collection_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Didn't use [_FilterableCreatedWorkouts] even tho very similar because we need the cards in this list to have context menu functionality - multiple options when clicked.
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
    await context.push(
        child: CollectionSelector(selectCollection: (collection) async {
      // Remove from [widget.collection]
      await CollectionManager.removeWorkoutFromCollection(
          context, widget.collection, workout,
          showToast: false);
      // Add to selected collection.
      await CollectionManager.addWorkoutToCollection(
          context, collection, workout);
    }));
  }

  Future<void> _copyToAnotherCollection(Workout workout) async {
    /// Select collection to move to
    await context.push(
        child: CollectionSelector(selectCollection: (collection) async {
      await CollectionManager.addWorkoutToCollection(
          context, collection, workout);
    }));
  }

  void _confirmRemoveFromCollection(Workout workout) {
    CollectionManager.confirmRemoveObjectFromCollection<Workout>(
        context, widget.collection, workout);
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
            padding: const EdgeInsets.only(top: 4, bottom: 8),
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
        : ListView.builder(
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: WorkoutCard(workouts[i]),
                  ),
                  menuChild: WorkoutCard(
                    workouts[i],
                  ),
                ));
  }
}
