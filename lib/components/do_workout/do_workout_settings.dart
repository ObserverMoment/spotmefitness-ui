import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/pickers/cupertino_switch_row.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/services/utils.dart';

class DoWorkoutSettings extends StatelessWidget {
  const DoWorkoutSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        backgroundColor: context.theme.background,
        customLeading: NavBarChevronDownButton(context.pop),
        middle: const NavBarTitle('Workout Settings'),
      ),
      child: ListView(
        children: [
          UserInputContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoSwitchRow(
                    title: 'Enable Video',
                    updateValue: (v) => printLog(v.toString()),
                    value: true),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: MyText(
                    'If there is a video, play it while you workout.',
                    size: FONTSIZE.two,
                  ),
                )
              ],
            ),
          ),
          UserInputContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoSwitchRow(
                    title: 'Enable Audio',
                    updateValue: (v) => printLog(v.toString()),
                    value: true),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: MyText(
                    'If there is audio, play it while you workout.',
                    size: FONTSIZE.two,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
