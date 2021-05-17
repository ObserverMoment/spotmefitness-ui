import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_entry_card.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goal_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';

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

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
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
        loadingIndicator: ShimmerDetailsPage(title: 'Journals'),
        builder: (data) {
          final journal = data.progressJournalById;
          return CupertinoPageScaffold(
              navigationBar: BasicNavBar(
                middle: NavBarTitle(journal.name),
                trailing: NavBarEllipsisMenu(items: [
                  ContextMenuItem(
                      iconData: CupertinoIcons.info,
                      text: 'Edit Journal Meta',
                      onTap: () => print('open journal creator')),
                  ContextMenuItem(
                      iconData: CupertinoIcons.delete_simple,
                      destructive: true,
                      text: 'Delete Journal',
                      onTap: () => print('delete journal flow')),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 12.0),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: _changeTab,
                      children: [
                        _JournalEntriesList(journal.progressJournalEntries),
                        ProgressJournalGoalsList(journal.progressJournalGoals),
                      ],
                    ),
                  ))
                ],
              ));
        });
  }
}

class _JournalEntriesList extends StatelessWidget {
  final List<ProgressJournalEntry> entries;
  _JournalEntriesList(this.entries);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: entries.map((e) => ProgressJournalEntryCard(e)).toList(),
    );
  }
}

class ProgressJournalGoalsList extends StatelessWidget {
  final List<ProgressJournalGoal> goals;
  ProgressJournalGoalsList(this.goals);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: goals.map((g) => ProgressJournalGoalCard(g)).toList(),
    );
  }
}
