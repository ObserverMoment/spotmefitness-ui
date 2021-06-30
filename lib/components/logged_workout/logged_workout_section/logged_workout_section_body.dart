import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_graphics.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:provider/provider.dart';

class LoggedWorkoutSectionBody extends StatelessWidget {
  final int sectionIndex;
  LoggedWorkoutSectionBody(this.sectionIndex);

  @override
  Widget build(BuildContext context) {
    final section =
        context.select<LoggedWorkoutCreatorBloc, LoggedWorkoutSection>(
            (b) => b.loggedWorkout.loggedWorkoutSections[sectionIndex]);

    List<BodyArea> uniqueTargetBodyAreas =
        DataUtils.bodyAreasInLoggedWorkoutSection(section).toSet().toList();

    return QueryObserver<BodyAreas$Query, json.JsonSerializable>(
        key:
            Key('LoggedWorkoutSectionBody - ${BodyAreasQuery().operationName}'),
        query: BodyAreasQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TargetedBodyAreasSelectedIndicator(
                        allBodyAreas: data.bodyAreas,
                        frontBack: BodyAreaFrontBack.front,
                        selectedBodyAreas: uniqueTargetBodyAreas,
                      ),
                      TargetedBodyAreasSelectedIndicator(
                        allBodyAreas: data.bodyAreas,
                        frontBack: BodyAreaFrontBack.back,
                        selectedBodyAreas: uniqueTargetBodyAreas,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TargetedBodyAreasList(uniqueTargetBodyAreas),
                  )
                ],
              ),
            ),
          );
        });
  }
}
