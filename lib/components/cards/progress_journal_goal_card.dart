import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ProgressJournalGoalCard extends StatelessWidget {
  final ProgressJournalGoal progressJournalGoal;
  ProgressJournalGoalCard(this.progressJournalGoal);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          MyText(progressJournalGoal.name),
          MyText('Tags here'),
          MyText('Actions here')
        ],
      ),
    );
  }
}
