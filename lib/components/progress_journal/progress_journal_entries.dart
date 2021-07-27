import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/animated_slidable.dart';
import 'package:spotmefitness_ui/components/cards/progress_journal_entry_card.dart';
import 'package:spotmefitness_ui/components/creators/progress_journal/progress_journal_entry_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

class ProgressJournalEntries extends StatelessWidget {
  final String parentJournalId;
  final List<ProgressJournalEntry> entries;
  ProgressJournalEntries(
      {required this.entries, required this.parentJournalId});

  Future<void> _deleteJournalEntry(BuildContext context, String id) async {
    final variables = DeleteProgressJournalEntryByIdArguments(id: id);

    final result = await context.graphQLStore.delete(
        mutation: DeleteProgressJournalEntryByIdMutation(variables: variables),
        objectId: id,
        typename: kProgressJournalEntryTypename,
        broadcastQueryIds: [
          GQLVarParamKeys.progressJournalByIdQuery(parentJournalId),
          GQLOpNames.userProgressJournalsQuery,
        ],
        removeAllRefsToId: true);

    if (result.hasErrors || result.data?.deleteProgressJournalEntryById != id) {
      context.showToast(
          message: 'Sorry, there was a problem deleting this entry.',
          toastType: ToastType.destructive);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedEntries =
        entries.sortedBy<DateTime>((e) => e.createdAt).reversed.toList();

    return StackAndFloatingButton(
      onPressed: () => context.push(
          child: ProgressJournalEntryCreator(
        parentJournalId: parentJournalId,
      )),
      pageHasBottomNavBar: false,
      buttonText: 'Add Entry',
      child: entries.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                'No entries yet',
                textAlign: TextAlign.center,
                subtext: true,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
              itemCount: entries.length + 1,
              itemBuilder: (c, i) {
                if (i == entries.length) {
                  return SizedBox(height: kAssumedFloatingButtonHeight);
                } else {
                  return GestureDetector(
                      onTap: () => context.push(
                              child: ProgressJournalEntryCreator(
                            parentJournalId: parentJournalId,
                            progressJournalEntry: sortedEntries[i],
                          )),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: AnimatedSlidable(
                              key: Key(
                                  'progress-journal-entry-${sortedEntries[i].id}'),
                              index: i,
                              itemType: 'Journal Entry',
                              itemName: sortedEntries[i].createdAt.dateString,
                              removeItem: (index) => _deleteJournalEntry(
                                  context, sortedEntries[i].id),
                              secondaryActions: [],
                              child:
                                  ProgressJournalEntryCard(sortedEntries[i]))));
                }
              },
            ),
    );
  }
}
