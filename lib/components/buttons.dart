import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/extensions.dart';
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
      withMinWidth: withMinWidth,
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
      backgroundColor: const Color(0xff262626),
      contentColor: CupertinoColors.white,
      withMinWidth: withMinWidth,
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

  TextButton(
      {required this.text,
      required this.onPressed,
      this.destructive = false,
      this.confirm = false,
      this.loading = false,
      this.padding,
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
  final bool bold;
  final bool large;
  PageLink(
      {required this.linkText,
      required this.onPress,
      this.icon,
      this.infoHighlight = false,
      this.destructiveHighlight = false,
      this.bold = false,
      this.large = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
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
  final String text;
  final void Function() onPressed;
  MiniButton({this.prefix, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(2),
      pressedOpacity: 0.8,
      onPressed: () => {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: Styles.black, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            if (prefix != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: prefix,
              ),
            MyText(
              text,
              weight: FontWeight.bold,
              size: FONTSIZE.SMALL,
              color: Styles.white,
            )
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final void Function() onPressed;
  final int activeFilters;
  FilterButton({required this.onPressed, this.activeFilters = 0});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MiniButton(
          onPressed: () => {},
          text: 'Filter',
          prefix: Icon(
            CupertinoIcons.slider_horizontal_3,
            color: context.theme.background,
            size: 20,
          ),
        ),
        if (activeFilters > 0)
          Positioned(
            top: -1,
            right: -1,
            child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Styles.colorTwo, shape: BoxShape.circle),
                child: MyText(
                  activeFilters.toString(),
                  lineHeight: 1,
                  color: Styles.white,
                  size: FONTSIZE.TINY,
                  weight: FontWeight.bold,
                )),
          )
      ],
    );
  }
}

class OpenTextSearchButton extends StatelessWidget {
  final void Function() onPressed;
  OpenTextSearchButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MiniButton(
      onPressed: () => {},
      text: 'Search',
      prefix: Icon(
        CupertinoIcons.search,
        color: context.theme.background,
        size: 20,
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
      text: 'Sort',
      prefix: Icon(
        Icons.sort_outlined,
        color: context.theme.background,
        size: 20,
      ),
    );
  }
}
