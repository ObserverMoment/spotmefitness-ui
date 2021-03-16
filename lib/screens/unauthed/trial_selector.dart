import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/enum.dart';

class TrialSelector extends StatelessWidget {
  final TrialType? trialType;
  final Function(TrialType trialType) setTrialType;
  final void Function() goToEnterDetails;
  TrialSelector(
      {this.trialType,
      required this.setTrialType,
      required this.goToEnterDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            GestureDetector(
              onTap: () => setTrialType(TrialType.BASIC),
              child: TrialSelectorBox(
                name: 'BASIC',
                cost: 4.99,
                isSelected: trialType == TrialType.BASIC,
                content: Column(
                  children: [
                    MyText('Feature 1'),
                    MyText('Feature 2'),
                    MyText('Feature 3'),
                    MyText('Feature 4'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setTrialType(TrialType.PRO),
              child: TrialSelectorBox(
                name: 'PRO',
                cost: 9.99,
                isSelected: trialType == TrialType.PRO,
                content: Column(
                  children: [
                    MyText('All from BASIC +'),
                    MyText('Feature a'),
                    MyText('Feature b'),
                    MyText('Feature c'),
                  ],
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyText(
            'Free for 3 months, then billed monthly. Cancel anytime.',
            size: FONTSIZE.SMALL,
          ),
        ),
        if (trialType != null)
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: PrimaryButton(
                onPressed: goToEnterDetails,
                text: 'Continue',
              ),
            ),
          ),
      ],
    );
  }
}

class TrialSelectorBox extends StatelessWidget {
  final String name;
  final double cost;
  final Widget content;
  final bool isSelected;
  TrialSelectorBox(
      {required this.name,
      required this.cost,
      required this.content,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 3,
                    color: isSelected
                        ? ThemeBloc.cupertinoDarkData.primaryContrastingColor
                        : ThemeBloc.cupertinoDarkData.primaryColor
                            .withOpacity(0.4))),
            padding: const EdgeInsets.all(10),
            width: 160,
            child: Column(
              children: [
                H1(name),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: content,
                ),
                MyText('£${cost.toString()} / month',
                    weight: FONTWEIGHT.BOLD, size: FONTSIZE.LARGE),
              ],
            )),
        if (isSelected)
          Positioned(
              top: 5,
              right: 5,
              child: FadeIn(
                  child: Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: ThemeBloc.cupertinoDarkData.primaryContrastingColor,
              )))
      ],
    );
  }
}
