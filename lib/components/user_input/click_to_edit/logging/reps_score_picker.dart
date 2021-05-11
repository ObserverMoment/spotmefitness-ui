import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// [T] can be a WorkoutSection or a LoggedWorkoutSection
class RepsScoreDisplay<T> extends StatelessWidget {
  final T section;
  final int? score;
  final void Function(int score) updateScore;
  RepsScoreDisplay(
      {required this.section, this.score, required this.updateScore})
      : assert(section is WorkoutSection || section is LoggedWorkoutSection,
            'section must (currently) be WorkoutSection or LoggedWorkoutSection.');
  @override
  Widget build(BuildContext context) {
    return MiniButton(
      text: score != null ? '$score reps' : 'Reps...',
      prefix: Icon(CupertinoIcons.chart_bar, size: 13),
      onPressed: () => context.showBottomSheet(
          expand: true,
          child: RepsScorePicker(
            score: score,
            section: section,
            updateScore: updateScore,
          )),
    );
  }
}

class RepsScorePicker<T> extends StatefulWidget {
  final T section;
  final int? score;
  final void Function(int score) updateScore;
  RepsScorePicker(
      {required this.section, this.score, required this.updateScore})
      : assert(section is WorkoutSection || section is LoggedWorkoutSection,
            'section must (currently) be WorkoutSection or LoggedWorkoutSection.');

  @override
  _RepsScorePickerState<T> createState() => _RepsScorePickerState<T>();
}

class _RepsScorePickerState<T> extends State<RepsScorePicker<T>> {
  late int _repsPerRound;
  late TextEditingController _roundsInputController;
  late TextEditingController _repsInputController;

  @override
  void initState() {
    super.initState();
    _repsPerRound = DataUtils.totalRepsPerSectionRound<T>(widget.section);

    if (widget.score != null) {
      final rounds = widget.score! ~/ _repsPerRound;
      final reps = widget.score! - (rounds * _repsPerRound);

      _roundsInputController = TextEditingController(text: rounds.toString());
      _repsInputController = TextEditingController(text: reps.toString());
    } else {
      _roundsInputController = TextEditingController(text: '0');
      _repsInputController = TextEditingController(text: '0');
    }

    _roundsInputController.addListener(() {
      setState(() {});
    });
    _repsInputController.addListener(() {
      setState(() {});
    });

    // Auto select the rounds input.
    _roundsInputController.selection = TextSelection(
        baseOffset: 0, extentOffset: _roundsInputController.value.text.length);
  }

  int _calcTotalreps() {
    final rounds = Utils.textNotNull(_roundsInputController.text)
        ? int.parse(_roundsInputController.text)
        : 0;
    final reps = Utils.textNotNull(_repsInputController.text)
        ? int.parse(_repsInputController.text)
        : 0;
    return rounds * _repsPerRound + reps;
  }

  void _save() {
    widget.updateScore(_calcTotalreps());
    context.pop();
  }

  @override
  void dispose() {
    _roundsInputController.dispose();
    _repsInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalCupertinoPageScaffold(
      cancel: context.pop,
      title: 'Reps Score',
      save: _save,
      validToSave: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      'Full rounds',
                      size: FONTSIZE.SMALL,
                      weight: FontWeight.bold,
                    ),
                    MyText(
                      '(all reps completed)',
                      size: FONTSIZE.TINY,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: MyNumberInput(
                        _roundsInputController,
                        allowDouble: false,
                        autoFocus: true,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      'Reps from last round',
                      size: FONTSIZE.SMALL,
                      weight: FontWeight.bold,
                    ),
                    MyText(
                      '(partial round)',
                      size: FONTSIZE.TINY,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: MyNumberInput(
                        _repsInputController,
                        allowDouble: false,
                        autoFocus: false,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText('Total reps = ${_calcTotalreps()}'),
          )
        ],
      ),
    );
  }
}
