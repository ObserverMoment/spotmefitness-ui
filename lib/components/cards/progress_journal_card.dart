import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ProgressJournalCard extends StatelessWidget {
  final ProgressJournal progressJournal;
  ProgressJournalCard(this.progressJournal);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 110,
                    height: 160,
                    child: progressJournal.coverImageUri == null
                        ? Image.asset(
                            'assets/progress_page_images/journal_placeholder.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          )
                        : ImageViewer(
                            uri: progressJournal.coverImageUri!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            H3(progressJournal.name),
                            if (Utils.textNotNull(progressJournal.description))
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: MyText(
                                  progressJournal.description!,
                                  maxLines: 4,
                                  lineHeight: 1.4,
                                  size: FONTSIZE.SMALL,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MyText(
                                    '${progressJournal.progressJournalEntries.length} entries'),
                                SizedBox(height: 4),
                                MyText(
                                  'Since ${DateFormat("dd-MM-yyyy").format(progressJournal.createdAt)}',
                                  color: Styles.colorTwo,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (progressJournal.progressJournalGoals.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.start,
                children: progressJournal.progressJournalGoals
                    .map((g) => ProgressJournalGoalAndTagsTag(g))
                    .toList(),
              ),
            ),
          HorizontalLine(
            verticalPadding: 12,
          )
        ],
      ),
    );
  }
}
