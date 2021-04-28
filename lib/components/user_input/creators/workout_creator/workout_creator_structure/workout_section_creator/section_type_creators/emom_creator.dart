import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_emom_set_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

/// [emom] section has rounds but no timecap (it is a non competitive timed workout)
/// [lastOneStanding]  section has timecap but no rounds (it is a competitive, potentially open ended workout - i.e. the timecap is optional).
enum EMOMCreatorType { emom, lastOneStanding }

/// Used for creating [EMOM], [Last One Standing].
class EMOMCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final int totalRounds;
  final int? timecap;
  final void Function(Map<String, dynamic> defaults) createSet;
  final EMOMCreatorType creatorType;
  EMOMCreator(
      {required this.sortedWorkoutSets,
      required this.totalRounds,
      required this.sectionIndex,
      this.timecap,
      required this.creatorType,
      required this.createSet});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(shrinkWrap: true, children: [
        ImplicitlyAnimatedList<WorkoutSet>(
          items: sortedWorkoutSets,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          areItemsTheSame: (a, b) => a.id == b.id,
          itemBuilder: (context, animation, item, index) {
            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                child: WorkoutEMOMSetCreator(
                    key: Key('emom_creator-$sectionIndex-${item.sortPosition}'),
                    sectionIndex: sectionIndex,
                    setIndex: item.sortPosition,
                    allowReorder: sortedWorkoutSets.length > 1),
              ),
            );
          },
        ),
        if (sortedWorkoutSets.isNotEmpty &&
            creatorType == EMOMCreatorType.emom &&
            totalRounds > 1)
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    'Then repeat all the above $totalRounds times.',
                    color: Styles.infoBlue,
                    weight: FontWeight.bold,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        if (sortedWorkoutSets.isNotEmpty &&
            creatorType == EMOMCreatorType.lastOneStanding &&
            timecap != null)
          FadeIn(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyText(
                      'Then repeat all the above for ${timecap!.secondsToTimeDisplay()}...if you can!',
                      color: Styles.infoBlue,
                      weight: FontWeight.bold,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                text: 'Add Period',
                loading: context
                    .select<WorkoutCreatorBloc, bool>((b) => b.creatingSet),
                onPressed: () => createSet({'duration': 60}),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
