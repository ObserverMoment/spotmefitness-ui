import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ProgressJournalCard extends StatelessWidget {
  final ProgressJournal progressJournal;
  ProgressJournalCard(this.progressJournal);
  @override
  Widget build(BuildContext context) {
    return Card(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                H3(progressJournal.name),
              ],
            ),
            SizedBox(height: 4),
            if (Utils.textNotNull(progressJournal.description))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: MyText(
                  progressJournal.description!,
                  subtext: true,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Row(
              children: [
                MyText(
                    '${progressJournal.progressJournalEntries.length} entries since '),
                MyText(
                  DateFormat('dd-MM-yyyy').format(progressJournal.createdAt),
                  weight: FontWeight.bold,
                  color: Styles.colorTwo,
                ),
              ],
            )
          ],
        ));
  }
}
