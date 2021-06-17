import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ProgressJournalGoalCard extends StatelessWidget {
  final ProgressJournalGoal progressJournalGoal;
  final void Function(ProgressJournalGoal goal) markGoalComplete;
  ProgressJournalGoalCard(
      {required this.progressJournalGoal, required this.markGoalComplete});

  Future<void> _toggleComplete(BuildContext context) async {
    if (progressJournalGoal.completedDate == null) {
      _markComplete(context);
    } else {
      _markIncomplete(context);
    }
  }

  Future<void> _markComplete(BuildContext context) async {
    final result = await context.showBottomSheet<MutationResult>(
        expand: false,
        child: _MarkGoalCompletedBottomSheet(progressJournalGoal));

    /// If null or some other value then the modal has just been closed with no action.
    if (result is MutationResult) {
      _checkResult(context, result);
    }
  }

  Future<void> _markIncomplete(BuildContext context) async {
    context.showConfirmDialog(
        title: 'Mark Incomplete?',
        onConfirm: () async {
          final updated =
              ProgressJournalGoal.fromJson(progressJournalGoal.toJson());
          updated.completedDate = null;

          final variables = UpdateProgressJournalGoalArguments(
              data: UpdateProgressJournalGoalInput.fromJson(updated.toJson()));

          final result = await context.graphQLStore.mutate(
              mutation: UpdateProgressJournalGoalMutation(variables: variables),
              optimisticData: updated.toJson(),
              broadcastQueryIds: [
                /// Broadcasting the operation name with no variables (nullified or parameterized)
                /// This will trigger all observerable queries with [progressJournalByIdQuery] keys to rebuild.
                GQLOpNames.progressJournalByIdQuery,
                UserProgressJournalsQuery().operationName
              ]);
          _checkResult(context, result);
        });
  }

  void _checkResult(BuildContext context, MutationResult? result) {
    if (result?.data == null || result!.hasErrors) {
      context.showToast(
          message: 'Sorry, there was an issue updating this goal.',
          toastType: ToastType.destructive);
    }
  }

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
                      child: AnimatedSwitcher(
                          duration: kStandardAnimationDuration,
                          child: isComplete
                              ? Icon(
                                  CupertinoIcons.checkmark_alt_circle_fill,
                                  size: 40,
                                )
                              : Icon(
                                  CupertinoIcons.circle,
                                  size: 40,
                                )),
                      onPressed: () => _toggleComplete(context))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MarkGoalCompletedBottomSheet extends StatefulWidget {
  final ProgressJournalGoal progressJournalGoal;
  _MarkGoalCompletedBottomSheet(this.progressJournalGoal);

  @override
  __MarkGoalCompletedBottomSheetState createState() =>
      __MarkGoalCompletedBottomSheetState();
}

class __MarkGoalCompletedBottomSheetState
    extends State<_MarkGoalCompletedBottomSheet> {
  DateTime _completedDate = DateTime.now();

  Future<void> _markComplete() async {
    final updated =
        ProgressJournalGoal.fromJson(widget.progressJournalGoal.toJson());
    updated.completedDate = _completedDate;

    final input = UpdateProgressJournalGoalInput.fromJson(updated.toJson());

    final variables = UpdateProgressJournalGoalArguments(data: input);

    final result = await context.graphQLStore.mutate(
        mutation: UpdateProgressJournalGoalMutation(variables: variables),
        optimisticData: updated.toJson(),
        broadcastQueryIds: [
          GQLOpNames.progressJournalByIdQuery,
          UserProgressJournalsQuery().operationName
        ]);

    context.pop(result: result);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DatePickerDisplay(
                title: 'Completed Date',
                dateTime: _completedDate,
                updateDateTime: (d) => setState(() => _completedDate = d)),
            SizedBox(height: 30),
            PrimaryButton(
                text: 'Mark Complete',
                prefix: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: Styles.infoBlue,
                ),
                onPressed: _markComplete)
          ],
        ),
      ),
    );
  }
}
