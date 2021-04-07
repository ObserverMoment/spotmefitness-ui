import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_graphic.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_score_list.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';

/// Graphical UI that highlights the areas of the body that are being targeted and by how much.
/// Brighter coloured areas indicate a higher score (percentage of total body area move score)
/// List of body area move scores will be grouped by body areas and then reduced into BodyAreaScores by body area and then averaged.
/// Front and back on on separate pages, accessible via swipe.
class TargetedBodyAreasPageView extends StatelessWidget {
  final List<BodyAreaMoveScore> bodyAreaMoveScores;
  TargetedBodyAreasPageView(
    this.bodyAreaMoveScores,
  );

  @override
  Widget build(BuildContext context) {
    final Color activeColor = context.theme.primary;

    /// The percentages are not being used here but the grouping is...
    final percentagedBodyAreaMoveScores =
        DataUtils.percentageBodyAreaMoveScores(bodyAreaMoveScores);

    return Query(
        options: QueryOptions(
            document: BodyAreasQuery().document,
            fetchPolicy: FetchPolicy.cacheFirst),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final List<BodyArea> bodyAreas =
                  BodyAreas$Query.fromJson(result.data ?? {}).bodyAreas;

              List<BodyArea> frontBodyAreas = bodyAreas
                  .where((ba) =>
                      ba.frontBack == BodyAreaFrontBack.front ||
                      ba.frontBack == BodyAreaFrontBack.both)
                  .toList();

              List<BodyArea> backBodyAreas = bodyAreas
                  .where((ba) =>
                      ba.frontBack == BodyAreaFrontBack.back ||
                      ba.frontBack == BodyAreaFrontBack.both)
                  .toList();

              return LayoutBuilder(builder: (context, constraints) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: bodyAreaMoveScores.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: MyText(
                                'Full Body Exercise',
                                weight: FontWeight.bold,
                                size: FONTSIZE.BIG,
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/body_areas/full_front.svg',
                                      height: constraints.maxHeight * 0.4,
                                      color: activeColor.withOpacity(0.7)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/body_areas/full_back.svg',
                                      height: constraints.maxHeight * 0.4,
                                      color: activeColor.withOpacity(0.7)),
                                ),
                              ],
                            )
                          ],
                        )
                      : PageView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        H3('Front'),
                                        Column(
                                          children: [
                                            MyText(
                                              'Back >',
                                              weight: FontWeight.bold,
                                            ),
                                            MyText(
                                              '(swipe)',
                                              size: FONTSIZE.SMALL,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12.0),
                                    child: TargetedBodyAreasScoreList(
                                        percentagedBodyAreaMoveScores
                                            .where((bams) =>
                                                bams.bodyArea.frontBack ==
                                                    BodyAreaFrontBack.front ||
                                                bams.bodyArea.frontBack ==
                                                    BodyAreaFrontBack.both)
                                            .toList()),
                                  ),
                                  TargetedBodyAreasGraphic(
                                    front: true,
                                    allBodyAreas: frontBodyAreas,
                                    activeColor: activeColor,
                                    bodyAreaMoveScores:
                                        percentagedBodyAreaMoveScores,
                                    height: constraints.maxHeight * 0.7,
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            MyText(
                                              '< Front',
                                              weight: FontWeight.bold,
                                            ),
                                            MyText(
                                              '(swipe)',
                                              size: FONTSIZE.SMALL,
                                            ),
                                          ],
                                        ),
                                        H3(
                                          'Back',
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12.0),
                                    child: TargetedBodyAreasScoreList(
                                        percentagedBodyAreaMoveScores
                                            .where((bams) =>
                                                bams.bodyArea.frontBack ==
                                                    BodyAreaFrontBack.back ||
                                                bams.bodyArea.frontBack ==
                                                    BodyAreaFrontBack.both)
                                            .toList()),
                                  ),
                                  TargetedBodyAreasGraphic(
                                    front: false,
                                    allBodyAreas: backBodyAreas,
                                    activeColor: activeColor,
                                    bodyAreaMoveScores:
                                        percentagedBodyAreaMoveScores,
                                    height: constraints.maxHeight * 0.7,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                );
              });
            }));
  }
}
