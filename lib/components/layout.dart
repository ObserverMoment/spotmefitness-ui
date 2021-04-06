import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
        Padding(
          /// Padding allow content to scroll up and clear floating button.
          padding: const EdgeInsets.only(bottom: 54.0),
          child: child,
        ),
        Positioned(
            bottom: pageHasBottomNavBar ? 72 : 8,
            right: 0,
            child:
                RoundIconButton(iconData: buttonIconData, onPressed: onPressed))
      ],
    );
  }
}

/// Extends CupertinoNavigationBar with some defaults and extra options.
// For use on pages where user is either creating or editing an object.
class CreateEditPageNavBar extends CupertinoNavigationBar {
  final String title;
  final bool formIsDirty;
  final Function() handleUndo;
  final Function() handleSave;
  final Function() handleClose;
  final bool inputValid;
  CreateEditPageNavBar(
      {required this.title,
      required this.formIsDirty,
      required this.handleUndo,
      required this.handleSave,
      required this.handleClose,
      required this.inputValid})
      : super(
            leading: Align(
                alignment: Alignment.centerLeft, child: NavBarTitle(title)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (formIsDirty)
                  FadeIn(
                    child: TextButton(
                        destructive: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        text: 'Undo all',
                        underline: false,
                        onPressed: handleUndo),
                  ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: inputValid
                      ? TextButton(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          confirm: true,
                          underline: false,
                          text: 'Save',
                          onPressed: handleSave)
                      : TextButton(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          underline: false,
                          text: 'Close',
                          onPressed: handleClose),
                ),
                TextButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    underline: false,
                    text: 'Close',
                    onPressed: handleClose),
              ],
            ));
}

class HorizontalLine extends StatelessWidget {
  final double thickness;
  final Color? color;
  final double verticalPadding;
  HorizontalLine({this.thickness = 1, this.color, this.verticalPadding = 4.0});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: thickness,
                color: color ?? context.theme.primary.withOpacity(0.2)),
          ),
        ],
      ),
    );
  }
}
