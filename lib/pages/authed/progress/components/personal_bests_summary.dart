import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/personal_best/personal_best_entry_score_display.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class PersonalBestsSummary extends StatelessWidget {
  const PersonalBestsSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserBenchmarks$Query, json.JsonSerializable>(
        key: Key(
            'StreakAndStatsSummary - ${UserBenchmarksQuery().operationName}'),
        query: UserBenchmarksQuery(),
        loadingIndicator: ShimmerCard(),
        builder: (data) {
          final recentlySubmitted = data.userBenchmarks
              .where((b) => b.userBenchmarkEntries.isNotEmpty)
              .sortedBy<DateTime>((b) => b.lastEntryAt)
              .reversed
              .take(3)
              .toList();

          return ContentBox(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: recentlySubmitted
                          .map((b) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child:
                                    PersonalBestEntrySummary(userBenchmark: b),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ));
        });
  }
}

class PersonalBestEntrySummary extends StatelessWidget {
  final UserBenchmark userBenchmark;
  const PersonalBestEntrySummary({Key? key, required this.userBenchmark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mostRecentEntry = userBenchmark.userBenchmarkEntries
        .sortedBy<DateTime>((e) => e.completedOn)
        .last;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: context.theme.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                userBenchmark.name,
                size: FONTSIZE.SMALL,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  MyText(
                    userBenchmark.benchmarkType.display,
                    size: FONTSIZE.TINY,
                  ),
                  MyText(
                    ' | ',
                    size: FONTSIZE.TINY,
                  ),
                  MyText(
                    mostRecentEntry.completedOn.compactDateString,
                    size: FONTSIZE.TINY,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: PersonalBestEntryScoreDisplay(
                  benchmark: userBenchmark,
                  entry: mostRecentEntry,
                ),
              ),
              if (Utils.textNotNull(userBenchmark.equipmentInfo))
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: MyText(
                    userBenchmark.equipmentInfo!,
                    color: Styles.colorTwo,
                    size: FONTSIZE.TINY,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
