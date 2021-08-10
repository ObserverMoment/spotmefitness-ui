import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/user_intro_video_uploader.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
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
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
          customLeading: NavBarLargeTitle('Profile'),
          trailing: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                CupertinoIcons.gear,
              ),
              onPressed: () => context.navigateTo(SettingsRoute()))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            QueryObserver<AuthedUser$Query, json.JsonSerializable>(
                key: Key('ProfilePage - ${AuthedUserQuery().operationName}'),
                query: AuthedUserQuery(),
                loadingIndicator: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerCircle(diameter: 100),
                    ShimmerCircle(diameter: 100)
                  ],
                ),
                builder: (data) {
                  final user = data.authedUser;

                  return Expanded(
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      UserAvatarUploader(
                                        avatarUri: user.avatarUri,
                                        displaySize: Size(100, 100),
                                      ),
                                      SizedBox(height: 6),
                                      MyText(
                                        'Photo',
                                        size: FONTSIZE.SMALL,
                                        subtext: true,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      UserIntroVideoUploader(
                                        introVideoUri: user.introVideoUri,
                                        introVideoThumbUri:
                                            user.introVideoThumbUri,
                                        displaySize: Size(100, 100),
                                      ),
                                      SizedBox(height: 6),
                                      MyText(
                                        'Video',
                                        subtext: true,
                                        size: FONTSIZE.SMALL,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                        )
                      ],
                      body: AutoTabsRouter(
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
                  );
                }),
          ],
        ),
      ),
    );
  }
}
