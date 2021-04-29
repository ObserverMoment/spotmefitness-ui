import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_graphics.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_lists.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';

/// Graphical UI that highlights the areas of the body that are being targeted.
/// List of body area move scores will be folded to a list of bodyareas and then displayed.
/// Front and back on on separate pages, accessible via swipe.
class TargetedBodyAreasPageView extends StatelessWidget {
  final List<BodyAreaMoveScore> bodyAreaMoveScores;
  TargetedBodyAreasPageView(
    this.bodyAreaMoveScores,
  );

  @override
  Widget build(BuildContext context) {
    final Color activeColor = context.theme.primary;

    final Set<BodyArea> bodyAreasThatHaveScore =
        bodyAreaMoveScores.map((bams) => bams.bodyArea).toSet();

    /// The percentages are not being used here but the grouping is...
    final percentagedBodyAreaMoveScores =
        DataUtils.percentageBodyAreaMoveScores(bodyAreaMoveScores);

    return QueryResponseBuilder(
        options: QueryOptions(
            document: BodyAreasQuery().document,
            fetchPolicy: FetchPolicy.cacheFirst),
        builder: (result, {fetchMore, refetch}) {
          final List<BodyArea> allBodyAreas =
              BodyAreas$Query.fromJson(result.data ?? {}).bodyAreas;

          return LayoutBuilder(builder: (context, constraints) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: bodyAreaMoveScores.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            H2(
                              'Front',
                            ),
                            Positioned(
                              right: 12,
                              child: Column(
                                children: [
                                  MyText(
                                    'Back >',
                                  ),
                                  Icon(Icons.swipe),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
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
                                    TargetedBodyAreasSelectedIndicator(
                                      frontBack: BodyAreaFrontBack.front,
                                      allBodyAreas: allBodyAreas,
                                      activeColor: activeColor,
                                      selectedBodyAreas:
                                          bodyAreasThatHaveScore.toList(),
                                      height: constraints.maxHeight * 0.7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            H2(
                              'Back',
                            ),
                            Positioned(
                              left: 12,
                              child: Column(
                                children: [
                                  MyText(
                                    '< Front',
                                  ),
                                  Icon(Icons.swipe),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
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
                                    TargetedBodyAreasSelectedIndicator(
                                      frontBack: BodyAreaFrontBack.back,
                                      allBodyAreas: allBodyAreas,
                                      activeColor: activeColor,
                                      selectedBodyAreas:
                                          bodyAreasThatHaveScore.toList(),
                                      height: constraints.maxHeight * 0.7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            );
          });
        });
  }
}
