import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/personal_best_entry_card.dart';
import 'package:spotmefitness_ui/components/creators/personal_best_creator/personal_best_entry_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
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

class PersonalBestDetailsPage extends StatefulWidget {
  final String id;
  const PersonalBestDetailsPage({@PathParam('id') required this.id});

  @override
  _PersonalBestDetailsPageState createState() =>
      _PersonalBestDetailsPageState();
}

class _PersonalBestDetailsPageState extends State<PersonalBestDetailsPage> {
  ScrollController _scrollController = ScrollController();

  void _handleDeleteJournal() {
    context.showConfirmDeleteDialog(
        itemType: 'Personal Best',
        message: 'The PB and all its entries will be deleted. Are you sure?',
        onConfirm: _deleteBenchmark);
  }

  Future<void> _deleteBenchmark() async {
    context.showLoadingAlert('Deleting Personal Best',
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
          GQLOpNames.userBenchmarksQuery
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
        key: Key(
            'PersonalBestDetailsPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(),
        builder: (data) {
          final benchmark = data.userBenchmarkById;
          return MyPageScaffold(
            navigationBar: BottomBorderNavBar(
              bottomBorderColor: context.theme.navbarBottomBorder,
              middle: NavBarTitle(benchmark.name),
              trailing: NavBarTrailingRow(
                children: [
                  CreateIconButton(
                    onPressed: () => context.push(
                        child:
                            PersonalBestEntryCreator(userBenchmark: benchmark)),
                  ),
                  NavBarEllipsisMenu(items: [
                    ContextMenuItem(
                        iconData: CupertinoIcons.info,
                        text: 'Edit Personal Best',
                        onTap: () => context.navigateTo(
                            PersonalBestCreatorRoute(
                                userBenchmark: benchmark))),
                    ContextMenuItem(
                        iconData: CupertinoIcons.delete_simple,
                        destructive: true,
                        text: 'Delete Personal Best',
                        onTap: _handleDeleteJournal),
                  ]),
                ],
              ),
            ),
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: MyText(
                                benchmark.benchmarkType.display,
                                size: FONTSIZE.LARGE,
                              ),
                            ),
                            if (Utils.textNotNull(benchmark.description))
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: MyText(
                                  benchmark.description!,
                                  maxLines: 10,
                                  textAlign: TextAlign.center,
                                  lineHeight: 1.4,
                                ),
                              ),
                            if (Utils.textNotNull(benchmark.equipmentInfo))
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: MyText(
                                  benchmark.equipmentInfo!,
                                  maxLines: 10,
                                  textAlign: TextAlign.center,
                                  color: Styles.colorTwo,
                                  lineHeight: 1.4,
                                ),
                              ),
                            if (benchmark.userBenchmarkTags.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: benchmark.userBenchmarkTags
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
                      ]))
                    ],
                body: _PersonalBestEntrieslist(benchmark)),
          );
        });
  }
}

class _PersonalBestEntrieslist extends StatefulWidget {
  final UserBenchmark userBenchmark;
  _PersonalBestEntrieslist(this.userBenchmark);

  @override
  __PersonalBestEntrieslistState createState() =>
      __PersonalBestEntrieslistState();
}

enum ScoreSortBy { best, newest, oldest, worst }

class __PersonalBestEntrieslistState extends State<_PersonalBestEntrieslist> {
  ScoreSortBy _sortBy = ScoreSortBy.best;

  Future<void> _deleteBenchmarkEntry(UserBenchmarkEntry entry) async {
    final variables = DeleteUserBenchmarkEntryByIdArguments(id: entry.id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteUserBenchmarkEntryByIdMutation(variables: variables),
        objectId: entry.id,
        typename: kUserBenchmarkEntryTypename,
        broadcastQueryIds: [
          GQLVarParamKeys.userBenchmarkByIdQuery(widget.userBenchmark.id),
          GQLOpNames.userBenchmarksQuery,
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

    return sortedEntries.isEmpty
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
                padding: const EdgeInsets.all(16.0),
                child: SlidingSelect<ScoreSortBy>(
                    value: _sortBy,
                    updateValue: (sortBy) => setState(() => _sortBy = sortBy),
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
                    itemCount: sortedEntries.length,
                    itemBuilder: (c, i) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: GestureDetector(
                            onTap: () => context.push(
                                child: PersonalBestEntryCreator(
                              userBenchmark: widget.userBenchmark,
                              userBenchmarkEntry: sortedEntries[i],
                            )),
                            child: AnimatedSlidable(
                                key: Key('pb-entry-${sortedEntries[i].id}'),
                                index: i,
                                itemType: 'PB Entry',
                                itemName:
                                    sortedEntries[i].completedOn.dateString,
                                removeItem: (_) =>
                                    _deleteBenchmarkEntry(sortedEntries[i]),
                                secondaryActions: [],
                                child: PersonalBestEntryCard(
                                    benchmark: widget.userBenchmark,
                                    entry: sortedEntries[i])),
                          ));
                    }),
              ),
            ],
          );
  }
}
