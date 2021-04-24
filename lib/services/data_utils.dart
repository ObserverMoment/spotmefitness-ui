import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';

class DataUtils {
  /// Receives any list of bodyAreaMove scores and returns a new list.
  /// Where each body area is represented only once and the score associated with it is calculated as a percentage of the whole list.
  static List<BodyAreaMoveScore> percentageBodyAreaMoveScores(
      List<BodyAreaMoveScore> bodyAreaMoveScores) {
    final totalPoints = bodyAreaMoveScores.sumByDouble((bams) => bams.score);
    final grouped = bodyAreaMoveScores.groupBy((bams) => bams.bodyArea);
    final summed = grouped.keys.map((bodyArea) {
      return grouped[bodyArea]!.fold(
          BodyAreaMoveScore()
            ..bodyArea = bodyArea
            ..score = 0, (BodyAreaMoveScore acum, next) {
        acum.score += next.score as int;
        return acum;
      });
    });
    return summed.map((bams) {
      bams.score = ((bams.score ~/ totalPoints) * 100);
      return bams;
    }).toList();
  }
}
