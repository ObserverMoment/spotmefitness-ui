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

          return MyPageScaffold(
            key: Key('JournalsPage - CupertinoPageScaffold'),
            navigationBar: MyNavBar(
              key: Key('JournalsPage - MyNavBar'),
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
            child: journals.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: SecondaryButton(
                              prefixIconData: CupertinoIcons.add,
                              text: 'New Journal',
                              onPressed: () => context
                                  .navigateTo(ProgressJournalCreatorRoute())),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: journals.length,
                    itemBuilder: (context, index) {
                      final ProgressJournal journal = journals[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                            behavior: HitTestBehavior
                                .opaque, // As there is empty space in the [ProgressJournalCard] which otherwise would not react to taps.
                            onTap: () => context.navigateTo(
                                ProgressJournalDetailsRoute(id: journal.id)),
                            child: ProgressJournalCard(journal)),
                      );
                    }),
          );
        });
  }
}
