import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutSectionTypeTag extends StatelessWidget {
  final String name;
  final int? timecap; // Seconds
  WorkoutSectionTypeTag(this.name, {this.timecap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: context.theme.primary),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                name,
                weight: FontWeight.bold,
                lineHeight: 1.2,
                size: FONTSIZE.SMALL,
                color: Styles.white,
                textAlign: TextAlign.center,
              ),
              if (timecap != null)
                MyText(
                  ' - ${timecap! ~/ 60} mins',
                  weight: FontWeight.bold,
                  lineHeight: 1.15,
                  size: FONTSIZE.SMALL,
                  color: Styles.white,
                  textAlign: TextAlign.center,
                )
            ],
          ),
        ),
      ],
    );
  }
}

class Tag extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String tag;
  final Widget? prefix;
  final Widget? suffix;
  Tag(
      {this.color,
      this.textColor,
      required this.tag,
      this.prefix,
      this.suffix});
  @override
  Widget build(BuildContext context) {
    final _color = color ?? context.theme.primary.withOpacity(0.85);
    final _textColor = textColor ?? context.theme.background;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: _color),
      child: MyText(
        tag,
        size: FONTSIZE.TINY,
        weight: FontWeight.bold,
        color: _textColor,
        lineHeight: 1.1,
      ),
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

class ConfirmCheckIcon extends StatelessWidget {
  final double? size;
  ConfirmCheckIcon({this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(CupertinoIcons.checkmark_alt,
        color: Styles.infoBlue, size: size);
  }
}

class CompactTimeIcon extends StatelessWidget {
  final Duration duration;
  CompactTimeIcon(this.duration);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CupertinoIcons.stopwatch),
        SizedBox(
          width: 4,
        ),
        MyText(duration.compactDisplay())
      ],
    );
  }
}

class NumberRoundsIcon extends StatelessWidget {
  final int rounds;
  NumberRoundsIcon(this.rounds);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(CupertinoIcons.arrow_2_circlepath),
        SizedBox(
          width: 6,
        ),
        MyText(
          '$rounds rounds',
          weight: FontWeight.bold,
        )
      ],
    );
  }
}
