import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/menus.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_move_display.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

/// Part of the workout creator suite of components.
/// Displays a workout set with user interactions cuch as
/// [delete workoutMove], [addWorkoutMove (create superset)], [reorderWorkoutMove] etc.
class WorkoutSetEditableDisplay extends StatelessWidget {
  final int sectionIndex;
  final int setIndex;
  final bool scrollable;
  WorkoutSetEditableDisplay(
      {required this.sectionIndex,
      required this.setIndex,
      this.scrollable = false});
  @override
  Widget build(BuildContext context) {
    final workoutSet = context.select<WorkoutCreatorBloc, WorkoutSet>((bloc) =>
        bloc.workoutData.workoutSections[sectionIndex].workoutSets[setIndex]);
    final List<WorkoutMove> _sortedMoves =
        workoutSet.workoutMoves.sortedBy<num>((wm) => wm.sortPosition);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                        'Repeat ${workoutSet.rounds} ${workoutSet.rounds == 1 ? "time" : "times"}'),
                    if (_sortedMoves.length > 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Tag(
                          tag: 'SUPERSET',
                          color: Styles.colorThree,
                          textColor: Styles.white,
                        ),
                      )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NavBarEllipsisMenu(items: [
                      ContextMenuItem(
                          text: 'Move up',
                          iconData: CupertinoIcons.chevron_up,
                          onTap: () => {}),
                      ContextMenuItem(
                          text: 'Move down',
                          iconData: CupertinoIcons.chevron_down,
                          onTap: () => {}),
                      ContextMenuItem(
                          text: 'Duplicate',
                          iconData: CupertinoIcons.doc_on_doc,
                          onTap: () => {}),
                      ContextMenuItem(
                        text: 'Delete',
                        iconData: CupertinoIcons.delete_simple,
                        onTap: () => {},
                        destructive: true,
                      ),
                    ])
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
              physics: scrollable ? null : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _sortedMoves.length,
              itemBuilder: (context, index) => WorkoutMoveDisplay(
                    _sortedMoves[index],
                    isLast: index == _sortedMoves.length - 1,
                  )),
          CreateTextIconButton(
            text: 'Add move',
            onPressed: () => print('open add move'),
          ),
        ],
      ),
    );
  }
}
