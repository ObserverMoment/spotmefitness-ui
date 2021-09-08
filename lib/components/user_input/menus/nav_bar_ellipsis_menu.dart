import 'dart:ui';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Ellipsis icon for top right of nav bar that opens up a context menu.
class NavBarEllipsisMenu extends StatefulWidget {
  final List<ContextMenuItem> items;
  NavBarEllipsisMenu({required this.items});

  @override
  _NavBarEllipsisMenuState createState() => _NavBarEllipsisMenuState();
}

class _NavBarEllipsisMenuState extends State<NavBarEllipsisMenu> {
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      controller: _controller,
      pressType: PressType.singleClick,
      showArrow: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          CupertinoIcons.ellipsis,
          size: Styles.buttonIconSize,
        ),
      ),
      menuBuilder: () => DropdownMenu(
        items: widget.items,
        controller: _controller,
      ),
    );
  }
}

/// Drop down / context menu UI - use with custom_popup_menu to display options next to clicked item.
class DropdownMenu extends StatelessWidget {
  final List<ContextMenuItem> items;
  final CustomPopupMenuController controller;
  DropdownMenu({required this.items, required this.controller});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: 240,
          color: context.theme.cardBackground.withOpacity(0.65),
          child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, i) => GestureDetector(
                  onTap: () {
                    controller.hideMenu();
                    items[i].onTap();
                  },
                  child: items[i]),
              separatorBuilder: (c, i) => HorizontalLine(
                    color: Styles.grey.withOpacity(0.12),
                    verticalPadding: 0,
                  ),
              itemCount: items.length),
        ),
      ),
    );
  }
}

class ContextMenuItem extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final bool confirm;
  final bool destructive;
  final void Function() onTap;
  final bool isLast;
  ContextMenuItem(
      {required this.text,
      required this.onTap,
      this.iconData,
      this.confirm = false,
      this.isLast = false,
      this.destructive = false})
      : assert(!(confirm && destructive));
  @override
  Widget build(BuildContext context) {
    final color = confirm
        ? Styles.infoBlue
        : destructive
            ? Styles.errorRed
            : context.theme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
          border:
              isLast ? Border(bottom: BorderSide(color: Styles.grey)) : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text,
            color: color,
            textAlign: TextAlign.left,
          ),
          if (iconData != null)
            Icon(
              iconData,
              size: 21,
              color: color,
            )
        ],
      ),
    );
  }
}

/// Pass any item to allow it to be tapped and open up an inline context menu.
class ContextMenuDelegate extends StatefulWidget {
  final List<ContextMenuItem> items;
  final Widget tappable;
  ContextMenuDelegate({required this.items, required this.tappable});

  @override
  _ContextMenuDelegateState createState() => _ContextMenuDelegateState();
}

class _ContextMenuDelegateState extends State<ContextMenuDelegate> {
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      controller: _controller,
      pressType: PressType.singleClick,
      showArrow: false,
      child: widget.tappable,
      menuBuilder: () => DropdownMenu(
        items: widget.items,
        controller: _controller,
      ),
    );
  }
}
