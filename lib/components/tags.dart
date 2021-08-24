import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class Tag extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String tag;
  final Widget? prefix;
  final Widget? suffix;
  final FONTSIZE fontSize;
  final FontWeight fontWeight;
  final bool withBorder;
  final EdgeInsets padding;
  Tag(
      {this.color,
      this.textColor,
      required this.tag,
      this.prefix,
      this.suffix,
      this.withBorder = false,
      this.padding = kDefaultTagPadding,
      this.fontWeight = FontWeight.bold,
      this.fontSize = FONTSIZE.TINY});

  @override
  Widget build(BuildContext context) {
    final _color = color ?? context.theme.primary.withOpacity(0.95);
    final _textColor = textColor ?? context.theme.background;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _color,
          border: withBorder ? Border.all(color: context.theme.primary) : null),
      child: MyText(
        tag,
        size: fontSize,
        weight: fontWeight,
        color: _textColor,
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
          border: Border.all(color: context.theme.primary.withOpacity(0.7)),
          color: Styles.grey,
          borderRadius: BorderRadius.circular(60)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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

  DifficultyLevelTag(
    this.difficultyLevel,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
          border: difficultyLevel == DifficultyLevel.elite
              ? Border.all(color: Styles.white)
              : null,
          borderRadius: BorderRadius.circular(30),
          color: difficultyLevel.displayColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyHeaderText(
            difficultyLevel.display.toUpperCase(),
            size: FONTSIZE.TINY,
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
  final String name;
  final int? timecap; // Seconds
  final FONTSIZE fontSize;
  final bool hasClassVideo;
  final bool hasClassAudio;
  WorkoutSectionTypeTag(this.name,
      {this.timecap,
      this.fontSize = FONTSIZE.SMALL,
      this.hasClassVideo = false,
      this.hasClassAudio = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: context.theme.primary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                name,
                lineHeight: 1.2,
                size: fontSize,
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
              if (timecap != null)
                MyText(
                  ' - ${(timecap! / 60).round()} mins',
                  lineHeight: 1.2,
                  size: fontSize,
                  textAlign: TextAlign.center,
                  weight: FontWeight.bold,
                ),
              if (hasClassVideo)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    CupertinoIcons.film_fill,
                    size: 16,
                  ),
                ),
              if (hasClassAudio)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    CupertinoIcons.volume_up,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
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
