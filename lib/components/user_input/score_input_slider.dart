import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ScoreInputSlider extends StatelessWidget {
  final String? name;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final Function(double v) saveValue;

  ScoreInputSlider(
      {this.name,
      required this.value,
      this.min = 0.0,
      this.max = 1.0,
      this.divisions,
      required this.saveValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (name != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: H3(
                  name!,
                ),
              ),
              H3(value.stringMyDouble())
            ],
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 20.0,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 11),
                    ),
                    child: Slider(
                      min: min,
                      max: max,
                      divisions: divisions,
                      value: value,
                      onChanged: saveValue,
                      activeColor: Styles.peachRed,
                      inactiveColor: context.theme.primary.withOpacity(0.08),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
