import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Box with rounded corners. No elevation. Card background color.
class ContentBox extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets padding;
  const ContentBox(
      {required this.child,
      this.backgroundColor,
      this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 12)});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor ?? context.theme.cardBackground,
          borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}

/// Clipping box with rounded corners. No elevation.
class RoundedBox extends StatelessWidget {
  final Widget child;
  final bool border;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  RoundedBox(
      {required this.child,
      this.border = false,
      this.color,
      this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: border ? Border.all(color: context.theme.primary) : null),
      child: child,
    );
  }
}

/// Box with rounded corners. No elevation.
class CircularBox extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool border;
  final EdgeInsets? padding;
  CircularBox(
      {required this.child,
      this.padding = const EdgeInsets.all(6),
      this.color,
      this.border = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: border ? Border.all(color: context.theme.primary) : null),
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
        child,
        Positioned(
            bottom: pageHasBottomNavBar ? kBottomNavBarHeight : 40,
            right: 10,
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
  final Function()? handleUndo;
  final Function() handleSave;
  final String saveText;
  final Function() handleClose;
  final bool inputValid;
  final bool loading;
  CreateEditPageNavBar(
      {required this.title,
      required this.formIsDirty,
      this.saveText = 'Save',
      this.handleUndo,
      required this.handleSave,
      required this.handleClose,
      required this.inputValid,
      this.loading = false})
      : super(
          border: null,
          leading:
              Align(alignment: Alignment.centerLeft, child: NavBarTitle(title)),
          trailing: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: loading
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: LoadingDots(
                            size: 12,
                            color: Styles.infoBlue,
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (formIsDirty && handleUndo != null)
                          FadeIn(
                            child: TextButton(
                                destructive: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                text: 'Undo all',
                                underline: false,
                                onPressed: handleUndo),
                          ),
                        if (formIsDirty && inputValid)
                          FadeIn(
                            child: TextButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                confirm: true,
                                underline: false,
                                text: saveText,
                                onPressed: handleSave),
                          ),
                        if (!formIsDirty)
                          TextButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              underline: false,
                              text: 'Close',
                              onPressed: handleClose),
                      ],
                    )),
        );
}

/// Removes the bottom border from all nav bars.
class BasicNavBar extends CupertinoNavigationBar {
  final Key? key;
  final Object heroTag;
  final bool automaticallyImplyLeading;
  final Widget? customLeading;
  final Widget? middle;
  final Widget? trailing;
  final Color? backgroundColor;
  BasicNavBar(
      {this.key,
      required this.heroTag,
      this.automaticallyImplyLeading = false,
      this.customLeading,
      this.middle,
      this.trailing,
      this.backgroundColor})
      : super(
            key: key,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: customLeading ?? const _BackButton(),
            border: null);
}

class BorderlessNavBar extends CupertinoNavigationBar {
  final Key? key;
  final bool automaticallyImplyLeading;
  final Widget? customLeading;
  final Widget? middle;
  final Widget? trailing;
  final Color? backgroundColor;
  BorderlessNavBar(
      {this.key,
      this.automaticallyImplyLeading = false,
      this.customLeading,
      this.middle,
      this.trailing,
      this.backgroundColor})
      : super(
            key: key,
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: customLeading ?? const _BackButton(),
            border: null);
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      onPressed: () {
        Navigator.maybePop(context);
      },
      child: Icon(
        CupertinoIcons.arrow_left,
        size: 22,
      ),
    );
  }
}

class ModalCupertinoPageScaffold extends StatelessWidget {
  /// Used for both the nav bar and the main modal.
  final Widget child;
  final String title;
  final void Function()? cancel;
  final void Function()? save;
  final bool validToSave;
  final bool resizeToAvoidBottomInset;
  final bool loading;
  ModalCupertinoPageScaffold(
      {required this.child,
      required this.title,
      required this.cancel,
      required this.save,
      this.loading = false,
      this.resizeToAvoidBottomInset = false,
      this.validToSave = false});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: context.theme.modalBackground,
      navigationBar: BasicNavBar(
        heroTag: 'ModalCupertinoPageScaffold - $title',
        customLeading: cancel != null ? NavBarCancelButton(cancel!) : null,
        backgroundColor: context.theme.modalBackground,
        middle: NavBarTitle(title),
        trailing: loading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoadingDots(
                    size: 12,
                    color: Styles.infoBlue,
                  ),
                ],
              )
            : save != null && validToSave
                ? FadeIn(child: NavBarSaveButton(save!))
                : null,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, left: 12, right: 12, bottom: 16),
        child: child,
      ),
    );
  }
}
