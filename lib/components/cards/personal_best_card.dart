import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/data_utils.dart';
import 'package:sofie_ui/services/utils.dart';

class PersonalBestCard extends StatelessWidget {
  final UserBenchmark userBenchmark;
  const PersonalBestCard({Key? key, required this.userBenchmark})
      : super(key: key);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: MyHeaderText(
                        userBenchmark.name,
                        size: FONTSIZE.four,
                      ),
                    ),
                    MyText(
                      userBenchmark.benchmarkType.display,
                    ),
                    const SizedBox(height: 6),
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
              if (userBenchmark.userBenchmarkEntries.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MyText('No scores'),
                )
              else
                _BestEntryScoreDisplay(
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
                size: FONTSIZE.two,
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
              size: FONTSIZE.four,
              color: Styles.white),
        ),
        const SizedBox(height: 4),
        MyText(
          benchmarkEntry.completedOn.minimalDateStringYear,
          size: FONTSIZE.two,
          subtext: true,
        )
      ],
    );
  }
}
