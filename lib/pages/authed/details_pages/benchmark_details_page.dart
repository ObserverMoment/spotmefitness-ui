import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/benchmark_entry_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class BenchmarkDetailsPage extends StatelessWidget {
  final String id;
  BenchmarkDetailsPage({@PathParam('id') required this.id});

  @override
  Widget build(BuildContext context) {
    final query =
        UserBenchmarkByIdQuery(variables: UserBenchmarkByIdArguments(id: id));

    return QueryObserver<UserBenchmarkById$Query, UserBenchmarkByIdArguments>(
        key: Key('BenchmarkDetailsPage - ${query.operationName}-$id'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Benchmarks and PBs'),
        builder: (data) {
          final benchmark = data.userBenchmarkById;
          return CupertinoPageScaffold(
              key: Key('BenchmarkDetailsPage - CupertinoPageScaffold'),
              navigationBar: BasicNavBar(
                heroTag: 'BenchmarkDetailsPage',
                key: Key('BenchmarkDetailsPage - BasicNavBar'),
                middle: NavBarTitle(benchmark.name),
                trailing: NavBarEllipsisMenu(items: [
                  ContextMenuItem(
                      iconData: CupertinoIcons.info,
                      text: 'Edit meta',
                      onTap: () => print('edit benchmark')),
                  ContextMenuItem(
                      iconData: CupertinoIcons.delete_simple,
                      destructive: true,
                      text: 'Delete',
                      onTap: () => print('delete benchmark')),
                ]),
              ),
              child: Column(
                children: [
                  MyText(benchmark.name),
                  MyText('the meta info here'),

                  /// Move into EntriesList and make EntriesList stateful.
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SlidingSelect(
                        value: 'a',
                        updateValue: (v) => print(v),
                        children: {
                          'a': MyText('Oldest'),
                          'b': MyText('Newest'),
                          'c': MyText('Highest'),
                          'd': MyText('Lowest'),
                        }),
                  ),
                  Expanded(child: BenchmarkEntrieslist(benchmark)),
                ],
              ));
        });
  }
}

class BenchmarkEntrieslist extends StatelessWidget {
  final UserBenchmark userBenchmark;
  BenchmarkEntrieslist(this.userBenchmark);

  List<UserBenchmarkEntry> _sortEntries() {
    final entries =
        userBenchmark.userBenchmarkEntries.sortedBy<num>((e) => e.score);
    return userBenchmark.benchmarkType == BenchmarkType.fastesttime
        ? entries
        : entries.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final sortedEntries = _sortEntries();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StackAndFloatingButton(
        onPressed: () => print('benchmark entry creator'),
        pageHasBottomNavBar: false,
        buttonIconData: CupertinoIcons.add,
        child: sortedEntries.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  'No entries yet',
                  textAlign: TextAlign.center,
                  subtext: true,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
                itemCount: sortedEntries.length + 1,
                itemBuilder: (c, i) {
                  if (i == sortedEntries.length) {
                    return SizedBox(height: kAssumedFloatingButtonHeight);
                  } else {
                    return GestureDetector(
                        onTap: () => print('benchmark entry editor'),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: AnimatedSlidable(
                                key: Key(
                                    'benchmark-entry-${sortedEntries[i].id}'),
                                index: i,
                                itemType: 'Benchmark Entry',
                                itemName:
                                    sortedEntries[i].completedOn.dateString,
                                removeItem: (index) =>
                                    print('remove at $index'),
                                secondaryActions: [],
                                child: BenchmarkEntryCard(sortedEntries[i]))));
                  }
                },
              ),
      ),
    );
  }
}
