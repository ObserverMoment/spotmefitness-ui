import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class PersonalBestCard extends StatelessWidget {
  final UserBenchmark userBenchmark;
  PersonalBestCard(this.userBenchmark);

  List<UserBenchmarkEntry> _sortEntries() {
    final entries =
        userBenchmark.userBenchmarkEntries.sortedBy<num>((e) => e.score);
    return userBenchmark.benchmarkType == BenchmarkType.fastesttime
        ? entries
        : entries.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final bestEntry = _sortEntries()[0];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: MyHeaderText(
                        userBenchmark.name,
                        size: FONTSIZE.BIG,
                      ),
                    ),
                    MyText(
                      userBenchmark.benchmarkType.display,
                    ),
                    SizedBox(height: 6),
                    if (Utils.textNotNull(userBenchmark.equipmentInfo))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: MyText(
                          userBenchmark.equipmentInfo!,
                          maxLines: 5,
                          color: Styles.colorTwo,
                        ),
                      ),
                  ],
                ),
              ),
              userBenchmark.userBenchmarkEntries.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText('No scores'),
                    )
                  : _BestEntryScoreDisplay(
                      benchmark: userBenchmark,
                      benchmarkEntry: bestEntry,
                    ),
            ],
          ),
          if (Utils.textNotNull(userBenchmark.description))
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: MyText(
                userBenchmark.description!,
                maxLines: 3,
                size: FONTSIZE.SMALL,
                lineHeight: 1.4,
              ),
            ),
          if (userBenchmark.userBenchmarkTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: userBenchmark.userBenchmarkTags
                    .map(
                      (tag) => Tag(
                        tag: tag.name,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _BestEntryScoreDisplay extends StatelessWidget {
  final UserBenchmark benchmark;
  final UserBenchmarkEntry benchmarkEntry;
  const _BestEntryScoreDisplay(
      {Key? key, required this.benchmark, required this.benchmarkEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              boxShadow: [Styles.avatarBoxShadow],
              gradient: Styles.secondaryButtonGradient,
              borderRadius: BorderRadius.circular(30)),
          child: MyHeaderText(
              DataUtils.buildBenchmarkEntryScoreText(benchmark, benchmarkEntry),
              size: FONTSIZE.BIG,
              color: Styles.white),
        ),
        SizedBox(height: 4),
        MyText(
          benchmarkEntry.completedOn.minimalDateStringYear,
          size: FONTSIZE.SMALL,
          subtext: true,
        )
      ],
    );
  }
}
