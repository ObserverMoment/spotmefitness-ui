import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
  final bool withMinWidth;

  MyButton(
      {this.prefix,
      required this.onPressed,
      required this.text,
      this.suffix,
      required this.contentColor,
      required this.backgroundColor,
      this.border = false,
      this.disabled = false,
      this.withMinWidth = true,
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
          constraints: withMinWidth ? BoxConstraints(minWidth: 300) : null,
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
                          weight: FontWeight.bold,
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
  final bool withMinWidth;

  PrimaryButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.disabled = false,
      this.withMinWidth = true,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      text: text,
      onPressed: onPressed,
      disabled: disabled,
      loading: loading,
      backgroundColor: context.theme.primary,
      contentColor: context.theme.background,
      withMinWidth: withMinWidth,
    );
  }
}

/// Primary color border - primary color text.
class SecondaryButton extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final Widget? suffix;
  final void Function() onPressed;
  final bool loading;
  final bool withMinWidth;

  SecondaryButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.withMinWidth = true,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      prefix: prefix,
      suffix: suffix,
      text: text,
      onPressed: onPressed,
      backgroundColor: CupertinoColors.darkBackgroundGray,
      contentColor: context.theme.primary,
      withMinWidth: withMinWidth,
      border: true,
    );
  }
}

class DestructiveButton extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final Widget? suffix;
  final void Function() onPressed;
  final bool loading;
  final bool withMinWidth;

  DestructiveButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.withMinWidth = true,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      prefix: prefix,
      text: text,
      suffix: suffix,
      loading: loading,
      onPressed: onPressed,
      backgroundColor: CupertinoColors.destructiveRed,
      contentColor: CupertinoColors.white,
      withMinWidth: withMinWidth,
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;
  final bool disabled;
  final bool loading;

  RoundIconButton(
      {required this.iconData,
      required this.onPressed,
      this.disabled = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: disabled ? 0.2 : 1,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        pressedOpacity: 0.8,
        onPressed: disabled ? null : onPressed,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.5),
                  blurRadius: 3, // soften the shadow
                  spreadRadius: 1.5, //extend the shadow
                  offset: Offset(
                    0.4, // Move to right horizontally
                    0.4, // Move to bottom Vertically
                  ))
            ],
            color: Styles.colorOne,
            shape: BoxShape.circle,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: loading
                        ? LoadingCircle(color: context.theme.primary, size: 12)
                        : Icon(iconData, size: 34, color: Styles.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  final String text;
  final bool destructive;
  final bool confirm;
  final void Function() onPressed;
  final bool loading;
  final EdgeInsets? padding;
  final bool? underline;
  final FONTSIZE fontSize;

  TextButton(
      {required this.text,
      required this.onPressed,
      this.destructive = false,
      this.confirm = false,
      this.loading = false,
      this.padding,
      this.fontSize = FONTSIZE.MAIN,
      this.underline = true})
      : assert(!(confirm && destructive));

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: loading
            ? LoadingDots()
            : MyText(text,
                size: fontSize,
                weight: FontWeight.bold,
                decoration: underline! ? TextDecoration.underline : null,
                color: confirm
                    ? Styles.infoBlue
                    : destructive
                        ? Styles.errorRed
                        : null),
      ),
    );
  }
}

/// Clickable row which spans the width of parent
/// With title on left and right chevron on right.
class PageLink extends StatelessWidget {
  final void Function() onPress;
  final String linkText;
  final Widget? icon;
  final bool infoHighlight;
  final bool destructiveHighlight;
  final bool loading;

  PageLink(
      {required this.linkText,
      required this.onPress,
      this.icon,
      this.infoHighlight = false,
      this.destructiveHighlight = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPress,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: context.theme.primary.withOpacity(0.06)))),
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: icon,
                    ),
                  MyText(linkText,
                      color: infoHighlight
                          ? Styles.infoBlue
                          : destructiveHighlight
                              ? Styles.errorRed
                              : null,
                      weight: FontWeight.bold),
                  if (loading)
                    FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: LoadingDots(
                          size: 10,
                        ),
                      ),
                    ),
                ],
              ),
              Icon(CupertinoIcons.right_chevron, size: 18),
            ],
          )),
    );
  }
}

/// Small simplified button with little padding. Use for eg filter button.
class MiniButton extends StatelessWidget {
  final Widget? prefix;
  final String? text;
  final void Function() onPressed;
  final bool withBorder;
  MiniButton(
      {this.prefix, this.text, required this.onPressed, this.withBorder = true})
      : assert(prefix != null || text != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(4),
      pressedOpacity: 0.8,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border:
                withBorder ? Border.all(color: context.theme.primary) : null),
        child: Row(
          children: [
            if (prefix != null) prefix!,
            if (text != null && prefix != null) SizedBox(width: 4),
            if (text != null)
              MyText(
                text!,
                weight: FontWeight.bold,
                size: FONTSIZE.SMALL,
              )
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final void Function() onPressed;
  final bool hasActiveFilters;
  FilterButton({required this.onPressed, this.hasActiveFilters = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MiniButton(
          onPressed: onPressed,
          prefix: Icon(
            CupertinoIcons.slider_horizontal_3,
            size: kMiniButtonIconSize,
          ),
        ),
        if (hasActiveFilters)
          Positioned(
            top: -4,
            right: -3,
            child: Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              color: Styles.infoBlue,
              size: 20,
            ),
          )
      ],
    );
  }
}

class OpenTextSearchButton extends StatelessWidget {
  final void Function() onPressed;
  final String? text;
  OpenTextSearchButton({required this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return MiniButton(
      onPressed: onPressed,
      text: text,
      prefix: Icon(
        CupertinoIcons.search,
        size: kMiniButtonIconSize,
      ),
    );
  }
}

class SortByButton extends StatelessWidget {
  final void Function() onPressed;
  SortByButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MiniButton(
      onPressed: () => {},
      prefix: Icon(
        Icons.sort_outlined,
        size: 26,
      ),
    );
  }
}

/// Create button with no background or border.
class CreateTextIconButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool loading;
  CreateTextIconButton(
      {required this.onPressed, this.text = 'Create', this.loading = false});

  List<Widget> _buildChildren() {
    return loading
        ? [
            LoadingDots(
              size: 14,
            ),
          ]
        : [
            Icon(
              CupertinoIcons.add,
              size: 22,
            ),
            SizedBox(width: 2),
            MyText(
              text,
              weight: FontWeight.bold,
            )
          ];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: loading ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildChildren(),
      ),
    );
  }
}

/// Has no padding which allows it to act as 'Leading' / 'trailing' widget in the nav bar.
class NavBarCancelButton extends StatelessWidget {
  final void Function() onPressed;
  NavBarCancelButton(this.onPressed);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: MyText(
          'Cancel',
          color: Styles.errorRed,
        ));
  }
}

/// Has no padding which allows it to act as 'Leading' / 'trailing' widget in the nav bar.
class NavBarSaveButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool loading;
  NavBarSaveButton(this.onPressed, {this.text = 'Save', this.loading = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: loading ? null : onPressed,
            child: loading
                ? LoadingDots(
                    size: 12,
                    color: Styles.infoBlue,
                  )
                : MyText(
                    text,
                    color: Styles.infoBlue,
                    weight: FontWeight.bold,
                  )),
      ],
    );
  }
}

/// Has no padding which allows it to act as 'Leading' / 'trailing' widget in the nav bar.
class NavBarTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  NavBarTextButton({required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: MyText(
          text,
        ));
  }
}

/// Icon buttons
class InfoPopupButton extends StatelessWidget {
  final String pageTitle;
  final Widget infoWidget;

  /// Defaults to displaying a nav bar but can be removed if the info widget being displayed already has one.
  final bool withoutNavBar;
  InfoPopupButton(
      {required this.infoWidget,
      this.pageTitle = 'Info',
      this.withoutNavBar = false});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => context.push(
          fullscreenDialog: true,
          child: CupertinoPageScaffold(
            navigationBar: withoutNavBar
                ? null
                : BasicNavBar(middle: NavBarTitle(pageTitle)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [infoWidget],
                ),
              ),
            ),
          )),
      child: Icon(CupertinoIcons.info, size: Styles.buttonIconSize),
    );
  }
}

/// Circled + should be used in the nav bar only - elsewhere use the uncircled version.
class CreateIconButton extends StatelessWidget {
  final void Function() onPressed;
  CreateIconButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(
        CupertinoIcons.add_circled,
        size: 25,
      ),
    );
  }
}
