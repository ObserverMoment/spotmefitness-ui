import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/body_areas/body_area_selector_overlay.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas_graphics.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

/// Consists of two components. The graphic displaying the scores for each body area (with optional opacity gradient). And a selector overlay with a gesture detector + clip path for each body area.
class BodyAreaSelectorAndMoveScoreIndicator extends StatelessWidget {
  final void Function(BodyArea bodyArea) handleTapBodyArea;
  final BodyAreaFrontBack frontBack;
  final List<BodyArea> allBodyAreas;
  final List<BodyAreaMoveScore> bodyAreaMoveScores;
  final bool indicatePercentWithColor;
  BodyAreaSelectorAndMoveScoreIndicator(
      {required this.handleTapBodyArea,
      required this.bodyAreaMoveScores,
      required this.frontBack,
      required this.allBodyAreas,
      required this.indicatePercentWithColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        TargetedBodyAreasScoreIndicator(
          bodyAreaMoveScores: bodyAreaMoveScores,
          frontBack: frontBack,
          allBodyAreas: allBodyAreas,
          indicatePercentWithColor: indicatePercentWithColor,
        ),
        BodyAreaSelectorOverlay(
          frontBack: frontBack,
          allBodyAreas: allBodyAreas,
          onTapBodyArea: handleTapBodyArea,
        )
      ],
    );
  }
}

/// Consists of two components. The graphic displaying if each body area is selected or not - boolean - no opacity gradient or score amount indication. And a selector overlay with a gesture detector + clip path for each body area.
class BodyAreaSelectorIndicator extends StatelessWidget {
  final void Function(BodyArea bodyArea) handleTapBodyArea;
  final BodyAreaFrontBack frontBack;
  final List<BodyArea> allBodyAreas;
  final List<BodyArea> selectedBodyAreas;
  BodyAreaSelectorIndicator({
    required this.handleTapBodyArea,
    required this.selectedBodyAreas,
    required this.frontBack,
    required this.allBodyAreas,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        TargetedBodyAreasSelectedIndicator(
          frontBack: frontBack,
          allBodyAreas: allBodyAreas,
          selectedBodyAreas: selectedBodyAreas,
        ),
        BodyAreaSelectorOverlay(
          frontBack: frontBack,
          allBodyAreas: allBodyAreas,
          onTapBodyArea: handleTapBodyArea,
        )
      ],
    );
  }
}
