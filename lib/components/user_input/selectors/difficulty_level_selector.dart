import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DifficultyLevelSelectorRow extends StatelessWidget {
  final DifficultyLevel? difficultyLevel;
  final void Function(DifficultyLevel? level) updateDifficultyLevel;
  const DifficultyLevelSelectorRow(
      {Key? key, this.difficultyLevel, required this.updateDifficultyLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TappableRow(
        title: 'Difficulty',
        display: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: difficultyLevel != null
              ? Tag(
                  textColor: Styles.white,
                  tag: difficultyLevel!.display,
                  color: difficultyLevel!.displayColor,
                  borderColor: difficultyLevel == DifficultyLevel.elite
                      ? context.theme.primary
                      : null,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: MyText('Select difficulty...', subtext: true),
                ),
        ),
        onTap: () => context.push(
                child: DifficultyLevelSelector(
              difficultyLevel: difficultyLevel,
              updateDifficultyLevel: updateDifficultyLevel,
            )));
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
    return CupertinoPageScaffold(
      navigationBar: MyNavBar(
        customLeading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: MyText(
              'Done',
              weight: FontWeight.bold,
            ),
            onPressed: () => Navigator.pop(context)),
        middle: NavBarTitle('Difficulty Level'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: DifficultyLevel.values
              .where((d) => d != DifficultyLevel.artemisUnknown)
              .map((level) => GestureDetector(
                    onTap: () => _handleUpdateSelected(level),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Styles.grey))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
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
      ),
    );
  }
}
