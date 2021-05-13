import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_graphics.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class LoggedWorkoutSectionBody extends StatelessWidget {
  final List<BodyArea> uniqueBodyAreas;
  LoggedWorkoutSectionBody({required this.uniqueBodyAreas});

  @override
  Widget build(BuildContext context) {
    return QueryObserver<BodyAreas$Query, json.JsonSerializable>(
        key:
            Key('LoggedWorkoutSectionBody - ${BodyAreasQuery().operationName}'),
        query: BodyAreasQuery(),
        builder: (data) {
          return Padding(
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
                      selectedBodyAreas: uniqueBodyAreas,
                    ),
                    TargetedBodyAreasSelectedIndicator(
                      allBodyAreas: data.bodyAreas,
                      frontBack: BodyAreaFrontBack.back,
                      selectedBodyAreas: uniqueBodyAreas,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TargetedBodyAreasList(uniqueBodyAreas),
                )
              ],
            ),
          );
        });
  }
}
