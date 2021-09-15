import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class LoggedWorkoutSectionSummaryTag extends StatelessWidget {
  final LoggedWorkoutSection section;
  final FONTSIZE fontSize;
  final FontWeight fontWeight;
  final bool withBorder;
  LoggedWorkoutSectionSummaryTag(this.section,
      {this.fontSize = FONTSIZE.SMALL,
      this.fontWeight = FontWeight.normal,
      this.withBorder = true});

  int? get _repsScore => section.repScore ?? null;

  Widget _text(String t) => MyText(t, size: fontSize, weight: fontWeight);

  List<Widget> _build() {
    final time = section.timeTakenSeconds;

    /// User does not have to enter a rep score for timed workouts - so it may be null.
    /// If it is null then just display the length of the workout section.
    return [kEMOMName, kHIITCircuitName, kTabataName]
                .contains(section.workoutSectionType.name) &&
            _repsScore == null
        ? [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: _text(Duration(seconds: time).compactDisplay()),
            )
          ]
        : [
            SizedBox(width: 4),
            _text('${_repsScore ?? 0} reps'),
            _text(' in '),
            _text(Duration(seconds: time).compactDisplay())
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: withBorder ? kDefaultTagPadding : null,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: withBorder
                ? Border.all(color: context.theme.primary.withOpacity(0.5))
                : null),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText('${section.workoutSectionType.name}',
                size: fontSize, weight: fontWeight),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: _build(),
            )
          ],
        ));
  }
}
