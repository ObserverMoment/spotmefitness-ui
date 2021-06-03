import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

/// Text based column list or horizontal wrap list, with the highest scores at the top / left.
/// Each body area should only have one corresponding bodyAreaMoveScore in this list.
class TargetedBodyAreasScoreList extends StatelessWidget {
  final List<BodyAreaMoveScore> bodyAreaMoveScores;

  /// Percentages do not really work very well for any object more complicated than a move.
  /// As it is very hard to take into consideration how difficult each move is in relation to the other.
  /// For example: a two move workout which consists of 100 pull ups and then 10 squats.
  /// Would show around 50 / 50 back vs legs split - when in actual fact it should be much more heavily weighted towards back as there are more pull ups and they are harder.
  final bool showNumericalScore;
  TargetedBodyAreasScoreList(this.bodyAreaMoveScores,
      {this.showNumericalScore = false});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 5,
      children: bodyAreaMoveScores
          .sortedBy<num>((bam) => bam.score)
          .reversed
          .map((bam) => Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: context.theme.cardBackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      bam.bodyArea.name,
                    ),
                    if (showNumericalScore)
                      MyText(
                        '${bam.score.round()}%',
                        size: FONTSIZE.SMALL,
                        weight: FontWeight.bold,
                      ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class TargetedBodyAreasList extends StatelessWidget {
  final List<BodyArea> selectedBodyAreas;
  TargetedBodyAreasList(
    this.selectedBodyAreas,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 5,
      children: selectedBodyAreas
          .map((ba) => Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: context.theme.cardBackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(ba.name),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

/// Wrap / comma separated text list.
class BodyAreaNamesList extends StatelessWidget {
  final List<BodyArea> bodyAreas;
  BodyAreaNamesList(this.bodyAreas);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: 3,
        runSpacing: 3,
        children: bodyAreas
            .asMap()
            .map((index, bodyArea) => MapEntry(
                index,
                MyText(index == bodyAreas.length - 1
                    ? '${bodyArea.name}.'
                    : '${bodyArea.name},')))
            .values
            .toList());
  }
}
