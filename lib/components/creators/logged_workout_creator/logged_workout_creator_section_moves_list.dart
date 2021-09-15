import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/comma_separated_list_generator.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

/// Editable moves list _ lap / split times.
class LoggedWorkoutCreatorSectionMovesList extends StatelessWidget {
  final int sectionIndex;
  const LoggedWorkoutCreatorSectionMovesList(
      {Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Brute force bloc listener - will cause rebuild whenever bloc calls notifyListeners.
    /// Could not make [select<>()] workout because LoggedWorkoutSection extends Equatable and Equatable was not noticing differences to nested fields within [LoggedWorkoutSectionData] object (i.e. rounds and sets).
    final loggedWorkoutSection = context
        .watch<LoggedWorkoutCreatorBloc>()
        .loggedWorkout
        .loggedWorkoutSections[sectionIndex];

    final roundData =
        loggedWorkoutSection.loggedWorkoutSectionData?.rounds ?? [];

    return MyPageScaffold(
      navigationBar: MyNavBar(
        middle: NavBarTitle('Moves List and Lap Times'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  loggedWorkoutSection.workoutSectionType.name,
                  size: FONTSIZE.LARGE,
                ),
                ContentBox(
                  padding: EdgeInsets.zero,
                  backgroundColor: context.theme.cardBackground,
                  child: DurationPickerDisplay(
                      modalTitle: 'Time Taken',
                      duration: Duration(
                          seconds: loggedWorkoutSection.timeTakenSeconds),
                      updateDuration: (duration) => context
                          .read<LoggedWorkoutCreatorBloc>()
                          .updateTimeTakenSeconds(
                              loggedWorkoutSection.sortPosition,
                              duration.inSeconds)),
                )
              ],
            ),
          ),
          HorizontalLine(),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: roundData.length,
                itemBuilder: (c, i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: _SingleRoundData(
                          sectionIndex: loggedWorkoutSection.sortPosition,
                          roundIndex: i,
                          roundData: roundData[i]),
                    )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CreateTextIconButton(
                  text: 'Add Round',
                  onPressed: () => context
                      .read<LoggedWorkoutCreatorBloc>()
                      .addRoundToSection(
                        loggedWorkoutSection.sortPosition,
                      )),
            ],
          ),
        ],
      ),
    );
  }
}

class _SingleRoundData extends StatelessWidget {
  final int sectionIndex;
  final int roundIndex;
  final WorkoutSectionRoundData roundData;
  const _SingleRoundData(
      {Key? key,
      required this.roundData,
      required this.sectionIndex,
      required this.roundIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoggedWorkoutCreatorBloc>();
    return ContentBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText('ROUND ${roundIndex + 1}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MiniDurationPickerDisplay(
                  duration: Duration(seconds: roundData.timeTakenSeconds),
                  updateDuration: (d) => bloc.updateRoundTimeTakenSeconds(
                      sectionIndex: sectionIndex,
                      roundIndex: roundIndex,
                      seconds: d.inSeconds),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.only(left: 8),
                  onPressed: () =>
                      bloc.removeRoundFromSection(sectionIndex, roundIndex),
                  child: Icon(
                    CupertinoIcons.delete_simple,
                    size: 20,
                  ),
                )
              ],
            ),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: roundData.sets.length,
            itemBuilder: (c, i) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.push(
                      child: CommaSeparatedListGenerator(
                          title: 'Set Moves',
                          list: roundData.sets[i].moves,
                          updateList: (moves) => bloc.updateSetMovesList(
                              sectionIndex: sectionIndex,
                              roundIndex: roundIndex,
                              setIndex: i,
                              moves: moves))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: context.theme.background
                                    .withOpacity(0.7)))),
                    child: _SingleSetData(
                        index: i,
                        setData: roundData.sets[i],
                        updateDuration: (d) => bloc.updateSetTimeTakenSeconds(
                            sectionIndex: sectionIndex,
                            roundIndex: roundIndex,
                            setIndex: i,
                            seconds: d.inSeconds),
                        removeSetFromRound: () =>
                            bloc.removeSetFromSectionRound(
                                sectionIndex, roundIndex, i)),
                  ),
                )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CreateTextIconButton(
              text: 'Add Set',
              onPressed: () => context
                  .read<LoggedWorkoutCreatorBloc>()
                  .addSetToSectionRound(sectionIndex, roundIndex),
            ),
          ],
        ),
      ]),
    );
  }
}

class _SingleSetData extends StatelessWidget {
  final int index;
  final WorkoutSectionRoundSetData setData;
  final void Function(Duration duration) updateDuration;
  final VoidCallback removeSetFromRound;
  const _SingleSetData(
      {Key? key,
      required this.index,
      required this.setData,
      required this.updateDuration,
      required this.removeSetFromRound})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movesList = setData.moves.split(',');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: movesList
              .map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: MyText(m),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MiniDurationPickerDisplay(
              duration: Duration(seconds: setData.timeTakenSeconds),
              updateDuration: updateDuration,
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: removeSetFromRound,
              child: Icon(
                CupertinoIcons.delete_simple,
                size: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class MiniDurationPickerDisplay extends StatelessWidget {
  final Duration duration;
  final void Function(Duration duration) updateDuration;
  const MiniDurationPickerDisplay(
      {Key? key, required this.duration, required this.updateDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => context.showActionSheetPopup(
                child: DurationPicker(
              duration: duration,
              updateDuration: updateDuration,
              title: 'Time Taken',
            )),
        child: ContentBox(
          backgroundColor: context.theme.background,
          child: MyText(duration.compactDisplay()),
        ));
  }
}
