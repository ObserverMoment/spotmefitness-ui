import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:auto_route/auto_route.dart';

class DoWorkoutPostWorkoutPage extends StatefulWidget {
  const DoWorkoutPostWorkoutPage({Key? key}) : super(key: key);

  @override
  State<DoWorkoutPostWorkoutPage> createState() =>
      _DoWorkoutPostWorkoutPageState();
}

class _DoWorkoutPostWorkoutPageState extends State<DoWorkoutPostWorkoutPage> {
  bool _postedToFeed = false;
  bool _createJournalEntry = false;
  bool _updatePBs = false;
  bool _bodyTransformPhoto = false;
  bool _shareExternally = false;

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        withoutLeading: true,
        middle: Row(
          children: [
            NavBarLargeTitle('Nice Work!'),
          ],
        ),
        trailing: NavBarSaveButton(context.popRoute, text: 'Done'),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          MyHeaderText(
            'Do Some Wrapping Up?',
            size: FONTSIZE.HUGE,
          ),
          SizedBox(height: 10),
          MyText(
            'All completely optional!',
          ),
          SizedBox(height: 12),
          ListView(
            shrinkWrap: true,
            children: [
              _PostWorkoutTODO(
                completed: _postedToFeed,
                startAction: () {},
                text: 'Post to Feed',
              ),
              _PostWorkoutTODO(
                completed: _createJournalEntry,
                startAction: () {},
                text: 'Create Journal Entry',
              ),
              _PostWorkoutTODO(
                completed: _updatePBs,
                startAction: () {},
                text: 'Update Personal Bests',
              ),
              _PostWorkoutTODO(
                completed: _bodyTransformPhoto,
                startAction: () {},
                text: 'Body Transform Photo',
              ),
              _PostWorkoutTODO(
                completed: _shareExternally,
                startAction: () {},
                text: 'Share to Social',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostWorkoutTODO extends StatelessWidget {
  final bool completed;
  final String text;
  final VoidCallback startAction;
  const _PostWorkoutTODO(
      {Key? key,
      required this.completed,
      required this.text,
      required this.startAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: startAction,
        child: AnimatedOpacity(
          duration: kStandardAnimationDuration,
          opacity: completed ? 0.6 : 1.0,
          child: ContentBox(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text,
                      weight: FontWeight.bold,
                      size: FONTSIZE.LARGE,
                    ),
                    AnimatedSwitcher(
                      duration: kStandardAnimationDuration,
                      child: completed
                          ? Icon(CupertinoIcons.checkmark_alt_circle_fill,
                              color: Styles.neonBlueOne)
                          : Icon(CupertinoIcons.chevron_right),
                    ),
                  ])),
        ),
      ),
    );
  }
}
