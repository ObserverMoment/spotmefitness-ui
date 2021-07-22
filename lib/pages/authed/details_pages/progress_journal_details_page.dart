import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_entry_card.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goal_card.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goals_summary_card.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal/progress_journal_entry_creator.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal/progress_journal_goal_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

class ProgressJournalDetailsPage extends StatefulWidget {
  final String id;
  ProgressJournalDetailsPage({@PathParam('id') required this.id});

  @override
  _ProgressJournalDetailsPageState createState() =>
      _ProgressJournalDetailsPageState();
}

class _ProgressJournalDetailsPageState
    extends State<ProgressJournalDetailsPage> {
  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  void _openEditJournalMeta(ProgressJournal journal) {
    context.navigateTo(ProgressJournalCreatorRoute(progressJournal: journal));
  }

  void _handleDeleteJournal() {
    context.showConfirmDeleteDialog(
        itemType: 'Journal',
        message:
            'The journal, all entries and all goals will be deleted. Are you sure?',
        onConfirm: _deleteJournal);
  }

  Future<void> _deleteJournal() async {
    context.showLoadingAlert('Deleting Journal',
        icon: Icon(
          CupertinoIcons.delete_simple,
          color: Styles.errorRed,
        ));

    final variables = DeleteProgressJournalByIdArguments(id: widget.id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteProgressJournalByIdMutation(variables: variables),
        objectId: widget.id,
        typename: kProgressJournalTypename,
        clearQueryDataAtKeys: [
          GQLVarParamKeys.progressJournalByIdQuery(widget.id)
        ],

        /// TODO: Move this to new pattern once [UserProgressJournalsQuery] can take vars.
        removeRefFromQueries: [
          GQLOpNames.userProgressJournalsQuery
        ]);

    context.pop(); // Loading alert;

    if (result.hasErrors ||
        result.data?.deleteProgressJournalById != widget.id) {
      context.showToast(
          message:
              'Sorry, something went wrong, we were not able to delete this journal.',
          toastType: ToastType.destructive);
    } else {
      context.pop(); // Screen
    }
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ProgressJournalByIdQuery(
        variables: ProgressJournalByIdArguments(id: widget.id));

    return QueryObserver<ProgressJournalById$Query,
            ProgressJournalByIdArguments>(
        key: Key(
            'ProgressJournalDetailsPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerListPage(),
        builder: (data) {
          final journal = data.progressJournalById;
          return CupertinoPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: NavBarTitle(journal.name),
                trailing: NavBarEllipsisMenu(items: [
                  ContextMenuItem(
                      iconData: CupertinoIcons.info,
                      text: 'Edit Journal Meta',
                      onTap: () => _openEditJournalMeta(journal)),
                  ContextMenuItem(
                      iconData: CupertinoIcons.delete_simple,
                      destructive: true,
                      text: 'Delete Journal',
                      onTap: _handleDeleteJournal),
                ]),
              ),
              child: Column(
                children: [
                  MyTabBarNav(
                      titles: ['Entries', 'Goals'],
                      handleTabChange: _changeTab,
                      activeTabIndex: _activeTabIndex),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, top: 12.0),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: _changeTab,
                      children: [
                        ProgressJournalEntriesList(
                            parentJournalId: journal.id,
                            entries: journal.progressJournalEntries),
                        ProgressJournalGoalsList(
                          goals: journal.progressJournalGoals,
                          parentJournalId: journal.id,
                        ),
                      ],
                    ),
                  ))
                ],
              ));
        });
  }
}

class ProgressJournalEntriesList extends StatelessWidget {
  final String parentJournalId;
  final List<ProgressJournalEntry> entries;
  ProgressJournalEntriesList(
      {required this.entries, required this.parentJournalId});

  Future<void> _deleteJournalEntry(BuildContext context, String id) async {
    final variables = DeleteProgressJournalEntryByIdArguments(id: id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteProgressJournalEntryByIdMutation(variables: variables),
        objectId: id,
        typename: kProgressJournalEntryTypename,
        broadcastQueryIds: [
          GQLVarParamKeys.progressJournalByIdQuery(parentJournalId),
          GQLOpNames.userProgressJournalsQuery,
        ],
        removeAllRefsToId: true);

    if (result.hasErrors || result.data?.deleteProgressJournalEntryById != id) {
      context.showToast(
          message: 'Sorry, there was a problem deleting this entry.',
          toastType: ToastType.destructive);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedEntries =
        entries.sortedBy<DateTime>((e) => e.createdAt).reversed.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StackAndFloatingButton(
        onPressed: () => context.push(
            child: ProgressJournalEntryCreator(
          parentJournalId: parentJournalId,
        )),
        pageHasBottomNavBar: false,
        buttonIconData: CupertinoIcons.add,
        child: entries.isEmpty
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
                itemCount: entries.length + 1,
                itemBuilder: (c, i) {
                  if (i == entries.length) {
                    return SizedBox(height: kAssumedFloatingButtonHeight);
                  } else {
                    return GestureDetector(
                        onTap: () => context.push(
                                child: ProgressJournalEntryCreator(
                              parentJournalId: parentJournalId,
                              progressJournalEntry: sortedEntries[i],
                            )),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: AnimatedSlidable(
                                key: Key(
                                    'progress-journal-entry-${sortedEntries[i].id}'),
                                index: i,
                                itemType: 'Journal Entry',
                                itemName: sortedEntries[i].createdAt.dateString,
                                removeItem: (index) => _deleteJournalEntry(
                                    context, sortedEntries[i].id),
                                secondaryActions: [],
                                child: ProgressJournalEntryCard(
                                    sortedEntries[i]))));
                  }
                },
              ),
      ),
    );
  }
}

class ProgressJournalGoalsList extends StatelessWidget {
  final String parentJournalId;
  final List<ProgressJournalGoal> goals;
  ProgressJournalGoalsList(
      {required this.goals, required this.parentJournalId});

  Future<void> _deleteJournalGoal(BuildContext context, String id) async {
    final variables = DeleteProgressJournalGoalByIdArguments(id: id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteProgressJournalGoalByIdMutation(variables: variables),
        objectId: id,
        typename: kProgressJournalGoalTypename,
        broadcastQueryIds: [
          ProgressJournalByIdQuery(
                  variables: ProgressJournalByIdArguments(id: parentJournalId))
              .operationName,
          UserProgressJournalsQuery().operationName,
        ],
        removeAllRefsToId: true);

    if (result.hasErrors || result.data?.deleteProgressJournalGoalById != id) {
      context.showToast(
          message: 'Sorry, there was a problem deleting this goal.',
          toastType: ToastType.destructive);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedGoals =
        goals.sortedBy<DateTime>((e) => e.createdAt).reversed.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ProgressJournalGoalsSummaryCard(
            goals: goals,
          ),
          SizedBox(height: 10),
          Expanded(
            child: StackAndFloatingButton(
              onPressed: () => context.push(
                  child: ProgressJournalGoalCreator(
                      parentJournalId: parentJournalId)),
              pageHasBottomNavBar: false,
              buttonIconData: CupertinoIcons.add,
              child: goals.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(
                        'No goals yet',
                        textAlign: TextAlign.center,
                        subtext: true,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
                      itemCount: sortedGoals.length + 1,
                      itemBuilder: (c, i) {
                        if (i == sortedGoals.length) {
                          return SizedBox(height: kAssumedFloatingButtonHeight);
                        } else {
                          return GestureDetector(
                            onTap: () => context.push(
                                child: ProgressJournalGoalCreator(
                              parentJournalId: parentJournalId,
                              progressJournalGoal: sortedGoals[i],
                            )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: AnimatedSlidable(
                                key: Key(
                                    'progress-journal-goal-${sortedGoals[i].id}'),
                                index: i,
                                itemType: 'Journal Goal',
                                itemName: sortedGoals[i].name,
                                removeItem: (index) => _deleteJournalGoal(
                                    context, sortedGoals[i].id),
                                secondaryActions: [],
                                child: ProgressJournalGoalCard(
                                    markGoalComplete: (goal) => print(goal),
                                    progressJournalGoal: sortedGoals[i]),
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
