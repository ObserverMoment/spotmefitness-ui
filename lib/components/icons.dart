import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';

class WorkoutSectionTypeTag extends StatelessWidget {
  final String name;
  final int? timecap; // Seconds
  WorkoutSectionTypeTag(this.name, {this.timecap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Styles.colorOne),
      child: Row(
        children: [
          MyText(
            name,
            weight: FontWeight.bold,
            lineHeight: 1.15,
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
    final _color = color ?? context.theme.primary;
    final _textColor = textColor ?? context.theme.background;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 18,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: _color),
      child: Center(
        child: MyText(
          tag,
          size: FONTSIZE.TINY,
          weight: FontWeight.bold,
          color: _textColor,
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
