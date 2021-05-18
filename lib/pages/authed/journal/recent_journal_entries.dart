import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_entry_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class RecentJournalEntries extends StatelessWidget {
  final kJournalEntryCardHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserProgressJournals$Query, json.JsonSerializable>(
        key: Key(
            'RecentJournalEntries - ${UserProgressJournalsQuery().operationName}'),
        query: UserProgressJournalsQuery(),
        loadingIndicator: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
                child: ShimmerCard(
                  height: kJournalEntryCardHeight - 30,
                ),
              ),
            ),
          ],
        ),
        builder: (data) {
          final entries = data.userProgressJournals
              .fold<List<ProgressJournalEntry>>(
                  [],
                  (entries, next) =>
                      [...entries, ...next.progressJournalEntries])
              .sortedBy<DateTime>((entry) => entry.createdAt)
              .reversed
              .toList();
          return entries.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            'Latest Journals',
                            weight: FontWeight.bold,
                          ),
                          TextButton(
                            onPressed: () =>
                                context.pushRoute(YourProgressJournalsRoute()),
                            underline: false,
                            text: 'View all',
                          )
                        ],
                      ),
                    ),
                    LayoutBuilder(
                        builder: (context, constraints) =>
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                height: kJournalEntryCardHeight,
                                viewportFraction: 0.94,
                                enableInfiniteScroll: false,
                              ),
                              itemCount: entries.length,
                              itemBuilder: (c, i, _) => Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                    onTap: () => context.pushRoute(
                                        ProgressJournalDetailsRoute(
                                            id: data.userProgressJournals
                                                .firstWhere((j) => j
                                                    .progressJournalEntries
                                                    .contains(entries[i]))
                                                .id)),
                                    child:
                                        ProgressJournalEntryCard(entries[i])),
                              ),
                            )),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            'No recent journal entries',
                            subtext: true,
                          ),
                          CreateTextIconButton(
                              text: 'Add Journal',
                              onPressed: () => context
                                  .pushRoute(YourProgressJournalsRoute()))
                        ],
                      )),
                );
        });
  }
}
