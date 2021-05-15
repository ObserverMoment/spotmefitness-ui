import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_entry_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';

class ProgressJournalDetailsPage extends StatelessWidget {
  final String id;
  ProgressJournalDetailsPage({@PathParam('id') required this.id});

  @override
  Widget build(BuildContext context) {
    final query = ProgressJournalByIdQuery(
        variables: ProgressJournalByIdArguments(id: id));

    return QueryObserver<ProgressJournalById$Query,
            ProgressJournalByIdArguments>(
        key: Key('ProgressJournalDetailsPage - ${query.operationName}-$id'),
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
                    text: 'Add entry', onTap: () => print('add entry')),
                ContextMenuItem(
                    text: 'Edit name', onTap: () => print('edit name')),
                ContextMenuItem(
                    text: 'Edit description',
                    onTap: () => print('edit description'))
              ]),
            ),
            child: ListView(
              children: journal.progressJournalEntries
                  .map((e) => ProgressJournalEntryCard(e))
                  .toList(),
            ),
          );
        });
  }
}
