import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/benchmark_entry_card.dart';
import 'package:spotmefitness_ui/components/creators/benchmark_creator/benchmark_entry_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class BenchmarkDetailsPage extends StatefulWidget {
  final String id;
  const BenchmarkDetailsPage({@PathParam('id') required this.id});

  @override
  _BenchmarkDetailsPageState createState() => _BenchmarkDetailsPageState();
}

class _BenchmarkDetailsPageState extends State<BenchmarkDetailsPage> {
  ScrollController _scrollController = ScrollController();

  void _handleDeleteJournal() {
    context.showConfirmDeleteDialog(
        itemType: 'Benchmark',
        message:
            'The benchmark and all its entries will be deleted. Are you sure?',
        onConfirm: _deleteBenchmark);
  }

  Future<void> _deleteBenchmark() async {
    context.showLoadingAlert('Deleting Benchmark',
        icon: Icon(
          CupertinoIcons.delete_simple,
          color: Styles.errorRed,
        ));

    final variables = DeleteUserBenchmarkByIdArguments(id: widget.id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteUserBenchmarkByIdMutation(variables: variables),
        objectId: widget.id,
        typename: kUserBenchmarkTypename,
        clearQueryDataAtKeys: [
          getParameterizedQueryId(UserBenchmarkByIdQuery(
              variables: UserBenchmarkByIdArguments(id: widget.id)))
        ],
        removeRefFromQueries: [
          GQLNullVarsKeys.userBenchmarksQuery
        ]);

    context.pop(); // Loading alert;

    if (result.hasErrors || result.data?.deleteUserBenchmarkById != widget.id) {
      context.showToast(
          message: "Sorry, that didn't work", toastType: ToastType.destructive);
    } else {
      context.pop(); // Screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = UserBenchmarkByIdQuery(
        variables: UserBenchmarkByIdArguments(id: widget.id));

    return QueryObserver<UserBenchmarkById$Query, UserBenchmarkByIdArguments>(
        key: Key('BenchmarkDetailsPage - ${query.operationName}-${widget.id}'),
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
                    text: 'Edit Benchmark',
                    onTap: () => context.navigateTo(
                        BenchmarkCreatorRoute(userBenchmark: benchmark))),
                ContextMenuItem(
                    iconData: CupertinoIcons.delete_simple,
                    destructive: true,
                    text: 'Delete Benchmark',
                    onTap: _handleDeleteJournal),
              ]),
            ),
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            H2(benchmark.benchmarkType.display),
                            if (Utils.textNotNull(benchmark.description))
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 16),
                                child: MyText(
                                  benchmark.description!,
                                  maxLines: 8,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BenchmarkMetaDisplay(benchmark),
                        ),
                      ]))
                    ],
                body: BenchmarkEntrieslist(benchmark)),
          );
        });
  }
}

class BenchmarkMetaDisplay extends StatelessWidget {
  final UserBenchmark userBenchmark;
  BenchmarkMetaDisplay(this.userBenchmark);

  Widget _buildRepDisplay() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          userBenchmark.reps!.stringMyDouble(),
          lineHeight: 1.2,
          size: FONTSIZE.HUGE,
        ),
        SizedBox(
          width: 6,
        ),
        MyText(
          [WorkoutMoveRepType.distance, WorkoutMoveRepType.time]
                  .contains(userBenchmark.repType)
              ? userBenchmark.distanceUnit.shortDisplay
              : userBenchmark.reps != 1
                  ? describeEnum(userBenchmark.repType)
                  : userBenchmark.repType.displaySingular,
          size: FONTSIZE.LARGE,
        ),
      ],
    );
  }

  Widget _buildLoadDisplay() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          userBenchmark.load!.stringMyDouble(),
          lineHeight: 1.2,
          size: FONTSIZE.HUGE,
        ),
        MyText(
          userBenchmark.loadUnit.display,
          size: FONTSIZE.LARGE,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      MyText(
        userBenchmark.move.name,
        size: FONTSIZE.HUGE,
      ),
      if (userBenchmark.equipment != null)
        MyText(
          userBenchmark.equipment!.name,
          color: Styles.colorTwo,
          size: FONTSIZE.LARGE,
        ),
      if (Utils.hasReps(userBenchmark.reps)) _buildRepDisplay(),
      if (Utils.hasLoad(userBenchmark.load)) _buildLoadDisplay(),
    ]);
  }
}

class BenchmarkEntrieslist extends StatefulWidget {
  final UserBenchmark userBenchmark;
  BenchmarkEntrieslist(this.userBenchmark);

  @override
  _BenchmarkEntrieslistState createState() => _BenchmarkEntrieslistState();
}

enum ScoreSortBy { best, newest, oldest, worst }

class _BenchmarkEntrieslistState extends State<BenchmarkEntrieslist> {
  ScoreSortBy _sortBy = ScoreSortBy.best;

  Future<void> _deleteBenchmarkEntry(UserBenchmarkEntry entry) async {
    final variables = DeleteUserBenchmarkEntryByIdArguments(id: entry.id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteUserBenchmarkEntryByIdMutation(variables: variables),
        objectId: entry.id,
        typename: kUserBenchmarkEntryTypename,
        broadcastQueryIds: [
          GQLVarParamKeys.userBenchmarkByIdQuery(widget.userBenchmark.id),
          GQLNullVarsKeys.userBenchmarksQuery,
        ],
        removeAllRefsToId: true);

    if (result.hasErrors ||
        result.data?.deleteUserBenchmarkEntryById != entry.id) {
      context.showToast(
          message: 'Sorry, there was a problem deleting this entry.',
          toastType: ToastType.destructive);
    }
  }

  List<UserBenchmarkEntry> _sortEntries() {
    switch (_sortBy) {
      case ScoreSortBy.newest:
        return widget.userBenchmark.userBenchmarkEntries
            .sortedBy<DateTime>((e) => e.completedOn)
            .reversed
            .toList();
      case ScoreSortBy.oldest:
        return widget.userBenchmark.userBenchmarkEntries
            .sortedBy<DateTime>((e) => e.completedOn);
      case ScoreSortBy.best:
        final entries = widget.userBenchmark.userBenchmarkEntries
            .sortedBy<num>((e) => e.score);
        return widget.userBenchmark.benchmarkType == BenchmarkType.fastesttime
            ? entries
            : entries.reversed.toList();
      case ScoreSortBy.worst:
        final entries = widget.userBenchmark.userBenchmarkEntries
            .sortedBy<num>((e) => e.score);
        return widget.userBenchmark.benchmarkType != BenchmarkType.fastesttime
            ? entries
            : entries.reversed.toList();
      default:
        return widget.userBenchmark.userBenchmarkEntries;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedEntries = _sortEntries();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StackAndFloatingButton(
        onPressed: () => context.showBottomSheet(
            expand: true,
            child: BenchmarkEntryCreator(userBenchmark: widget.userBenchmark)),
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
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SlidingSelect<ScoreSortBy>(
                        value: _sortBy,
                        updateValue: (sortBy) =>
                            setState(() => _sortBy = sortBy),
                        children: {
                          for (final v in ScoreSortBy.values)
                            v: MyText(describeEnum(v).capitalize)
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
                      itemCount: sortedEntries.length + 1,
                      itemBuilder: (c, i) {
                        if (i == sortedEntries.length) {
                          return SizedBox(height: kAssumedFloatingButtonHeight);
                        } else {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: GestureDetector(
                                onTap: () => context.showBottomSheet(
                                    expand: true,
                                    child: BenchmarkEntryCreator(
                                      userBenchmark: widget.userBenchmark,
                                      userBenchmarkEntry: sortedEntries[i],
                                    )),
                                child: AnimatedSlidable(
                                    key: Key(
                                        'benchmark-entry-${sortedEntries[i].id}'),
                                    index: i,
                                    itemType: 'Benchmark Entry',
                                    itemName:
                                        sortedEntries[i].completedOn.dateString,
                                    removeItem: (_) =>
                                        _deleteBenchmarkEntry(sortedEntries[i]),
                                    secondaryActions: [],
                                    child: BenchmarkEntryCard(
                                        benchmark: widget.userBenchmark,
                                        entry: sortedEntries[i])),
                              ));
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
