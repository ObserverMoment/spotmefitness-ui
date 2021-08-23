import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';

/// Standard modal bottom sheet for allowing actions on another user
/// E.g. [share], [block], [report]
class UserSocialBottomSheetMenu extends StatelessWidget {
  final String displayName;
  final String avatarUri;
  const UserSocialBottomSheetMenu(
      {Key? key, required this.displayName, required this.avatarUri})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.ellipsis_circle),
      onPressed: () => openBottomSheetMenu(
          context: context,
          child: BottomSheetMenu(
              header: BottomSheetMenuHeader(
                  name: displayName, subtitle: 'Profile', imageUri: avatarUri),
              items: [
                BottomSheetMenuItem(
                    text: 'Block',
                    icon: Icon(CupertinoIcons.nosign),
                    onPressed: () => print('block')),
                BottomSheetMenuItem(
                    text: 'Report',
                    icon: Icon(CupertinoIcons.exclamationmark_circle),
                    onPressed: () => print('report')),
              ])),
    );
  }
}
