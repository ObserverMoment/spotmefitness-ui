import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/benchmark_card.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class RecentBenchmarkEntries extends StatelessWidget {
  final kBenchmarkEntryCardHeight = 170.0;

  @override
  Widget build(BuildContext context) {
    final query =
        UserBenchmarksQuery(variables: UserBenchmarksArguments(first: 20));
    return QueryObserver<UserBenchmarks$Query, json.JsonSerializable>(
        key: Key('RecentBenchmarkEntries - ${query.operationName}'),
        query: query,
        fullScreenError: false,
        loadingIndicator: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: ShimmerCard(
                  height: kBenchmarkEntryCardHeight - 30,
                ),
              ),
            ),
          ],
        ),
        builder: (data) {
          final benchmarks =
              data.userBenchmarks.sortedBy<DateTime>((b) => b.lastEntryAt);
          return benchmarks.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H2(
                            'Benchmarks',
                          ),
                          TextButton(
                            onPressed: () =>
                                context.pushRoute(YourBenchmarksRoute()),
                            underline: false,
                            text: 'All',
                            suffix: Icon(CupertinoIcons.arrow_right_square),
                          )
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: kBenchmarkEntryCardHeight,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: false,
                      ),
                      itemCount: benchmarks.length + 1,
                      itemBuilder: (c, i, _) {
                        if (i == benchmarks.length) {
                          return TextButton(
                            onPressed: () =>
                                context.pushRoute(YourBenchmarksRoute()),
                            underline: false,
                            text: 'View all',
                            suffix: Icon(CupertinoIcons.arrow_right_square),
                            fontSize: FONTSIZE.BIG,
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                                onTap: () => context.navigateTo(
                                    BenchmarkDetailsRoute(
                                        id: benchmarks[i].id)),
                                child: BenchmarkCard(benchmarks[i])),
                          );
                        }
                      },
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            'No recent benchmark entries',
                            subtext: true,
                          ),
                          CreateTextIconButton(
                              text: 'Add Benchmark',
                              onPressed: () =>
                                  context.pushRoute(YourBenchmarksRoute()))
                        ],
                      )),
                );
        });
  }
}
