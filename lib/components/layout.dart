import 'package:flutter/cupertino.dart';

/// Box with rounded corners. No elevation.
class RoundedBox extends StatelessWidget {
  final Widget child;
  final bool border;
  RoundedBox({required this.child, this.border = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
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
