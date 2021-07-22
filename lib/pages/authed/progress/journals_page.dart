import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class JournalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserProgressJournals$Query, json.JsonSerializable>(
        key: Key('JournalsPage - ${UserProgressJournalsQuery().operationName}'),
        query: UserProgressJournalsQuery(),
        loadingIndicator: ShimmerListPage(),
        builder: (data) {
          final journals = data.userProgressJournals
              .sortedBy<DateTime>((j) => j.createdAt)
              .reversed
              .toList();

          return CupertinoPageScaffold(
            key: Key('JournalsPage - CupertinoPageScaffold'),
            navigationBar: BorderlessNavBar(
              key: Key('JournalsPage - BorderlessNavBar'),
              middle: NavBarTitle('Journals'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () =>
                        context.navigateTo(ProgressJournalCreatorRoute()),
                  ),
                  InfoPopupButton(infoWidget: MyText('Info about the journals'))
                ],
              ),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: journals.length,
                itemBuilder: (context, index) {
                  final ProgressJournal journal = journals[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: GestureDetector(
                        onTap: () => context.navigateTo(
                            ProgressJournalDetailsRoute(id: journal.id)),
                        child: ProgressJournalCard(journal)),
                  );
                }),
          );
        });
  }
}
