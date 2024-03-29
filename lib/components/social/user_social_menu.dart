import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:sofie_ui/services/utils.dart';

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
      child: const Icon(CupertinoIcons.ellipsis),
      onPressed: () => openBottomSheetMenu(
          context: context,
          child: BottomSheetMenu(
              header: BottomSheetMenuHeader(
                  name: displayName, subtitle: 'Profile', imageUri: avatarUri),
              items: [
                BottomSheetMenuItem(
                    text: 'Block',
                    icon: const Icon(CupertinoIcons.nosign),
                    onPressed: () => printLog('block')),
                BottomSheetMenuItem(
                    text: 'Report',
                    icon: const Icon(CupertinoIcons.exclamationmark_circle),
                    onPressed: () => printLog('report')),
              ])),
    );
  }
}
