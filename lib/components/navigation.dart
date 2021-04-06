import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/text.dart';

// Simple animated tabs which return a new tab index when clicked.
class MyTabBarNav extends StatefulWidget {
  final List<String> titles;
  final int activeTabIndex;
  final Function(int newIndex) handleTabChange;

  MyTabBarNav({
    required this.titles,
    required this.handleTabChange,
    required this.activeTabIndex,
  });

  @override
  _MyTabBarNavState createState() => _MyTabBarNavState();
}

class _MyTabBarNavState extends State<MyTabBarNav> {
  // Create global keys that can track the actual rendered size of the tab text.
  late List<GlobalKey> globalTextBoxKeys;
  List<double>? tabRenderBoxWidths;

  @override
  void initState() {
    super.initState();
    globalTextBoxKeys = widget.titles.map((tab) => GlobalKey()).toList();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Get renderBox widths of the text elements.
      tabRenderBoxWidths =
          globalTextBoxKeys.map((k) => k.currentContext!.size!.width).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      alignment: Alignment.centerLeft,
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: widget.titles
            .asMap()
            .map((index, title) => MapEntry(
                index,
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          key: globalTextBoxKeys[index],
                          opacity: index == widget.activeTabIndex ? 1 : 0.7,
                          duration: Duration(milliseconds: 400),
                          child: MyText(
                            title,
                            weight: FontWeight.bold,
                          ),
                        ),
                        GrowInOut(
                            axis: Axis.horizontal,
                            show: index == widget.activeTabIndex,
                            child: Container(
                              height: 3.5,
                              width: tabRenderBoxWidths?[index] ?? 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Styles.colorOne,
                              ),
                            )),
                      ],
                    ),
                  ),
                )))
            .values
            .toList(),
      ),
    );
  }
}
