import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DifficultyLevelSelectorRow extends StatelessWidget {
  final DifficultyLevel? difficultyLevel;
  final void Function(DifficultyLevel level) updateDifficultyLevel;
  const DifficultyLevelSelectorRow(
      {Key? key, this.difficultyLevel, required this.updateDifficultyLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserInputContainer(
      child: CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 8),
          onPressed: () => context.push(
                  child: DifficultyLevelSelector(
                difficultyLevel: difficultyLevel,
                updateDifficultyLevel: updateDifficultyLevel,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MyText(
                    'Difficulty',
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    CupertinoIcons.chart_bar,
                    size: 20,
                  ),
                ],
              ),
              difficultyLevel != null
                  ? AnimatedContainer(
                      padding: kStandardCardPadding,
                      decoration: BoxDecoration(
                        color: difficultyLevel!.displayColor,
                        borderRadius: kStandardCardBorderRadius,
                        border: difficultyLevel == DifficultyLevel.elite
                            ? Border.all(color: context.theme.primary)
                            : null,
                      ),
                      duration: kStandardAnimationDuration,
                      child: Row(
                        children: [
                          MyText(
                            difficultyLevel!.display,
                            color: Styles.white,
                          ),
                          SizedBox(width: 6),
                          Icon(
                            CupertinoIcons.chevron_right,
                            size: 18,
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: MyText('Select difficulty...', subtext: true),
                    ),
            ],
          )),
    );
  }
}

class DifficultyLevelSelector extends StatefulWidget {
  final DifficultyLevel? difficultyLevel;
  final void Function(DifficultyLevel updated) updateDifficultyLevel;
  DifficultyLevelSelector(
      {this.difficultyLevel, required this.updateDifficultyLevel});
  @override
  _DifficultyLevelSelectorState createState() =>
      _DifficultyLevelSelectorState();
}

class _DifficultyLevelSelectorState extends State<DifficultyLevelSelector> {
  DifficultyLevel? _activeDifficultyLevel;

  @override
  void initState() {
    super.initState();
    _activeDifficultyLevel = widget.difficultyLevel;
  }

  void _handleUpdateSelected(DifficultyLevel tapped) {
    setState(() {
      _activeDifficultyLevel = tapped;
    });
    widget.updateDifficultyLevel(_activeDifficultyLevel!);
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        withoutLeading: true,
        trailing: NavBarSaveButton(context.pop),
        middle: LeadingNavBarTitle('Select Difficulty Level'),
      ),
      child: ListView(
        children: DifficultyLevel.values
            .where((d) => d != DifficultyLevel.artemisUnknown)
            .map((level) => GestureDetector(
                  onTap: () => _handleUpdateSelected(level),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Styles.grey))),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            MyText(level.display),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DifficultyLevelDot(level),
                            ),
                            if (_activeDifficultyLevel == level)
                              FadeIn(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: ConfirmCheckIcon(),
                              )),
                          ],
                        ),
                        InfoPopupButton(
                            infoWidget: MyText('Info about ${level.display}'))
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
