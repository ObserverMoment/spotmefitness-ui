import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_details_editable.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/nav_bar_ellipsis_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class LoggedWorkoutDetailsPage extends StatelessWidget {
  final String id;
  LoggedWorkoutDetailsPage({@PathParam('id') required this.id});
  @override
  Widget build(BuildContext context) {
    final query =
        LoggedWorkoutByIdQuery(variables: LoggedWorkoutByIdArguments(id: id));

    return QueryObserver<LoggedWorkoutById$Query, LoggedWorkoutByIdArguments>(
        key: Key('LoggedWorkoutDetailsPage - ${query.operationName}'),
        query: query,
        parameterizeQuery: true,
        builder: (data) {
          final log = data.loggedWorkoutById;

          final sortedSections =
              log.loggedWorkoutSections.sortedBy<num>((s) => s.sectionIndex);

          return ChangeNotifierProvider(
            create: (context) =>
                LoggedWorkoutCreatorBloc(initialLoggedWorkout: log),
            builder: (context, child) => CupertinoPageScaffold(
              navigationBar: BasicNavBar(
                middle: NavBarTitle(log.name),
                trailing: NavBarEllipsisMenu(
                  items: [],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.separated(
                  itemCount: sortedSections.length,
                  separatorBuilder: (_, __) => HorizontalLine(),
                  itemBuilder: (c, i) =>
                      LoggedWorkoutSectionSummary(sortedSections[i]),
                ),
              ),
            ),
          );
        });
  }
}

class LoggedWorkoutSectionSummary extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  LoggedWorkoutSectionSummary(this.loggedWorkoutSection);
  @override
  Widget build(BuildContext context) {
    Set<BodyArea> bodyAreas = {};
    Set<MoveType> moveTypes = {};

    for (final workoutSet in loggedWorkoutSection.loggedWorkoutSets) {
      for (final workoutMove in workoutSet.loggedWorkoutMoves) {
        bodyAreas.addAll(workoutMove.move.bodyAreaMoveScores
            .map((bams) => bams.bodyArea)
            .toList());
        moveTypes.add(workoutMove.move.moveType);
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
          builder: (c) => ChangeNotifierProvider.value(
              value: context.read<LoggedWorkoutCreatorBloc>(),
              child: LoggedWorkoutSectionDetailsEditable(
                  loggedWorkoutSection: loggedWorkoutSection,
                  uniqueBodyAreas: bodyAreas.toList())))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LoggedWorkoutSectionSummaryTag(
              loggedWorkoutSection,
              fontsize: FONTSIZE.MAIN,
            ),
            if (Utils.textNotNull(loggedWorkoutSection.name))
              H3('"${loggedWorkoutSection.name!}"'),
            if (Utils.textNotNull(loggedWorkoutSection.note))
              MyText(loggedWorkoutSection.note!),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    ...moveTypes
                        .map((moveType) => Tag(
                              tag: moveType.name,
                              withBorder: true,
                              color: context.theme.background,
                              textColor: context.theme.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
                            ))
                        .toList(),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    ...bodyAreas
                        .map((bodyArea) => Tag(
                            tag: bodyArea.name,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4)))
                        .toList(),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
