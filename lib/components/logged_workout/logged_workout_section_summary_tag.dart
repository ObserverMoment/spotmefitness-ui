import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';

class LoggedWorkoutSectionSummaryTag extends StatelessWidget {
  final LoggedWorkoutSection section;
  LoggedWorkoutSectionSummaryTag(this.section);

  /// The number of reps as specified by the workout plan. For AMRAPs etc use [repsScore].
  int _reps() =>
      DataUtils.totalRepsPerSectionRound<LoggedWorkoutSection>(section) *
      section.roundsCompleted;

  int? _repsScore() => section.repScore ?? null;

  Widget _text(String t) => MyText(
        t,
        size: FONTSIZE.SMALL,
      );

  List<Widget> _build() {
    final time = section.timeTakenMs != null
        ? section.timeTakenMs! ~/ 1000
        : section.timecap ?? null;

    switch (section.workoutSectionType.name) {
      case kLastStandingName:
      case kAMRAPName:
        return [
          _text('${_repsScore() ?? _reps()} reps'),
          if (time != null) _text(' in '),
          if (time != null) _text(Duration(seconds: time).compactDisplay())
        ];
      case kFreeSessionName:
      case kForTimeName:
        return [
          MyText('${_reps()} reps'),
          if (time != null) _text(' in '),
          if (time != null) _text(Duration(seconds: time).compactDisplay())
        ];
      case kEMOMName:
      case kHIITCircuitName:
      case kTabataName:
        return [
          if (time != null) _text(Duration(seconds: time).compactDisplay())
        ];
      default:
        throw Exception(
            'LoggedWorkoutSectionSummaryTag._build: No builder for ${section.workoutSectionType.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: context.theme.primary)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              '${section.workoutSectionType.name} ',
              size: FONTSIZE.SMALL,
              color: Styles.colorTwo,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: _build(),
            )
          ],
        ));
  }
}
