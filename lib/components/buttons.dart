import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
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
          height: 48,
          constraints: withMinWidth ? BoxConstraints(minWidth: 300) : null,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
              border: border ? Border.all(color: contentColor) : null,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12)),
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
      prefix: prefix,
      suffix: suffix,
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
  final bool withBorder;

  SecondaryButton(
      {this.prefix,
      required this.text,
      this.suffix,
      required this.onPressed,
      this.withMinWidth = true,
      this.withBorder = false,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return MyButton(
      prefix: prefix,
      suffix: suffix,
      text: text,
      onPressed: onPressed,
      backgroundColor: CupertinoColors.darkBackgroundGray,
      contentColor: Styles.white,
      withMinWidth: withMinWidth,
      border: withBorder,
    );
  }
}

class BorderButton extends StatelessWidget {
  final Widget? prefix;
  final String? text;
  final void Function() onPressed;
  final bool withBorder;
  final bool mini;
  final bool loading;
  final bool disabled;
  BorderButton(
      {this.prefix,
      this.text,
      required this.onPressed,
      this.withBorder = true,
      this.loading = false,
      this.disabled = false,
      this.mini = false})
      : assert(prefix != null || text != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(4),
      pressedOpacity: 0.8,
      onPressed: disabled ? null : onPressed,
      child: AnimatedOpacity(
        opacity: disabled ? 0 : 1,
        duration: Duration(milliseconds: 250),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border:
                  withBorder ? Border.all(color: context.theme.primary) : null),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: loading ? 0 : 1,
                duration: kStandardAnimationDuration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefix != null) prefix!,
                    if (text != null && prefix != null)
                      SizedBox(width: mini ? 6 : 8),
                    if (text != null)
                      MyText(
                        text!.toUpperCase(),
                        weight: FontWeight.bold,
                        size: mini ? FONTSIZE.SMALL : FONTSIZE.MAIN,
                      )
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: loading ? 1 : 0,
                duration: kStandardAnimationDuration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [LoadingDots(size: 14)],
                ),
              ),
            ],
          ),
        ),
      ),
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
          height: 60,
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

class ExtendedIconButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final void Function() onPressed;
  final bool disabled;
  final bool loading;

  ExtendedIconButton(
      {required this.iconData,
      required this.onPressed,
      this.disabled = false,
      this.loading = false,
      required this.text});

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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
              color: context.theme.primary,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: loading
                        ? LoadingCircle(color: context.theme.primary, size: 12)
                        : Icon(iconData,
                            size: 26, color: context.theme.background)),
              ),
              H3(
                text,
                color: context.theme.background,
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
  final Widget? prefix;
  final Widget? suffix;
  final bool confirm;
  final void Function() onPressed;
  final bool loading;
  final EdgeInsets? padding;
  final bool? underline;
  final FONTSIZE fontSize;

  TextButton(
      {required this.text,
      required this.onPressed,
      this.prefix,
      this.suffix,
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefix != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: prefix,
                    ),
                  MyText(text,
                      size: fontSize,
                      weight: FontWeight.bold,
                      decoration: underline! ? TextDecoration.underline : null,
                      color: confirm
                          ? Styles.infoBlue
                          : destructive
                              ? Styles.errorRed
                              : null),
                  if (suffix != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: suffix,
                    ),
                ],
              ),
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
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                  MyText(
                    linkText,
                    color: infoHighlight
                        ? Styles.infoBlue
                        : destructiveHighlight
                            ? Styles.errorRed
                            : null,
                  ),
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

class DoItButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  DoItButton({this.text = 'Do it', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(4),
      pressedOpacity: 0.8,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: context.theme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            MyText(
              text.toUpperCase(),
              weight: FontWeight.bold,
              size: FONTSIZE.SMALL,
              color: context.theme.background,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              CupertinoIcons.chevron_right_2,
              size: 12,
              color: context.theme.background,
            ),
          ],
        ),
      ),
    );
  }
}

/// Similar style to the main bottom nav bar.
/// Used for floating button lists - usually at the bottom of the screen. E.g sort, filter, search.
class RaisedButtonContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  RaisedButtonContainer(
      {required this.child,
      this.borderRadius,
      this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 16)});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.theme.themeName == ThemeName.dark;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
            padding: padding,
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color:
                          CupertinoColors.black.withOpacity(isDark ? 0.6 : 0.3),
                      blurRadius: 3, // soften the shadow
                      spreadRadius: 1.5, //extend the shadow
                      offset: Offset(
                        0.4, // Move to right horizontally
                        0.4, // Move to bottom Vertically
                      ))
                ],
                color:
                    context.theme.background.withOpacity(isDark ? 0.75 : 0.9),
                border: Border.all(
                    color: context.theme.primary
                        .withOpacity(isDark ? 0.15 : 0.1))),
            child: child),
      ),
    );
  }
}

/// Similar to [RaisedButtonContainer] but with no elevation - blurs background contents.
class UnRaisedButtonContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  UnRaisedButtonContainer(
      {required this.child,
      this.borderRadius,
      this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 16)});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.theme.themeName == ThemeName.dark;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
            padding: padding,
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(16),
                color:
                    context.theme.background.withOpacity(isDark ? 0.75 : 0.9),
                border:
                    Border.all(color: context.theme.primary.withOpacity(0.15))),
            child: child),
      ),
    );
  }
}

/// Vertical line used for separating buttons in a multi button widget. E.g floating button.
class ButtonSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 30,
        width: 1,
        color: context.theme.primary.withOpacity(0.2),
      ),
    );
  }
}

class SortFilterSearchFloatingButton extends StatelessWidget {
  final bool showFilter;
  final void Function()? onFilterPress;
  final bool showSort;
  final void Function()? onSortPress;
  final bool showSearch;
  final void Function()? onSearchPress;
  SortFilterSearchFloatingButton(
      {this.showFilter = true,
      this.onFilterPress,
      this.showSort = true,
      this.onSortPress,
      this.showSearch = true,
      this.onSearchPress})
      : assert((showFilter && onFilterPress != null) || !showFilter),
        assert((showSort && onSortPress != null) || !showSort),
        assert((showSearch && onSearchPress != null) || !showSearch),
        assert(showFilter || showSort || showSearch);

  final kButtonPadding = const EdgeInsets.symmetric(horizontal: 16);

  List<Widget> _buttonsList() {
    List<Widget> buttons = [];
    if (showFilter) {
      buttons.add(CupertinoButton(
          padding: kButtonPadding,
          onPressed: onFilterPress,
          child: Icon(
            CupertinoIcons.slider_horizontal_3,
          )));
    }
    if (showSort) {
      buttons.add(CupertinoButton(
          padding: kButtonPadding,
          onPressed: onSortPress,
          child: Icon(
            CupertinoIcons.arrow_up_arrow_down,
          )));
    }
    if (showSearch) {
      buttons.add(CupertinoButton(
          padding: kButtonPadding,
          onPressed: onSearchPress,
          child: Icon(
            CupertinoIcons.search,
          )));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    final buttons = _buttonsList();
    return RaisedButtonContainer(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: SizedBox(
          height: 40,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) => buttons[i],
              separatorBuilder: (c, i) => ButtonSeparator(),
              itemCount: buttons.length),
        ));
  }
}

class FilterButton extends StatelessWidget {
  final void Function() onPressed;
  final bool hasActiveFilters;
  FilterButton({required this.onPressed, this.hasActiveFilters = false});
  @override
  Widget build(BuildContext context) {
    return UnRaisedButtonContainer(
      padding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BorderButton(
            mini: true,
            withBorder: false,
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
      ),
    );
  }
}

class OpenTextSearchButton extends StatelessWidget {
  final void Function() onPressed;
  final String? text;
  OpenTextSearchButton({required this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return UnRaisedButtonContainer(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(
          CupertinoIcons.search,
          size: kMiniButtonIconSize,
        ),
        onPressed: onPressed,
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
              text.toUpperCase(),
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
        ));
  }
}

/// Has no padding which allows it to act as 'Leading' / 'trailing' widget in the nav bar.
class NavBarCloseButton extends StatelessWidget {
  final void Function() onPressed;
  NavBarCloseButton(this.onPressed);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: MyText(
          'Close',
          weight: FontWeight.bold,
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
          child: CupertinoPageScaffold(
        navigationBar: withoutNavBar
            ? null
            : BorderlessNavBar(middle: NavBarTitle(pageTitle)),
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

/// Shows a notes icon and opens the note up full screen onpress.
class NoteIconViewerButton extends StatelessWidget {
  final String note;
  final String modalTitle;
  final bool useRootNavigator;
  NoteIconViewerButton(this.note,
      {this.modalTitle = 'Note', this.useRootNavigator = true});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: NotesIcon(),
        onPressed: () => context.showBottomSheet(
            useRootNavigator: useRootNavigator,
            expand: true,
            child: TextViewer(note, modalTitle)));
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

class CircularCheckbox extends StatelessWidget {
  final void Function(bool v) onPressed;
  final bool isSelected;
  CircularCheckbox({required this.onPressed, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: isSelected
                ? Icon(CupertinoIcons.checkmark_alt_circle_fill)
                : Icon(CupertinoIcons.circle)),
        onPressed: () => onPressed(isSelected ? false : true));
  }
}

class ShowHideDetailsButton extends StatelessWidget {
  final void Function() onPressed;
  final bool showDetails;
  final String showText;
  final String hideText;
  const ShowHideDetailsButton(
      {Key? key,
      required this.onPressed,
      required this.showDetails,
      this.showText = 'Show Details',
      this.hideText = 'Hide Details'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: MyText(
        showDetails ? hideText : showText,
        size: FONTSIZE.SMALL,
        weight: FontWeight.bold,
      ),
    );
  }
}
