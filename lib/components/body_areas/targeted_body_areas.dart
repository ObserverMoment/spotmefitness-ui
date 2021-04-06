import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:supercharged/supercharged.dart';

/// Graphical UI that highlights the areas of the body that are being targeted and by how much.
/// Brighter coloured areas indicate a higher score (percentage of total body area move score)
/// List of body area move scores will be grouped by body areas and then reduced into BodyAreaScores by body area and then averaged.
class TargetedBodyAreas extends StatelessWidget {
  final List<BodyAreaMoveScore> bodyAreaScores;
  TargetedBodyAreas({required this.bodyAreaScores});

  // Opacity of background and untargeted areas.
  final double _basisOpacity = 0.3;
  final Color _activeColor = Styles.neonBlueOne;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: BodyAreasQuery().document),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final List<BodyArea> _bodyAreas =
                  BodyAreas$Query.fromJson(result.data ?? {}).bodyAreas;

              List<BodyArea> _frontBodyAreas = _bodyAreas
                  .where((ba) =>
                      ba.frontBack == BodyAreaFrontBack.front ||
                      ba.frontBack == BodyAreaFrontBack.both)
                  .toList();

              List<BodyArea> _backBodyAreas = _bodyAreas
                  .where((ba) =>
                      ba.frontBack == BodyAreaFrontBack.back ||
                      ba.frontBack == BodyAreaFrontBack.both)
                  .toList();

              final Color _nonActiveColor =
                  context.theme.primary.withOpacity(0.1);
              return LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: bodyAreaScores.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: MyText(
                                'Full Body',
                                weight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                    'assets/body_areas/full_front.svg',
                                    height: constraints.maxHeight - 100,
                                    color: _activeColor),
                                SvgPicture.asset(
                                    'assets/body_areas/full_back.svg',
                                    height: constraints.maxHeight - 100,
                                    color: _activeColor),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: bodyAreaScores
                                  .where((bam) =>
                                      bam.bodyArea.frontBack ==
                                          BodyAreaFrontBack.front ||
                                      bam.bodyArea.frontBack ==
                                          BodyAreaFrontBack.both)
                                  .sortedBy<num>((bam) => bam.score)
                                  .reversed
                                  .map((bam) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                              bam.bodyArea.name,
                                              weight: FontWeight.bold,
                                              size: FONTSIZE.SMALL,
                                            ),
                                            MyText(
                                              '${bam.score}%',
                                              weight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                            TargetedBodyAreasFrontBack(
                              front: true,
                              allBodyAreas: _frontBodyAreas,
                              activeColor: _activeColor,
                              averagedBodyAreaScores: bodyAreaScores,
                              basisOpacity: _basisOpacity,
                              nonActiveColor: _nonActiveColor,
                              height: constraints.maxHeight,
                            ),
                            TargetedBodyAreasFrontBack(
                              front: false,
                              allBodyAreas: _backBodyAreas,
                              activeColor: _activeColor,
                              averagedBodyAreaScores: bodyAreaScores,
                              basisOpacity: _basisOpacity,
                              nonActiveColor: _nonActiveColor,
                              height: constraints.maxHeight,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: bodyAreaScores
                                  .where((bam) =>
                                      bam.bodyArea.frontBack ==
                                      BodyAreaFrontBack.back)
                                  .sortedBy<num>((bam) => bam.score)
                                  .reversed
                                  .map((bam) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MyText(
                                              bam.bodyArea.name,
                                              weight: FontWeight.bold,
                                              subtext: true,
                                            ),
                                            MyText(
                                              '${bam.score}%',
                                              weight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                );
              });
            }));
  }
}

/// Display for either the front or back of the body, with targeted areas highlighted.
class TargetedBodyAreasFrontBack extends StatelessWidget {
  final Color nonActiveColor;
  final Color activeColor;
  final double basisOpacity;
  final bool front;
  final List<BodyAreaMoveScore> averagedBodyAreaScores;
  final double height;
  final List<BodyArea> allBodyAreas;
  TargetedBodyAreasFrontBack(
      {required this.nonActiveColor,
      required this.activeColor,
      required this.basisOpacity,
      required this.averagedBodyAreaScores,
      required this.front,
      required this.allBodyAreas,
      this.height = 300});

  Color _calculateColorBasedOnScore(BuildContext context,
      List<BodyAreaMoveScore> bodyAreaMoveScores, BodyArea bodyArea) {
    final double? score = bodyAreaMoveScores
        .where((bams) => bams.bodyArea == bodyArea)
        .averageBy((bams) => bams.score);
    return activeColor
        .withOpacity(((score ?? 0 / 100) * (1 - basisOpacity)) + basisOpacity);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
            front
                ? 'assets/body_areas/front/background_front.svg'
                : 'assets/body_areas/back/background_back.svg',
            height: height,
            color: nonActiveColor),
        ...allBodyAreas
            .map(
              (bodyArea) => SvgPicture.asset(
                  'assets/body_areas/${front ? "front" : "back"}/${Utils.getSvgAssetUriFromBodyAreaName(bodyArea.name)}.svg',
                  height: height,
                  color: _calculateColorBasedOnScore(
                      context, averagedBodyAreaScores, bodyArea)),
            )
            .toList()
      ],
    );
  }
}
