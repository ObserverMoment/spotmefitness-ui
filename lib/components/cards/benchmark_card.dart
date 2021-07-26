import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/benchmark/benchmark_entry_score_display.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
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

  Widget _buildScore(
          BuildContext context, int index, UserBenchmarkEntry entry) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BenchmarkEntryScoreDisplay(
                benchmark: userBenchmark,
                entry: entry,
              ),
              SizedBox(width: 6),
              MyText(
                '${entry.completedOn.minimalDateString}',
                size: FONTSIZE.TINY,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: MyText(
                        userBenchmark.name,
                        size: FONTSIZE.BIG,
                      ),
                    ),
                    MyText(
                      userBenchmark.benchmarkType.display,
                      lineHeight: 1.4,
                    ),
                    SizedBox(height: 6),
                    if (Utils.textNotNull(userBenchmark.description))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: MyText(
                          userBenchmark.description!,
                          maxLines: 5,
                          size: FONTSIZE.SMALL,
                          subtext: true,
                          lineHeight: 1.4,
                        ),
                      ),
                    if (Utils.textNotNull(userBenchmark.equipmentInfo))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: MyText(
                          userBenchmark.equipmentInfo!,
                          maxLines: 5,
                          size: FONTSIZE.SMALL,
                          color: Styles.colorTwo,
                          lineHeight: 1.4,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, right: 0, left: 8, bottom: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    userBenchmark.userBenchmarkEntries.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyText('No scores'),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: _sortEntries()
                                .take(3)
                                .mapIndexed(
                                    (i, e) => _buildScore(context, i, e))
                                .toList()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
