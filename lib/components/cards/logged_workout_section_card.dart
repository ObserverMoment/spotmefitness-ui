import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class LoggedWorkoutSectionCard extends StatelessWidget {
  final LoggedWorkoutSection loggedWorkoutSection;
  const LoggedWorkoutSectionCard({Key? key, required this.loggedWorkoutSection})
      : super(key: key);

  final kLinePadding = const EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LoggedWorkoutSectionSummaryTag(
              loggedWorkoutSection,
              fontSize: FONTSIZE.MAIN,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => print('open moves and details page'),
              child: Icon(CupertinoIcons.list_number),
            )
          ],
        ),
        if (Utils.textNotNull(loggedWorkoutSection.name))
          Padding(
            padding: kLinePadding,
            child: MyHeaderText(
              loggedWorkoutSection.name!,
              size: FONTSIZE.BIG,
            ),
          ),
        Padding(
          padding: kLinePadding,
          child: MyText('Moves'),
        ),
        Padding(
          padding: kLinePadding,
          child: MyText('Move Types'),
        ),
        Padding(
          padding: kLinePadding,
          child: MyText('Body Areas'),
        ),
      ],
    ));
  }
}
