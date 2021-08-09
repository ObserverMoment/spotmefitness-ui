import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

// Simple animated tabs which return a new tab index when clicked.
class MyTabBarNav extends StatefulWidget {
  final List<String> titles;

  /// Display a small icon on the top right of the tab title.
  /// Wrap in a [Positioned].
  final List<Widget?>? superscriptIcons;
  final int activeTabIndex;
  final Function(int newIndex) handleTabChange;
  final Alignment alignment;

  const MyTabBarNav({
    required this.titles,
    required this.handleTabChange,
    required this.activeTabIndex,
    this.superscriptIcons,
    this.alignment = Alignment.centerLeft,
  }) : assert(superscriptIcons == null ||
            superscriptIcons.length == titles.length);

  @override
  _MyTabBarNavState createState() => _MyTabBarNavState();
}

class _MyTabBarNavState extends State<MyTabBarNav> {
  // Create global keys that can track the actual rendered size of the tab text.
  late List<GlobalKey> _globalTextBoxKeys;
  List<double>? _tabRenderBoxWidths;

  /// The titles list can be changed from the parent. When they are this list will be updated and new keys and box positions will be generated.
  late List<String> _activeTitles;

  @override
  void initState() {
    super.initState();
    _activeTitles = [...widget.titles];
    _globalTextBoxKeys = _activeTitles.map((tab) => GlobalKey()).toList();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Get renderBox widths of the text elements.
      _tabRenderBoxWidths =
          _globalTextBoxKeys.map((k) => k.currentContext!.size!.width).toList();
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant MyTabBarNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.titles.equals(widget.titles)) {
      _activeTitles = [...widget.titles];
      _globalTextBoxKeys = _activeTitles.map((tab) => GlobalKey()).toList();

      /// They need to be refreshed after first frame is rendered.
      /// Without this line the length of the list titles and the length if box widths arrays can diverge and cause index errors.
      _tabRenderBoxWidths = null;

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // Get renderBox widths of the text elements.
        _tabRenderBoxWidths = _globalTextBoxKeys
            .map((k) => k.currentContext!.size!.width)
            .toList();
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
      alignment: widget.alignment,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: context.theme.cardBackground, width: 3)),
      ),
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: _activeTitles
            .asMap()
            .map((index, title) => MapEntry(
                index,
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      pressedOpacity: 0.9,
                      alignment: Alignment.centerLeft,
                      onPressed: () => widget.handleTabChange(index),
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedOpacity(
                              key: _globalTextBoxKeys[index],
                              opacity: index == widget.activeTabIndex ? 1 : 0.7,
                              duration: Duration(milliseconds: 400),
                              child: MyHeaderText(
                                title,
                              ),
                            ),
                            GrowInOut(
                                axis: Axis.horizontal,
                                show: index == widget.activeTabIndex,
                                child: Container(
                                  height: 2.5,
                                  width: _tabRenderBoxWidths?[index] ?? 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Styles.colorOne,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    if (widget.superscriptIcons?[index] != null)
                      widget.superscriptIcons![index]!
                  ],
                )))
            .values
            .toList(),
      ),
    );
  }
}
