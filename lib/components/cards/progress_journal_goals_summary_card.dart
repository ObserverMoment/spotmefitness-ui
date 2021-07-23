import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ProgressJournalGoalsSummaryCard extends StatefulWidget {
  final List<ProgressJournalGoal> goals;
  ProgressJournalGoalsSummaryCard({required this.goals});
  @override
  _ProgressJournalGoalsSummaryCardState createState() =>
      _ProgressJournalGoalsSummaryCardState();
}

class _ProgressJournalGoalsSummaryCardState
    extends State<ProgressJournalGoalsSummaryCard> {
  bool _minimized = true;

  @override
  Widget build(BuildContext context) {
    final generalTag = ProgressJournalGoalTag()
      ..id = 'generalTag'
      ..createdAt = DateTime.now()
      ..hexColor = '#686868'
      ..tag = 'Other';

    final goalsByTag = widget.goals
        .fold<Map<ProgressJournalGoalTag, List<ProgressJournalGoal>>>({},
            (obj, goal) {
      if (goal.progressJournalGoalTags.isEmpty) {
        if (obj[generalTag] != null) {
          obj[generalTag]!.add(goal);
        } else {
          obj[generalTag] = [goal];
        }
      } else {
        for (final tag in goal.progressJournalGoalTags) {
          if (obj[tag] != null) {
            obj[tag]!.add(goal);
          } else {
            obj[tag] = [goal];
          }
        }
      }

      return obj;
    });

    final completed = widget.goals.where((g) => g.completedDate != null).length;

    return Card(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                '$completed of ${widget.goals.length} goals completed',
              ),
              ShowHideDetailsButton(
                onPressed: () => setState(() => _minimized = !_minimized),
                showDetails: !_minimized,
                showText: 'Show',
                hideText: 'Hide',
              )
            ],
          ),
          GrowInOut(
              show: !_minimized,
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: goalsByTag.entries
                        .map((e) => GoalTagProgressIndicator(
                              tag: e.key,
                              goals: e.value,
                            ))
                        .toList()),
              )),
        ],
      ),
    );
  }
}

class GoalTagProgressIndicator extends StatelessWidget {
  final ProgressJournalGoalTag tag;
  final List<ProgressJournalGoal> goals;
  GoalTagProgressIndicator({required this.tag, required this.goals});

  @override
  Widget build(BuildContext context) {
    final numComplete = goals.where((g) => g.completedDate != null).length;
    final fractionComplete = numComplete / goals.length;

    final color = HexColor.fromHex(tag.hexColor);
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularPercentIndicator(
                startAngle: 180,
                backgroundColor: color.withOpacity(0.1),
                circularStrokeCap: CircularStrokeCap.butt,
                radius: 60.0,
                lineWidth: 30.0,
                percent: fractionComplete,
                progressColor: color,
              ),
              if (fractionComplete == 1)
                FadeIn(
                    child: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: Styles.white,
                  size: 28,
                ))
            ],
          ),
          SizedBox(height: 4),
          MyText(
            tag.tag,
            size: FONTSIZE.SMALL,
            weight: FontWeight.bold,
          ),
          MyText(
            '$numComplete of ${goals.length}',
            size: FONTSIZE.SMALL,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
