import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class SlidingSelect<T> extends StatelessWidget {
  final T? value;
  final void Function(T value) updateValue;
  final Map<T, Widget> children;
  SlidingSelect(
      {required this.value, required this.updateValue, required this.children});
  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl<T>(
        thumbColor: context.theme.themeName == ThemeName.dark
            ? Styles.colorOne
            : Styles.white,
        groupValue: value,
        children: children,
        onValueChanged: (v) {
          if (v != null) {
            updateValue(v);
          }
        });
  }
}
