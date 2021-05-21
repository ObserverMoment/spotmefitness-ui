import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class DifficultyLevelSelector extends StatefulWidget {
  final DifficultyLevel difficultyLevel;
  final void Function(DifficultyLevel updated) updateDifficultyLevel;
  DifficultyLevelSelector(
      {required this.difficultyLevel, required this.updateDifficultyLevel});
  @override
  _DifficultyLevelSelectorState createState() =>
      _DifficultyLevelSelectorState();
}

class _DifficultyLevelSelectorState extends State<DifficultyLevelSelector> {
  late DifficultyLevel _activeDifficultyLevel;

  @override
  void initState() {
    super.initState();
    _activeDifficultyLevel = widget.difficultyLevel;
  }

  void _handleUpdateSelected(DifficultyLevel tapped) {
    setState(() {
      _activeDifficultyLevel = tapped;
    });
    widget.updateDifficultyLevel(_activeDifficultyLevel);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
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
