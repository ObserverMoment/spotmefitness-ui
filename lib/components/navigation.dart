import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/extensions.dart';

// Simple animated tabs which return a new tab index when clicked.
class MyTabBarNav extends StatefulWidget {
  final List<Widget> tabs;
  final int activeTabIndex;
  final Function(int newIndex) handleTabChange;
  final double buttonHeight;
  final double animatedLineHeight;

  MyTabBarNav({
    required this.tabs,
    required this.handleTabChange,
    this.buttonHeight = 44,
    this.animatedLineHeight = 1.5,
    this.activeTabIndex = 0,
  });

  @override
  _MyTabBarNavState createState() => _MyTabBarNavState();
}

class _MyTabBarNavState extends State<MyTabBarNav>
    with TickerProviderStateMixin {
  final Duration _animationDuration = Duration(milliseconds: 150);
  late int _activeTabIndex;

  @override
  void initState() {
    super.initState();
    _activeTabIndex = widget.activeTabIndex;
  }

  @override
  void didUpdateWidget(MyTabBarNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    _activeTabIndex = widget.activeTabIndex;
  }

  void _handleTabChange(int index) {
    widget.handleTabChange(index);
    setState(() => _activeTabIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.theme.primary.withOpacity(0.07)),
      child: Column(
        children: [
          Row(
            children: widget.tabs
                .asMap()
                .map((index, tab) => MapEntry(
                    index,
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _handleTabChange(index),
                        child: Container(
                          height: widget.buttonHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: AnimatedOpacity(
                                    opacity: index == _activeTabIndex ? 1 : 0.7,
                                    duration: _animationDuration,
                                    child: tab,
                                  ),
                                ),
                              ),
                              AnimatedSize(
                                duration: _animationDuration,
                                reverseDuration: _animationDuration,
                                vsync: this,
                                child: Container(
                                  height: widget.animatedLineHeight,
                                  width: index == _activeTabIndex
                                      ? double.infinity
                                      : 0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: context.theme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )))
                .values
                .toList(),
          ),
          Container(
              height: 1,
              color: CupertinoTheme.of(context).primaryColor.withOpacity(0.2)),
        ],
      ),
    );
  }
}
