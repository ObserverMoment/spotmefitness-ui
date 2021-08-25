import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/feeds_follows_and_clubs.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/stream.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Social'),
        trailing: NavBarTrailingRow(children: [
          NotificationsIconButton(),
          ChatsIconButton(),
          CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              onPressed: () => context.navigateTo(DiscoverPeopleRoute()),
              child: Icon(CupertinoIcons.search)),
          CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              onPressed: () => context.navigateTo(
                  PostCreatorRoute(postFeedType: PostFeedType.user)),
              child: Icon(CupertinoIcons.pencil))
        ]),
      ),
      child: FeedsFollowsAndClubs(),
    );
  }
}
