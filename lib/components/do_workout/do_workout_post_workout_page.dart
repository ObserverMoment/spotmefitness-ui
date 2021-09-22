import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';

class DoWorkoutPostWorkoutPage extends StatefulWidget {
  const DoWorkoutPostWorkoutPage({Key? key}) : super(key: key);

  @override
  State<DoWorkoutPostWorkoutPage> createState() =>
      _DoWorkoutPostWorkoutPageState();
}

class _DoWorkoutPostWorkoutPageState extends State<DoWorkoutPostWorkoutPage> {
  final bool _postedToFeed = false;
  final bool _createJournalEntry = false;
  final bool _updatePBs = false;
  final bool _bodyTransformPhoto = false;
  final bool _shareExternally = false;

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        withoutLeading: true,
        middle: Row(
          children: const [
            NavBarLargeTitle('Nice Work!'),
          ],
        ),
        trailing: NavBarSaveButton(context.popRoute, text: 'Done'),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const MyHeaderText(
            'Do Some Wrapping Up?',
            size: FONTSIZE.six,
          ),
          const SizedBox(height: 10),
          const MyText(
            'All completely optional!',
          ),
          const SizedBox(height: 12),
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
                      size: FONTSIZE.five,
                    ),
                    AnimatedSwitcher(
                      duration: kStandardAnimationDuration,
                      child: completed
                          ? const Icon(CupertinoIcons.checkmark_alt_circle_fill,
                              color: Styles.neonBlueOne)
                          : const Icon(CupertinoIcons.chevron_right),
                    ),
                  ])),
        ),
      ),
    );
  }
}
