import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/logged_workout_creator_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/logged_workout_creator/score_inputs.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';

class RequiredUserInputs extends StatefulWidget {
  final List<WorkoutSection> workoutSections;
  const RequiredUserInputs({Key? key, required this.workoutSections})
      : super(key: key);

  @override
  _RequiredUserInputsState createState() => _RequiredUserInputsState();
}

class _RequiredUserInputsState extends State<RequiredUserInputs> {
  late LoggedWorkoutCreatorBloc _bloc;

  /// Sorted by sort order.
  late List<WorkoutSectionWithInput> _sectionsRequiringInput;

  @override
  void initState() {
    _bloc = context.read<LoggedWorkoutCreatorBloc>();

    _sectionsRequiringInput = widget.workoutSections
        .where(
            (w) => _bloc.typesInputRequired.contains(w.workoutSectionType.name))
        .sortedBy<num>((ws) => ws.sortPosition)
        .map((ws) => WorkoutSectionWithInput(workoutSection: ws))
        .toList();

    super.initState();
  }

  void _updateSectionInput(String workoutSectionId, int input) {
    setState(() {
      _sectionsRequiringInput = _sectionsRequiringInput
          .map((original) => original.workoutSection.id == workoutSectionId
              ? WorkoutSectionWithInput(
                  workoutSection: original.workoutSection, input: input)
              : original)
          .toList();
    });
  }

  bool get _validToProceed =>
      _sectionsRequiringInput.every((s) => s.input != null);

  void _generateLoggedWorkoutSections() {
    _bloc.generateLoggedWorkoutSections(_sectionsRequiringInput);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserInputContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                'Submit Scores / Times',
                size: FONTSIZE.LARGE,
              ),
              if (_validToProceed)
                FadeIn(
                    child: TextButton(
                  onPressed: _generateLoggedWorkoutSections,
                  text: 'Next',
                  color: Styles.infoBlue,
                  underline: false,
                ))
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: _sectionsRequiringInput
                .map((w) => Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ContentBox(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyHeaderText(
                            w.workoutSection.name ??
                                w.workoutSection.sortPosition.toString(),
                            lineHeight: 1.5,
                          ),
                          MyText(
                            w.workoutSection.workoutSectionType.name,
                            color: Styles.colorTwo,
                            lineHeight: 1.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                w.workoutSection.workoutSectionType.name ==
                                        kAMRAPName
                                    ? RepScoreInput(
                                        repScore: w.input,
                                        updateRepScore: (score) =>
                                            _updateSectionInput(
                                                w.workoutSection.id, score),
                                      )
                                    : TimeTakenInput(
                                        showSeconds: w.workoutSection
                                                .workoutSectionType.name ==
                                            kForTimeName,
                                        duration: w.input != null
                                            ? Duration(seconds: w.input!)
                                            : null,
                                        updateDuration: (duration) =>
                                            _updateSectionInput(
                                                w.workoutSection.id,
                                                duration.inSeconds)),
                              ],
                            ),
                          )
                        ],
                      )),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
