import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class Tag extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String tag;
  final Widget? prefix;
  final Widget? suffix;
  final FONTSIZE fontSize;
  final bool withBorder;
  Tag(
      {this.color,
      this.textColor,
      required this.tag,
      this.prefix,
      this.suffix,
      this.withBorder = false,
      this.fontSize = FONTSIZE.TINY});
  @override
  Widget build(BuildContext context) {
    final _color = color ?? context.theme.primary.withOpacity(0.85);
    final _textColor = textColor ?? context.theme.background;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _color,
          border: withBorder ? Border.all(color: context.theme.primary) : null),
      child: MyText(
        tag,
        size: fontSize,
        weight: FontWeight.bold,
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
  SelectableTag(
      {required this.isSelected, required this.onPressed, required this.text});
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
                ? Border.all(color: Styles.colorOne)
                : Border.all(color: context.theme.primary.withOpacity(0.5)),
            color: isSelected ? Styles.colorOne : context.theme.background,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: MyText(
          text,
          size: FONTSIZE.SMALL,
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
          border: Border.all(color: context.theme.primary.withOpacity(0.4)),
          color: Styles.grey,
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: MyText(
        moveType.name,
        size: fontSize,
        color: Styles.white,
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 24,
      decoration: BoxDecoration(
          border: difficultyLevel == DifficultyLevel.elite
              ? Border.all(color: Styles.white)
              : null,
          borderRadius: BorderRadius.circular(30),
          color: difficultyLevel.displayColor),
      child: Center(
        child: MyText(
          difficultyLevel.display,
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
          color: Styles.white,
          lineHeight: 1.1,
        ),
      ),
    );
  }
}

class WorkoutSectionTypeTag extends StatelessWidget {
  final String name;
  final int? timecap; // Seconds
  WorkoutSectionTypeTag(this.name, {this.timecap});
  @override
  Widget build(BuildContext context) {
    final Color _color = context.theme.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Styles.grey,
            border: Border.all(width: 1.5, color: _color.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                name,
                weight: FontWeight.bold,
                lineHeight: 1.2,
                size: FONTSIZE.SMALL,
                color: _color,
                textAlign: TextAlign.center,
              ),
              if (timecap != null)
                MyText(
                  ' - ${timecap! ~/ 60} mins',
                  weight: FontWeight.bold,
                  lineHeight: 1.15,
                  size: FONTSIZE.SMALL,
                  color: _color,
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ),
      ],
    );
  }
}
