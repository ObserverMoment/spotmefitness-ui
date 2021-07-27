import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/personal_best_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class PersonalBestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = UserBenchmarksQuery();
    return QueryObserver<UserBenchmarks$Query, json.JsonSerializable>(
        key: Key('PersonalBestsPage - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerListPage(),
        builder: (data) {
          final benchmarks = data.userBenchmarks
              .sortedBy<DateTime>((b) => b.lastEntryAt)
              .reversed
              .toList();

          return MyPageScaffold(
            navigationBar: BorderlessNavBar(
              middle: NavBarTitle('Personal Bests'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () =>
                        context.navigateTo(PersonalBestCreatorRoute()),
                  ),
                  InfoPopupButton(infoWidget: MyText('Info about PBs'))
                ],
              ),
            ),
            child: _FilterablePBsList(
                allBenchmarks: benchmarks,
                selectBenchmark: (id) =>
                    context.navigateTo(PersonalBestDetailsRoute(id: id))),
          );
        });
  }
}

/// Note: UserBenchmark (API) == Personal Best (UI)
class _FilterablePBsList extends StatefulWidget {
  final void Function(String benchmarkId) selectBenchmark;
  final List<UserBenchmark> allBenchmarks;
  const _FilterablePBsList(
      {Key? key, required this.selectBenchmark, required this.allBenchmarks})
      : super(key: key);

  @override
  __FilterablePBsListState createState() => __FilterablePBsListState();
}

class __FilterablePBsListState extends State<_FilterablePBsList> {
  UserBenchmarkTag? _userBenchmarkTagFilter;

  @override
  Widget build(BuildContext context) {
    final allTags = widget.allBenchmarks
        .fold<List<UserBenchmarkTag>>(
            [], (acum, next) => [...acum, ...next.userBenchmarkTags])
        .toSet()
        .toList();

    final filteredBenchmarks = _userBenchmarkTagFilter == null
        ? widget.allBenchmarks
        : widget.allBenchmarks.where(
            (w) => w.userBenchmarkTags.contains(_userBenchmarkTagFilter));

    final sortedBenchmarks = filteredBenchmarks
        .sortedBy<DateTime>((w) => w.createdAt)
        .reversed
        .toList();

    return Column(
      children: [
        if (allTags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: SizedBox(
                height: 35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allTags.length,
                    itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SelectableTag(
                            text: allTags[i].name,
                            selectedColor: Styles.infoBlue,
                            isSelected: allTags[i] == _userBenchmarkTagFilter,
                            onPressed: () => setState(() =>
                                _userBenchmarkTagFilter =
                                    allTags[i] == _userBenchmarkTagFilter
                                        ? null
                                        : allTags[i]),
                          ),
                        ))),
          ),
        Expanded(
          child: _UserBenchmarksList(
            benchmarks: sortedBenchmarks,
            selectBenchmark: widget.selectBenchmark,
          ),
        ),
      ],
    );
  }
}

class _UserBenchmarksList extends StatelessWidget {
  final List<UserBenchmark> benchmarks;
  final void Function(String workoutId) selectBenchmark;
  const _UserBenchmarksList(
      {required this.benchmarks, required this.selectBenchmark});

  @override
  Widget build(BuildContext context) {
    return benchmarks.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(24),
            child: Center(child: MyText('No PBs to display...')))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: benchmarks.length,
            itemBuilder: (c, i) => GestureDetector(
                  key: Key(benchmarks[i].id),
                  onTap: () => selectBenchmark(benchmarks[i].id),
                  child: SizeFadeIn(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: PersonalBestCard(benchmarks[i]),
                    ),
                  ),
                ));
  }
}
