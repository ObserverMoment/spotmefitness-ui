import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/workout_plan_card.dart';
import 'package:sofie_ui/components/collections/collection_manager.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/menus/context_menu.dart';
import 'package:sofie_ui/components/user_input/selectors/collection_selector.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';

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
    await context.push(
        child: CollectionSelector(selectCollection: (collection) async {
      // Remove from [widget.collection]
      await CollectionManager.removeWorkoutPlanFromCollection(
          context, widget.collection, workoutPlan,
          showToast: false);
      // Add to selected collection.
      await CollectionManager.addWorkoutPlanToCollection(
          context, collection, workoutPlan);
    }));
  }

  Future<void> _copyToAnotherCollection(WorkoutPlan workoutPlan) async {
    /// Select collection to move to
    await context.push(
        child: CollectionSelector(selectCollection: (collection) async {
      await CollectionManager.addWorkoutPlanToCollection(
          context, collection, workoutPlan);
    }));
  }

  void _confirmRemoveFromCollection(WorkoutPlan workoutPlan) {
    CollectionManager.confirmRemoveObjectFromCollection<WorkoutPlan>(
        context, widget.collection, workoutPlan);
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
        ? const Padding(padding: EdgeInsets.all(24), child: MyText('No plans'))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: workoutPlans.length,
            itemBuilder: (c, i) => ContextMenu(
                  key: Key(workoutPlans[i].id),
                  actions: [
                    ContextMenuAction(
                        text: 'View details',
                        iconData: CupertinoIcons.eye,
                        onTap: () => context.navigateTo(
                            WorkoutPlanDetailsRoute(id: workoutPlans[i].id))),
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
                  menuChild: WorkoutPlanCard(
                    workoutPlans[i],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: WorkoutPlanCard(workoutPlans[i]),
                  ),
                ));
  }
}
