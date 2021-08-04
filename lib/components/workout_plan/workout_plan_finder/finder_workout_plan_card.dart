import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/collection_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';

class WorkoutFinderWorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const WorkoutFinderWorkoutPlanCard({Key? key, required this.workoutPlan})
      : super(key: key);

  Future<void> _selectCollection(BuildContext context) async {
    /// First choose a collection
    await context.showBottomSheet(
        useRootNavigator: true,
        expand: true,
        child: CollectionSelector(
            selectCollection: (collection) =>
                _addWorkoutPlanToCollection(context, collection, workoutPlan)));
  }

  Future<void> _addWorkoutPlanToCollection(BuildContext context,
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
          .showErrorAlert('Sorry there was a problem, the plan was not saved.');
    } else {
      context.showToast(message: 'Saved to collection: ${collection.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: ContextMenu(
        key: Key('WorkoutFinderWorkoutPlanCard ${workoutPlan.id}'),
        child: WorkoutPlanCard(workoutPlan),
        menuChild: WorkoutPlanCard(
          workoutPlan,
        ),
        actions: [
          ContextMenuAction(
              text: 'View',
              iconData: CupertinoIcons.eye,
              onTap: () => context
                  .navigateTo(WorkoutPlanDetailsRoute(id: workoutPlan.id))),
          ContextMenuAction(
              text: 'Save',
              iconData: CupertinoIcons.heart_fill,
              onTap: () => _selectCollection(context)),
        ],
      ),
    );
  }
}
