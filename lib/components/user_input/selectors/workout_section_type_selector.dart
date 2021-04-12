import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

/// The user is required to select a type before moving on to the workout section creator.
/// As the type selected detemines exactly how the UI is displayed and which defaults are used.
/// Unlike some other selectors this runs callback immediately on press and does not have any state.
class WorkoutSectionTypeSelector extends StatelessWidget {
  final void Function(WorkoutSectionType type) selectWorkoutSectionType;
  WorkoutSectionTypeSelector(this.selectWorkoutSectionType);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Query(
          options: QueryOptions(
              document: WorkoutSectionTypesQuery().document,
              fetchPolicy: FetchPolicy.cacheFirst),
          builder: (result, {refetch, fetchMore}) => QueryResponseBuilder(
              result: result,
              builder: () {
                final _workoutSectionTypes =
                    WorkoutSectionTypes$Query.fromJson(result.data ?? {})
                        .workoutSectionTypes;

                return ListView(
                  shrinkWrap: true,
                  children: _workoutSectionTypes
                      .sortedBy<num>((type) => int.parse(type.id))
                      .map((type) => GestureDetector(
                            onTap: () => selectWorkoutSectionType(type),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Styles.lightGrey))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(type.name),
                                  InfoPopupButton(
                                      pageTitle: '${type.name}',
                                      infoWidget: Column(
                                        children: [
                                          MyText(
                                            '${type.description}',
                                            maxLines: 20,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              })),
    );
  }
}
