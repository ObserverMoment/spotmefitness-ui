import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/logged_workout/logged_workout_section_summary_tag.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Editable moves list _ lap / split times.
class LoggedWorkoutCreatorSectionDetails extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  const LoggedWorkoutCreatorSectionDetails(
      {Key? key, required this.loggedWorkoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: LoggedWorkoutSectionSummaryTag(
              loggedWorkoutSection,
              withBorder: false,
              fontSize: FONTSIZE.LARGE,
            ),
          ),
          HorizontalLine(),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: roundData.length,
                itemBuilder: (c, i) =>
                    _SingleRoundData(index: i, roundData: roundData[i])),
          ),
        ],
      ),
    );
  }
}

class _SingleRoundData extends StatelessWidget {
  final int index;
  final WorkoutSectionRoundData roundData;
  const _SingleRoundData(
      {Key? key, required this.roundData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText('ROUND ${index + 1}'),
            MiniDurationPickerDisplay(
              duration: Duration(seconds: roundData.timeTakenSeconds),
              updateDuration: (d) => print(d),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: roundData.sets.length,
              itemBuilder: (c, i) => _SingleSetData(
                    index: i,
                    setData: roundData.sets[i],
                  )),
        )
      ]),
    );
  }
}

class _SingleSetData extends StatelessWidget {
  final int index;
  final WorkoutSectionRoundSetData setData;
  const _SingleSetData({Key? key, required this.index, required this.setData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movesList = setData.moves.split(',');
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MyText('SET ${index + 1}'),
              if (movesList.length > 1)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MyText(
                    'SUPERSET',
                    color: Styles.colorTwo,
                    size: FONTSIZE.TINY,
                  ),
                ),
            ],
          ),
          MiniDurationPickerDisplay(
            duration: Duration(seconds: setData.timeTakenSeconds),
            updateDuration: (d) => print(d),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: movesList
              .map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: MyText(m),
                ),
              )
              .toList(),
        ),
      )
    ]);
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
