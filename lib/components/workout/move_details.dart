import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_graphics.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Info about and exercise. Video and description.
class MoveDetails extends StatelessWidget {
  final Move move;
  MoveDetails(this.move);

  final double kBodyGraphicHeight = 380;

  Widget _buildEquipmentLists(Move move) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (move.requiredEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  H3('Required Equipment'),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    runAlignment: WrapAlignment.center,
                    children: move.requiredEquipments
                        .map(
                          (e) => SizedBox(
                            width: 88,
                            height: 88,
                            child: EquipmentTile(
                              equipment: e,
                              showIcon: true,
                              fontSize: FONTSIZE.SMALL,
                              withBorder: false,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          if (move.selectableEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  H3('Selectable Equipment'),
                  SizedBox(height: 10),
                  MyText(
                    'You can select one of these for completing the move. Generally, these will be different modes of load / resistance (free weights, bands, machines etc), or items needed for certain modifications.',
                    size: FONTSIZE.SMALL,
                    textAlign: TextAlign.center,
                    maxLines: 8,
                    lineHeight: 1.25,
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    runAlignment: WrapAlignment.center,
                    children: move.selectableEquipments
                        .map(
                          (e) => SizedBox(
                            width: 88,
                            height: 88,
                            child: EquipmentTile(
                              equipment: e,
                              showIcon: true,
                              fontSize: FONTSIZE.SMALL,
                              withBorder: false,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
        ],
      );

  @override
  Widget build(BuildContext context) {
    final bool _bodyWeightOnly =
        move.requiredEquipments.isEmpty && move.selectableEquipments.isEmpty;

    return QueryObserver<BodyAreas$Query, json.JsonSerializable>(
        key: Key('MoveDetails - ${BodyAreasQuery().operationName}'),
        query: BodyAreasQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        builder: (data) {
          return MyPageScaffold(
            navigationBar: MyNavBar(
              customLeading: NavBarChevronDownButton(context.pop),
              backgroundColor: context.theme.background,
              middle: NavBarTitle(move.name),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (move.demoVideoUri != null)
                    SizedBox(
                        height: 220,
                        child: InlineUploadcareVideoPlayer(
                            videoUri: move.demoVideoUri!)),
                  if (Utils.textNotNull(move.description))
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: MyText(
                          move.description!,
                          textAlign: TextAlign.center,
                          maxLines: 10,
                          lineHeight: 1.5,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: H3(
                            'Targeted Body Areas',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        TargetedBodyAreasScoreList(move.bodyAreaMoveScores),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Utils.notNullNotEmpty(move.bodyAreaMoveScores)
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TargetedBodyAreasScoreIndicator(
                                        bodyAreaMoveScores:
                                            move.bodyAreaMoveScores,
                                        frontBack: BodyAreaFrontBack.front,
                                        allBodyAreas: data.bodyAreas,
                                        height: kBodyGraphicHeight),
                                    TargetedBodyAreasScoreIndicator(
                                        bodyAreaMoveScores:
                                            move.bodyAreaMoveScores,
                                        frontBack: BodyAreaFrontBack.back,
                                        allBodyAreas: data.bodyAreas,
                                        height: kBodyGraphicHeight)
                                  ],
                                )
                              : MyText('Body areas not specified'),
                        ),
                      ],
                    ),
                  ),
                  HorizontalLine(),
                  _bodyWeightOnly
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            H3('Bodyweight Only'),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText('This move requires no equipment'),
                              ],
                            ),
                          ],
                        )
                      : _buildEquipmentLists(move),
                  HorizontalLine(),
                ],
              ),
            ),
          );
        });
  }
}
