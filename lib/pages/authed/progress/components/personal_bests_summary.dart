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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyHeaderText(
                  'PERSONAL BESTS',
                  size: FONTSIZE.TINY,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (c, i) => PersonalBestEntrySummary(
                        userBenchmark: recentlySubmitted[i]),
                    separatorBuilder: (_, __) => HorizontalLine(
                          verticalPadding: 0,
                        ),
                    itemCount: recentlySubmitted.length),
              ],
            ),
          );
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyHeaderText(
                userBenchmark.name,
                size: FONTSIZE.SMALL,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  MyText(
                    userBenchmark.benchmarkType.display,
                    size: FONTSIZE.TINY,
                    color: Styles.colorTwo,
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
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: PersonalBestEntryScoreDisplay(
                  benchmark: userBenchmark,
                  entry: mostRecentEntry,
                  fontWeight: FontWeight.bold,
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
