import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_goals_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/progress_journal/bodyweight_tracker_chart.dart';
import 'package:spotmefitness_ui/components/progress_journal/reflective_journaling_chart.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
