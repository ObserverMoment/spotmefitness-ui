import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';

/// Box with rounded corners. No elevation.
class RoundedBox extends StatelessWidget {
  final Widget child;
  final bool border;
  final EdgeInsets margin;
  RoundedBox(
      {required this.child,
      this.border = false,
      this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: border
              ? Border.all(
                  color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                      ? CupertinoColors.white
                      : CupertinoColors.black)
              : null),
      child: child,
    );
  }
}

/// Box with rounded corners. No elevation.
class CircularBox extends StatelessWidget {
  final Widget child;
  final bool border;
  CircularBox({required this.child, this.border = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: border
              ? Border.all(
                  color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                      ? CupertinoColors.white
                      : CupertinoColors.black)
              : null),
      child: child,
    );
  }
}

/// A stack which expands to fill available space with a floating action button in the bottom right.
/// Receives a single child and specs for the button.
/// At least one of [buttonIcon] and [buttonText] must not be null.
class StackAndFloatingButton extends StatelessWidget {
  final Widget child;
  final bool pageHasBottomNavBar;
  final IconData buttonIconData;
  final void Function() onPressed;
  StackAndFloatingButton(
      {required this.child,
      this.pageHasBottomNavBar = true,
      required this.buttonIconData,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
            bottom: pageHasBottomNavBar ? 78 : 10,
            right: 6,
            child:
                RoundIconButton(iconData: buttonIconData, onPressed: onPressed))
      ],
    );
  }
}
