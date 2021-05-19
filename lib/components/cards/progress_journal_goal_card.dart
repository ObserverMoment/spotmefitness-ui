import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ProgressJournalGoalCard extends StatelessWidget {
  final ProgressJournalGoal progressJournalGoal;
  final void Function(ProgressJournalGoal goal) markGoalComplete;
  ProgressJournalGoalCard(
      {required this.progressJournalGoal, required this.markGoalComplete});

  @override
  Widget build(BuildContext context) {
    final isComplete = progressJournalGoal.completedDate != null;

    return AnimatedOpacity(
      opacity: isComplete ? 0.7 : 1,
      duration: kStandardAnimationDuration,
      child: ContentBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyText(
                          progressJournalGoal.name,
                          weight: FontWeight.bold,
                          decoration:
                              isComplete ? TextDecoration.lineThrough : null,
                        ),
                        if (!isComplete && progressJournalGoal.deadline != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: MyText(
                              'by ${progressJournalGoal.deadline!.compactDateString}',
                              size: FONTSIZE.SMALL,
                              decoration: isComplete
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: progressJournalGoal.deadline!
                                      .isBefore(DateTime.now())
                                  ? Styles.errorRed
                                  : Styles.infoBlue,
                            ),
                          ),
                        if (isComplete)
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: MyText(
                              'Completed ${progressJournalGoal.completedDate!.compactDateString}',
                              color: Styles.infoBlue,
                              weight: FontWeight.bold,
                            ),
                          )
                      ],
                    ),
                    if (Utils.textNotNull(progressJournalGoal.description))
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 6.0, top: 6, bottom: 6),
                        child: MyText(
                          progressJournalGoal.description!,
                          maxLines: 99,
                          decoration:
                              isComplete ? TextDecoration.lineThrough : null,
                          size: FONTSIZE.SMALL,
                        ),
                      ),
                    if (progressJournalGoal.progressJournalGoalTags.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: progressJournalGoal.progressJournalGoalTags
                              .map((tag) => Tag(
                                    tag: tag.tag,
                                    color: HexColor.fromHex(tag.hexColor),
                                    fontSize: FONTSIZE.TINY,
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        isComplete
                            ? CupertinoIcons.checkmark_alt_circle_fill
                            : CupertinoIcons.circle,
                        size: 40,
                      ),
                      onPressed: () => print('toggle complete'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
