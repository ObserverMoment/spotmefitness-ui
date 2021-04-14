import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Box with rounded corners. No elevation. Card background color.
class ContentBox extends StatelessWidget {
  final Widget child;
  ContentBox({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
          color: context.theme.cardBackground,
          borderRadius: BorderRadius.circular(6)),
      child: child,
    );
  }
}

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
          leading:
              Align(alignment: Alignment.centerLeft, child: NavBarTitle(title)),
          trailing: formIsDirty
              ? FadeIn(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          destructive: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          text: 'Undo all',
                          underline: false,
                          onPressed: handleUndo),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: inputValid
                            ? TextButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                confirm: true,
                                underline: false,
                                text: 'Save',
                                onPressed: handleSave)
                            : TextButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                underline: false,
                                text: 'Close',
                                onPressed: handleClose),
                      )
                    ],
                  ),
                )
              : TextButton(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  underline: false,
                  text: 'Close',
                  onPressed: handleClose),
        );
}

class ModalCupertinoPageScaffold extends StatelessWidget {
  /// Used for both the nav bar and the main modal.
  final Widget child;
  final String title;
  final void Function()? cancel;
  final void Function()? save;
  final bool validToSave;
  final bool resizeToAvoidBottomInset;
  ModalCupertinoPageScaffold(
      {required this.child,
      required this.title,
      required this.cancel,
      required this.save,
      this.resizeToAvoidBottomInset = false,
      this.validToSave = false});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: context.theme.modalBackground,
      navigationBar: CupertinoNavigationBar(
        leading: cancel != null ? NavBarCancelButton(cancel!) : null,
        backgroundColor: context.theme.modalBackground,
        middle: NavBarTitle(title),
        trailing: save != null && validToSave
            ? FadeIn(child: NavBarSaveButton(save!))
            : null,
      ),
      child: Padding(
        // Top padding to avoid nav bar
        // When background color hasOpacity content will sit behind it by default
        padding:
            const EdgeInsets.only(top: 60.0, left: 12, right: 12, bottom: 16),
        child: child,
      ),
    );
  }
}

// class ModalCupertinoPageScaffold extends CupertinoPageScaffold {
//   final Key key;

//   /// Used for both the nav bar and the main modal.
//   final Color backgroundColor;
//   final Widget child;
//   final String title;
//   final void Function()? cancel;
//   final void Function()? save;
//   final bool validToSave;
//   ModalCupertinoPageScaffold(
//       {required this.key,
//       required this.child,
//       required this.title,
//       required this.backgroundColor,
//       required this.cancel,
//       required this.save,
//       this.validToSave = false})
//       : super(
//             key: key,
//             resizeToAvoidBottomInset: false,
//             child: Column(
//               children: [
//                 SizedBox(height: 100),
//                 child,
//               ],
//             ),
//             backgroundColor: Styles.errorRed,
//             navigationBar: CupertinoNavigationBar(
//               leading: cancel != null ? NavBarCancelButton(cancel) : null,
//               backgroundColor: Styles.errorRed,
//               middle: NavBarTitle(title),
//               trailing: save != null && validToSave
//                   ? FadeIn(child: NavBarSaveButton(save))
//                   : null,
//             ));
// }
