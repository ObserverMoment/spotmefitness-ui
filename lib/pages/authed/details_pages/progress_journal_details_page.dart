import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_entry_card.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goal_card.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goals_summary_card.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal/progress_journal_entry_creator.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal/progress_journal_goal_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/progress_journal/progress_journal_entries.dart';
import 'package:spotmefitness_ui/components/progress_journal/progress_journal_goals.dart';
import 'package:spotmefitness_ui/components/progress_journal/progress_journal_summary.dart';
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
import 'package:syncfusion_flutter_charts/charts.dart';

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
          return MyPageScaffold(
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
                      titles: ['Summary', 'Entries', 'Goals'],
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
                        ProgressJournalSummary(
                          journal: journal,
                        ),
                        ProgressJournalEntries(
                            parentJournalId: journal.id,
                            entries: journal.progressJournalEntries),
                        ProgressJournalGoals(
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
