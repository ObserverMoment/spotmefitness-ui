import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class Tag extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final String tag;
  final Widget? prefix;
  final Widget? suffix;
  final FONTSIZE fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  Tag(
      {this.color,
      this.borderColor,
      this.textColor,
      required this.tag,
      this.prefix,
      this.suffix,
      this.padding = kDefaultTagPadding,
      this.fontWeight = FontWeight.normal,
      this.fontSize = FONTSIZE.SMALL});

  @override
  Widget build(BuildContext context) {
    final background = color ?? context.theme.primary.withOpacity(0.95);
    final border =
        borderColor ?? color ?? context.theme.primary.withOpacity(0.95);
    final text = textColor ?? context.theme.background;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: background,
          border: Border.all(color: border)),
      child: MyText(
        tag,
        size: fontSize,
        weight: fontWeight,
        color: text,
        lineHeight: 1.1,
      ),
    );
  }
}

class SelectableTag extends StatelessWidget {
  final bool isSelected;
  final void Function() onPressed;
  final String text;
  final Color selectedColor;
  final FONTSIZE fontSize;
  final EdgeInsets padding;
  SelectableTag(
      {required this.isSelected,
      required this.onPressed,
      required this.text,
      this.fontSize = FONTSIZE.SMALL,
      this.selectedColor = Styles.colorOne,
      this.padding = const EdgeInsets.symmetric(horizontal: 9, vertical: 7)});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: selectedColor)
                : Border.all(color: context.theme.primary.withOpacity(0.5)),
            color: isSelected ? selectedColor : context.theme.background,
            borderRadius: BorderRadius.circular(30)),
        padding: padding,
        child: MyText(
          text,
          size: fontSize,
          color: isSelected ? Styles.white : null,
          lineHeight: 1,
        ),
      ),
    );
  }
}

class MoveTypeTag extends StatelessWidget {
  final MoveType moveType;
  final FONTSIZE fontSize;
  MoveTypeTag(this.moveType, {this.fontSize = FONTSIZE.SMALL});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Styles.grey, borderRadius: BorderRadius.circular(60)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: MyText(
        moveType.name,
        size: fontSize,
      ),
    );
  }
}

class DifficultyLevelDot extends StatelessWidget {
  final DifficultyLevel difficultyLevel;
  DifficultyLevelDot(
    this.difficultyLevel,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
          border: difficultyLevel == DifficultyLevel.elite
              ? Border.all(color: Styles.white, width: 1)
              : null,
          shape: BoxShape.circle,
          color: difficultyLevel.displayColor),
    );
  }
}

class DifficultyLevelTag extends StatelessWidget {
  final DifficultyLevel difficultyLevel;
  final FONTSIZE fontSize;

  DifficultyLevelTag(this.difficultyLevel, {this.fontSize = FONTSIZE.SMALL});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kDefaultTagPadding,
      decoration: BoxDecoration(
          border: difficultyLevel == DifficultyLevel.elite
              ? Border.all(color: Styles.white.withOpacity(0.8))
              : null,
          borderRadius: BorderRadius.circular(4),
          color: difficultyLevel.displayColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(
            difficultyLevel.display.toUpperCase(),
            size: fontSize,
            color: Styles.white,
            weight: FontWeight.bold,
            lineHeight: 1.2,
          ),
        ],
      ),
    );
  }
}

class WorkoutSectionTypeTag extends StatelessWidget {
  final WorkoutSection workoutSection;
  final FONTSIZE fontSize;
  final Color? fontColor;
  final bool uppercase;
  WorkoutSectionTypeTag(
      {required this.workoutSection,
      this.fontSize = FONTSIZE.SMALL,
      this.fontColor,
      this.uppercase = false});

  @override
  Widget build(BuildContext context) {
    final timecapOrTotalDuration = workoutSection.timecapIfValid;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: kStandardCardPadding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.theme.background,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                uppercase
                    ? workoutSection.workoutSectionType.name.toUpperCase()
                    : workoutSection.workoutSectionType.name,
                size: fontSize,
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
                color: fontColor,
              ),
              if (timecapOrTotalDuration != null)
                MyText(
                  ' - ${(timecapOrTotalDuration / 60).round()} mins',
                  size: fontSize,
                  textAlign: TextAlign.center,
                  weight: FontWeight.bold,
                  color: fontColor,
                ),
              if (Utils.textNotNull(workoutSection.classVideoUri))
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    CupertinoIcons.film_fill,
                    size: 16,
                    color: fontColor,
                  ),
                ),
              if (Utils.textNotNull(workoutSection.classAudioUri))
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    CupertinoIcons.volume_up,
                    size: 16,
                    color: fontColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class LoggedWorkoutSectionSummaryTag extends StatelessWidget {
  final LoggedWorkoutSection section;
  final FONTSIZE fontSize;
  final FontWeight fontWeight;
  LoggedWorkoutSectionSummaryTag(
    this.section, {
    this.fontSize = FONTSIZE.SMALL,
    this.fontWeight = FontWeight.normal,
  });

  int? get _repsScore => section.repScore ?? null;

  Widget _text(String t) => MyText(t, size: fontSize, weight: fontWeight);

  List<Widget> _build() {
    final time = section.timeTakenSeconds;

    /// User does not have to enter a rep score for timed workouts - so it may be null.
    /// If it is null then just display the length of the workout section.
    if (section.workoutSectionType.isTimed) {
      return [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: _text(Duration(seconds: time).compactDisplay()),
        )
      ];
    } else if (section.workoutSectionType.isScored) {
      return [
        SizedBox(width: 4),
        _text('${_repsScore ?? 0} reps'),
        _text(' in '),
        _text(Duration(seconds: time).compactDisplay())
      ];
    } else {
      return [
        SizedBox(width: 4),
        _text('for '),
        _text(Duration(seconds: time).compactDisplay())
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: kStandardCardPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.theme.background,
              borderRadius: BorderRadius.circular(4),
            ),
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
            )),
      ],
    );
  }
}

class DurationTag extends StatelessWidget {
  final Duration duration;
  final FONTSIZE fontSize;
  final double iconSize;
  final Color? backgroundColor;
  final Color? textColor;
  const DurationTag(
      {Key? key,
      required this.duration,
      this.fontSize = FONTSIZE.SMALL,
      this.iconSize = 13,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentBox(
        backgroundColor: backgroundColor,
        borderRadius: 4,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.timer, size: iconSize),
            SizedBox(width: 4),
            MyText(duration.displayString, size: fontSize, color: textColor),
          ],
        ));
  }
}

class ProgressJournalGoalAndTagsTag extends StatelessWidget {
  final ProgressJournalGoal progressJournalGoal;
  ProgressJournalGoalAndTagsTag(this.progressJournalGoal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.theme.primary)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            progressJournalGoal.name,
            size: FONTSIZE.SMALL,
            decoration: progressJournalGoal.completedDate != null
                ? TextDecoration.lineThrough
                : null,
          ),
          if (progressJournalGoal.progressJournalGoalTags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: progressJournalGoal.progressJournalGoalTags
                    .map((t) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Dot(
                              diameter: 10,
                              color: HexColor.fromHex(t.hexColor)),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
