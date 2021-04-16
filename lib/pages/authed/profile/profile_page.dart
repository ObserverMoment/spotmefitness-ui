import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/user_intro_video_uploader.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/profile/settings_and_info.dart';
import 'package:spotmefitness_ui/router.gr.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _activeTabIndex = 0;

  final _titles = <String>['Personal', 'Gym Profiles'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle(
          'PROFILE',
        ),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.gear_solid),
            onPressed: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SettingsAndInfo()))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            QueryResponseBuilder(
                options: QueryOptions(
                  document: AuthedUserQuery().document,
                ),
                builder: (result, {fetchMore, refetch}) {
                  final _user =
                      AuthedUser$Query.fromJson(result.data ?? {}).authedUser;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          UserAvatarUploader(
                            avatarUri: _user.avatarUri,
                            displaySize: Size(100, 100),
                          ),
                          MyText('Photo')
                        ],
                      ),
                      Column(
                        children: [
                          UserIntroVideoUploader(
                            introVideoUri: _user.introVideoUri,
                            introVideoThumbUri: _user.introVideoThumbUri,
                            displaySize: Size(100, 100),
                          ),
                          MyText('Video')
                        ],
                      ),
                    ],
                  );
                }),
            SizedBox(height: 12),
            Expanded(
              child: AutoTabsRouter(
                  routes: [
                    ProfilePersonalRoute(),
                    ProfileGymProfilesRoute(),
                  ],
                  builder: (context, child, animation) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyTabBarNav(
                            activeTabIndex: _activeTabIndex,
                            titles: _titles,
                            handleTabChange: (index) {
                              setState(() => _activeTabIndex = index);
                              context.tabsRouter.setActiveIndex(index);
                            }),
                        Flexible(
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
