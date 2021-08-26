import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class GoalTagsColorSwatch {
  static const brightRed = Color(0xFFED254E);
  static const yellow = Color(0xFFF9DC5C);
  static const purple = Color(0xFF7D5BA6);
  static const rose = Color(0xFFFC6471);
  static const green = Color(0xFF06A77D);
  static const orange = Color(0xFFFB5607);
  static const lightBlue = Color(0xFF3A86FF);
  static const red = Color(0xFFA64253);
  static const slateBlue = Color(0xFF3D348B);

  static List<Color> get colors => [
        red,
        yellow,
        brightRed,
        purple,
        rose,
        green,
        orange,
        lightBlue,
        slateBlue
      ];
}

Future<void> openColorPickerDialog(
    {required BuildContext context,
    Color? initialColor,
    String title = 'Select a color',
    required void Function(Color color) onSave}) async {
  context.showBottomSheet(
      expand: false,
      useRootNavigator: false,
      child: MyColorPicker(
        title: title,
        onCancel: context.pop,
        onSave: (Color color) {
          onSave(color);
          context.pop();
        },
      ));
}

class MyColorPicker extends StatefulWidget {
  final String title;
  final Color? initialColor;
  final void Function(Color color) onSave;
  final void Function() onCancel;
  MyColorPicker(
      {required this.onSave,
      required this.onCancel,
      this.title = 'Select a color',
      this.initialColor});

  @override
  _MyColorPickerState createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  Color? _activeColor;

  @override
  void initState() {
    super.initState();
    _activeColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3(widget.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_activeColor != null)
                    FadeIn(
                      child: CupertinoButton(
                          onPressed: () => widget.onSave(_activeColor!),
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 32,
                          )),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CupertinoButton(
                        onPressed: widget.onCancel,
                        child: Icon(
                          CupertinoIcons.clear_thick,
                          size: 28,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        Card(
          backgroundColor: Styles.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: GoalTagsColorSwatch.colors
                  .map((c) => CupertinoButton(
                        pressedOpacity: 0.9,
                        padding: const EdgeInsets.all(6),
                        onPressed: () => setState(() => _activeColor = c),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: c,
                                    boxShadow: [
                                      Styles.colorPickerSelectorBoxShadow
                                    ],
                                    borderRadius: BorderRadius.circular(12)),
                                child: SizedBox.expand()),
                            if (c == _activeColor)
                              FadeIn(
                                child: Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: Styles.white,
                                  size: 40,
                                ),
                              )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 48)
      ]),
    ));
  }
}
