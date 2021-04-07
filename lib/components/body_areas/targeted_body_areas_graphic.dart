import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Display for either the front or back of the body, with targeted areas highlighted.
/// /// Each body area should only have one corresponding bodyAreaMoveScore in this list.
class TargetedBodyAreasGraphic extends StatelessWidget {
  final Color activeColor;
  final double basisOpacity;
  final bool front;
  final List<BodyAreaMoveScore> bodyAreaMoveScores;
  final double height;
  final List<BodyArea> allBodyAreas;

  /// Percentages do not really work very well for any object more complicated than a move.
  /// As it is very hard to take into consideration how difficult each move is in relation to the other.
  /// For example: a two move workout which consists of 100 pull ups and then 10 squats.
  /// Would show around 50 / 50 back vs legs split - when in actual fact it should be much more heavily weighted towards back as there are more pull ups and they are harder.
  final bool indicatePercentWithColor;
  TargetedBodyAreasGraphic(
      {required this.activeColor,
      this.basisOpacity = 0.08,
      required this.bodyAreaMoveScores,
      required this.front,
      required this.allBodyAreas,
      this.height = 300,
      this.indicatePercentWithColor = false});

  Color calculateColorBasedOnScore(BodyArea bodyArea) {
    final BodyAreaMoveScore bams =
        bodyAreaMoveScores.firstWhere((bams) => bams.bodyArea == bodyArea,
            orElse: () => BodyAreaMoveScore()
              ..score = 0
              ..bodyArea = bodyArea);
    if (indicatePercentWithColor) {
      final opacity =
          max(0.2, ((bams.score / 100) * (1 - basisOpacity)) + basisOpacity);
      return activeColor.withOpacity(opacity);
    } else {
      return bams.score == 0
          ? activeColor.withOpacity(basisOpacity)
          : activeColor.withOpacity(0.8);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nonActiveColor = Styles.lightGrey.withOpacity(0.05);
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
                  color: calculateColorBasedOnScore(bodyArea)),
            )
            .toList()
      ],
    );
  }
}
