import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/user_intro_video_uploader.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/profile/custom_moves_page.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _activeTabIndex = 0;

  final _titles = <String>['Personal', 'Gym Profiles', 'Custom Moves'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key('ProfilePage-CupertinoPageScaffold'),
      navigationBar: BasicNavBar(
          heroTag: 'ProfilePage',
          key: Key('ProfilePage-BasicNavBar'),
          customLeading: NavBarLargeTitle('Profile'),
          trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                CupertinoIcons.gear_solid,
                size: 28,
              ),
              onPressed: () => context.navigateTo(SettingsRoute()))),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 12),
        child: Column(
          children: [
            QueryObserver<AuthedUser$Query, json.JsonSerializable>(
                key: Key('ProfilePage - ${AuthedUserQuery().operationName}'),
                query: AuthedUserQuery(),
                fetchPolicy: QueryFetchPolicy.storeAndNetwork,
                loadingIndicator: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerCircle(diameter: 100),
                    ShimmerCircle(diameter: 100)
                  ],
                ),
                builder: (data) {
                  final user = data.authedUser;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            UserAvatarUploader(
                              avatarUri: user.avatarUri,
                              displaySize: Size(100, 100),
                            ),
                            MyText('Photo')
                          ],
                        ),
                        Column(
                          children: [
                            UserIntroVideoUploader(
                              introVideoUri: user.introVideoUri,
                              introVideoThumbUri: user.introVideoThumbUri,
                              displaySize: Size(100, 100),
                            ),
                            MyText('Video')
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(height: 12),
            Expanded(
              child: AutoTabsRouter(
                  routes: [
                    ProfilePersonalRoute(),
                    ProfileGymProfilesRoute(),
                    ProfileCustomMovesRoute()
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
