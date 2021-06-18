import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/collection_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';

class WorkoutFinderWorkoutCard extends StatelessWidget {
  final Workout workout;
  final void Function(Workout workout)? selectWorkout;
  const WorkoutFinderWorkoutCard(
      {Key? key, required this.workout, this.selectWorkout})
      : super(key: key);

  Future<void> _selectCollection(BuildContext context) async {
    /// First choose a collection
    await context.showBottomSheet(
        useRootNavigator: true,
        expand: true,
        child: CollectionSelector(
            selectCollection: (collection) =>
                _addWorkoutToCollection(context, collection, workout)));
  }

  Future<void> _addWorkoutToCollection(
      BuildContext context, Collection collection, Workout workout) async {
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
          'Sorry there was a problem, the workout was not saved.');
    } else {
      context.showToast(message: 'Saved to collection: ${collection.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ContextMenu(
        key: Key('WorkoutFinderWorkoutCard ${workout.id}'),
        child: WorkoutCard(workout),
        menuChild: WorkoutCard(
          workout,
          showEquipment: false,
          showMoves: false,
        ),
        actions: [
          if (selectWorkout != null)
            ContextMenuAction(
                text: 'Select',
                iconData: CupertinoIcons.add,
                onTap: () => selectWorkout!(workout)),
          ContextMenuAction(
              text: 'View',
              iconData: CupertinoIcons.eye,
              onTap: () =>
                  context.navigateTo(WorkoutDetailsRoute(id: workout.id))),
          ContextMenuAction(
              text: 'Save',
              iconData: CupertinoIcons.heart_fill,
              onTap: () => _selectCollection(context)),
        ],
      ),
    );
  }
}
