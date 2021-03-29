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
class StackAndFloatingButton extends StatelessWidget {
  final Widget child;
  StackAndFloatingButton({required this.child});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print(constraints.maxHeight);
      print(constraints.biggest);
      return Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(width: constraints.maxWidth, child: child),
            Positioned(
                bottom: 200,
                right: 0,
                child: PrimaryButton(
                    text: 'Floating', onPressed: () => print('floating')))
          ],
        ),
      );
    });
  }
}
