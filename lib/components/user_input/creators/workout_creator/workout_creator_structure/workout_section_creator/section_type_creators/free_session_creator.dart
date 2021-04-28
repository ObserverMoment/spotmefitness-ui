import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/workout_set_type_creators/workout_set_creator.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

enum FreeSessionCreatorType { freeSession, forTime, amrap }

/// Used for creating [Free Session], [For Time], [AMRAP].
/// Completely open - user can create more or less anything.
class FreeSessionCreator extends StatelessWidget {
  final int sectionIndex;
  final List<WorkoutSet> sortedWorkoutSets;
  final void Function() createSet;
  final FreeSessionCreatorType freeSessionCreatorType;
  final int totalRounds;
  final int? timecap;

  FreeSessionCreator(
      {required this.sortedWorkoutSets,
      required this.sectionIndex,
      required this.createSet,
      required this.totalRounds,
      this.timecap,
      required this.freeSessionCreatorType})
      : assert(freeSessionCreatorType != FreeSessionCreatorType.amrap ||
            timecap != null);

  String _getRoundsText() => '$totalRounds time${totalRounds == 1 ? "" : "s"}';

  String _getInstructionText() {
    if (freeSessionCreatorType == FreeSessionCreatorType.amrap) {
      return 'Repeat all the above as many times as possible in ${timecap!.secondsToTimeDisplay()}';
    } else if (freeSessionCreatorType == FreeSessionCreatorType.forTime) {
      return 'Repeat all the above ${_getRoundsText()} as quickly as possible';
    } else {
      return 'Repeat all the above ${_getRoundsText()}';
    }
  }

  /// Shows instruction at the end of the lists of moves with regards to how to act on them.
  Widget _buildInstructions() => FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MyText(
                  _getInstructionText(),
                  color: Styles.infoBlue,
                  weight: FontWeight.bold,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );

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
                child: WorkoutSetCreator(
                    key: Key(
                        'session_creator-$sectionIndex-${item.sortPosition}'),
                    sectionIndex: sectionIndex,
                    setIndex: item.sortPosition,
                    allowReorder: sortedWorkoutSets.length > 1),
              ),
            );
          },
        ),
        if (sortedWorkoutSets.isNotEmpty) _buildInstructions(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                text: 'Add Set',
                loading: context
                    .select<WorkoutCreatorBloc, bool>((b) => b.creatingSet),
                onPressed: createSet,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
