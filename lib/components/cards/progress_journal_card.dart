import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ProgressJournalCard extends StatelessWidget {
  final ProgressJournal progressJournal;
  ProgressJournalCard(this.progressJournal);
  @override
  Widget build(BuildContext context) {
    return Card(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            H3(progressJournal.name),
            SizedBox(height: 4),
            if (Utils.textNotNull(progressJournal.description))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: MyText(
                  progressJournal.description!,
                  subtext: true,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                      '${progressJournal.progressJournalEntries.length} entries since '),
                  MyText(
                    DateFormat('dd-MM-yyyy').format(progressJournal.createdAt),
                    color: Styles.colorTwo,
                  ),
                ],
              ),
            ),
            if (progressJournal.progressJournalGoals.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: progressJournal.progressJournalGoals
                      .map((g) => ProgressJournalGoalAndTagsTag(g))
                      .toList(),
                ),
              )
          ],
        ));
  }
}
