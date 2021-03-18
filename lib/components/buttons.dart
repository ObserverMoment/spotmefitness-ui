import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Base button class on which all other buttons are derived
class MyButton extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final Widget? suffix;
  final void Function() onPressed;
  final Color contentColor;
  final Color backgroundColor;
  final bool border;
  final bool disabled;
  final bool loading;

  MyButton(
      {this.prefix,
      required this.onPressed,
      required this.text,
      this.suffix,
      required this.contentColor,
      required this.backgroundColor,
      this.border = false,
      this.disabled = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: disabled ? 0.2 : 1,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: disabled ? null : onPressed,
        child: Container(
          height: 50,
          constraints: BoxConstraints(minWidth: 300),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
              border: border ? Border.all(color: contentColor) : null,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefix != null) prefix!,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: loading
                      ? LoadingDots(
                          color: contentColor,
                        )
                      : MyText(
                          text,
                          weight: FONTWEIGHT.BOLD,
                          color: contentColor,
                        ),
                ),
              ),
              if (suffix != null) suffix!
            ],
          ),
        ),
      ),
    );
  }
}

/// Dark theme == white BG and black content
/// Light theme == black BG and white content
class PrimaryButton extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final Widget? suffix;
  final void Function() onPressed;
  final bool disabled;
  final bool loading;

  PrimaryButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.disabled = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    final bool _isDarkTheme =
        CupertinoTheme.brightnessOf(context) == Brightness.dark;
    return MyButton(
      text: text,
      onPressed: onPressed,
      disabled: disabled,
      loading: loading,
      backgroundColor:
          _isDarkTheme ? CupertinoColors.white : CupertinoColors.black,
      contentColor:
          _isDarkTheme ? CupertinoColors.black : CupertinoColors.white,
    );
  }
}

/// Offset grey-ish BG with white content on both themes.
class SecondaryButton extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final Widget? suffix;
  final void Function() onPressed;
  final bool loading;

  SecondaryButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      prefix: prefix,
      suffix: suffix,
      text: text,
      onPressed: onPressed,
      backgroundColor: const Color(0xff262626),
      contentColor: CupertinoColors.white,
    );
  }
}

class DestructiveButton extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final Widget? suffix;
  final void Function() onPressed;
  final bool loading;

  DestructiveButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: CupertinoColors.destructiveRed,
      contentColor: CupertinoColors.white,
    );
  }
}

/// Dark theme == white border, white content
/// Light theme == black border, black content
class BorderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class HighlightOneButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton();
//   }
// }

// class HighlightTwoButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton();
//   }
// }

class TextButton extends StatelessWidget {
  final String text;
  final bool destructive;
  final void Function() onPressed;
  final bool loading;

  TextButton(
      {required this.text,
      required this.onPressed,
      this.destructive = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: loading
            ? LoadingDots()
            : MyText(text,
                weight: FONTWEIGHT.BOLD,
                decoration: TextDecoration.underline,
                color: destructive ? CupertinoColors.destructiveRed : null),
      ),
    );
  }
}
