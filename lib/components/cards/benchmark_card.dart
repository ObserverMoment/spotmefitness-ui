import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/Benchmark/benchmark_move_display.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class BenchmarkCard extends StatelessWidget {
  final UserBenchmark userBenchmark;
  BenchmarkCard(this.userBenchmark);

  List<UserBenchmarkEntry> _sortEntries() {
    final entries =
        userBenchmark.userBenchmarkEntries.sortedBy<num>((e) => e.score);
    return userBenchmark.benchmarkType == BenchmarkType.fastesttime
        ? entries
        : entries.reversed.toList();
  }

  String _buildScoreText(UserBenchmarkEntry entry) {
    if (userBenchmark.benchmarkType == BenchmarkType.maxload) {
      return '${entry.score.stringMyDouble()}${userBenchmark.loadUnit.display}';
    } else {
      return entry.score.round().secondsToTimeDisplay();
    }
  }

  Widget _buildScore(int index, UserBenchmarkEntry entry) => Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: RaisedButtonContainer(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          borderRadius: BorderRadius.circular(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                _buildScoreText(entry),
                size: index == 0
                    ? FONTSIZE.LARGE
                    : index == 1
                        ? FONTSIZE.MAIN
                        : FONTSIZE.SMALL,
              ),
              SizedBox(width: 4),
              MyText(
                '(${entry.completedOn.minimalDateString})',
                size: FONTSIZE.SMALL,
                color: Styles.infoBlue,
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    H3(userBenchmark.name),
                    MyText(userBenchmark.benchmarkType.display),
                    if (Utils.textNotNull(userBenchmark.description))
                      MyText(
                        userBenchmark.description!,
                        maxLines: 2,
                        size: FONTSIZE.SMALL,
                        subtext: true,
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  userBenchmark.userBenchmarkEntries.isEmpty
                      ? MyText('No scores')
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: _sortEntries()
                              .take(3)
                              .mapIndexed((i, e) => _buildScore(i, e))
                              .toList()),
                ],
              ),
            ],
          ),
          BenchmarkMoveDisplay(userBenchmark),
        ],
      ),
    );
  }
}
