import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/benchmark_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class BenchmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = UserBenchmarksQuery(variables: UserBenchmarksArguments());
    return QueryObserver<UserBenchmarks$Query, json.JsonSerializable>(
        key: Key('BenchmarksPage - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerCardList(itemCount: 10),
        builder: (data) {
          final benchmarks = data.userBenchmarks
              .sortedBy<DateTime>((b) => b.lastEntryAt)
              .reversed
              .toList();

          return CupertinoPageScaffold(
            navigationBar: BorderlessNavBar(
              middle: NavBarTitle('Benchmarks & PBs'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () =>
                        context.navigateTo(BenchmarkCreatorRoute()),
                  ),
                  InfoPopupButton(
                      infoWidget: MyText('Info about the benchmarks'))
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: benchmarks.length,
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                          onTap: () => context.navigateTo(
                              BenchmarkDetailsRoute(id: benchmarks[i].id)),
                          child: BenchmarkCard(benchmarks[i])),
                    );
                  }),
            ),
          );
        });
  }
}
