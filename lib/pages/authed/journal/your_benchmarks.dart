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

class YourBenchmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = UserBenchmarksQuery(variables: UserBenchmarksArguments());
    return QueryObserver<UserBenchmarks$Query, json.JsonSerializable>(
        key: Key('YourBenchmarksPage - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerCardList(itemCount: 10),
        builder: (data) {
          final benchmarks = data.userBenchmarks
              .sortedBy<DateTime>((b) => b.lastEntryAt)
              .reversed
              .toList();

          return CupertinoPageScaffold(
            key: Key('YourBenchmarksPage - CupertinoPageScaffold'),
            navigationBar: BasicNavBar(
              key: Key('YourBenchmarksPage - BasicNavBar'),
              middle: NavBarTitle('Benchmarks and PBs'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () => print('open benchmark creator'),
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
                  itemCount: benchmarks.length + 1,
                  itemBuilder: (c, i) {
                    if (i == benchmarks.length) {
                      return SizedBox(height: 60);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                            onTap: () => context.navigateTo(
                                BenchmarkDetailsRoute(id: benchmarks[i].id)),
                            child: BenchmarkCard(benchmarks[i])),
                      );
                    }
                  }),
            ),
          );
        });
  }
}
