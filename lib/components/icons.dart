import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ConfirmCheckIcon extends StatelessWidget {
  final double? size;
  ConfirmCheckIcon({this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(CupertinoIcons.checkmark_alt,
        color: Styles.infoBlue, size: size);
  }
}

class CompactTimerIcon extends StatelessWidget {
  final Duration? duration;
  final Axis? alignment;
  CompactTimerIcon(this.duration, {this.alignment = Axis.horizontal});

  List<Widget> _buildChildren() => [
        Icon(CupertinoIcons.timer),
        SizedBox(
          width: 4,
        ),
        MyText(duration?.compactDisplay() ?? '---')
      ];

  @override
  Widget build(BuildContext context) {
    return alignment == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          );
  }
}

class NumberRoundsIcon extends StatelessWidget {
  final int rounds;
  final Axis alignment;
  NumberRoundsIcon(this.rounds, {this.alignment = Axis.horizontal});

  List<Widget> _buildChildren() => [
        Icon(CupertinoIcons.arrow_2_circlepath),
        SizedBox(
          width: 6,
        ),
        MyText(
          '$rounds',
          size: FONTSIZE.BIG,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return alignment == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          );
  }
}

class NotesIcon extends StatelessWidget {
  final double? size;
  NotesIcon({this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.doc_plaintext,
      size: size ?? 26,
    );
  }
}
