import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goals_summary_card.dart';
import 'package:spotmefitness_ui/components/journal/bodyweight_tracker_chart.dart';
import 'package:spotmefitness_ui/components/journal/reflective_journaling_chart.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ProgressJournalSummary extends StatelessWidget {
  final ProgressJournal journal;
  ProgressJournalSummary({Key? key, required this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProgressJournalGoalsSummaryCard(
            goals: journal.progressJournalGoals,
          ),
          HorizontalLine(
            verticalPadding: 16,
          ),
          ReflectiveJournalingChart(
            journal: journal,
          ),
          HorizontalLine(
            verticalPadding: 16,
          ),
          BodyweightTrackerChart(
            journal: journal,
          )
        ],
      ),
    );
  }
}
