import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/other_app_icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_created_workout_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts/your_created_workouts.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class UserPublicProfileDetailsPage extends StatefulWidget {
  final String userId;
  const UserPublicProfileDetailsPage(
      {@PathParam('userId') required this.userId});

  @override
  _UserPublicProfileDetailsPageState createState() =>
      _UserPublicProfileDetailsPageState();
}

class _UserPublicProfileDetailsPageState
    extends State<UserPublicProfileDetailsPage> {
  int _activeTabIndex = 0;
  late PageController _pageController;
  late ScrollController _scrollController;

  final kAvatarSize = 120.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    setState(() => _activeTabIndex = index);
  }

  /// Top right of tabs to indicate how many of each type are in the list.
  Widget _buildNumberDisplay(int number) {
    return Positioned(
      top: -4,
      right: 4,
      child: MyText(
        number.toString(),
        size: FONTSIZE.SMALL,
        weight: FontWeight.bold,
        lineHeight: 1,
        color: Styles.colorTwo,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = UserPublicProfileByIdQuery(
        variables: UserPublicProfileByIdArguments(userId: widget.userId));

    return QueryObserver<UserPublicProfileById$Query,
            UserPublicProfileByIdArguments>(
        key: Key(
            'UserPublicProfileDetailsPage - ${query.operationName}-${widget.userId}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final userPublicProfile = data.userPublicProfileById;

          return CupertinoPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: NavBarTitle('Profile'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(CupertinoIcons.ellipsis_circle),
                  onPressed: () => context.showBottomSheet(
                      child: BottomSheetMenu(
                          header: BottomSheetMenuHeader(
                            name: userPublicProfile.displayName,
                            subtitle: 'Profile',
                            imageUri: userPublicProfile.avatarUri,
                          ),
                          items: [
                        BottomSheetMenuItem(
                            text: 'Connect / Disconnect',
                            icon: Icon(
                                CupertinoIcons.person_crop_circle_badge_plus),
                            onPressed: () => print('Connect')),
                        BottomSheetMenuItem(
                            text: 'Message',
                            icon: Icon(CupertinoIcons.mail),
                            onPressed: () => print('message')),
                        BottomSheetMenuItem(
                            text: 'Save',
                            icon: Icon(CupertinoIcons.heart_circle),
                            onPressed: () => print('save')),
                        BottomSheetMenuItem(
                            text: 'Share',
                            icon: Icon(CupertinoIcons.share),
                            onPressed: () => print('share')),
                        BottomSheetMenuItem(
                            text: 'Block',
                            icon: Icon(CupertinoIcons.nosign),
                            onPressed: () => print('block')),
                        BottomSheetMenuItem(
                            text: 'Report',
                            icon: Icon(CupertinoIcons.exclamationmark_circle),
                            onPressed: () => print('report')),
                      ])),
                ),
              ),
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topCenter,
                              children: [
                                _HeaderContent(
                                  userPublicProfile: userPublicProfile,
                                  avatarSize: kAvatarSize,
                                ),
                                if (Utils.textNotNull(
                                    userPublicProfile.avatarUri))
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () => openFullScreenImageViewer(
                                            context,
                                            userPublicProfile.avatarUri!),
                                        child: Hero(
                                          tag: kFullScreenImageViewerHeroTag,
                                          child: UserAvatar(
                                            avatarUri:
                                                userPublicProfile.avatarUri,
                                            size: kAvatarSize,
                                            border: true,
                                            borderWidth: 2,
                                          ),
                                        ),
                                      ),
                                      if (Utils.textNotNull(
                                          userPublicProfile.introVideoThumbUri))
                                        GestureDetector(
                                          onTap: () => VideoSetupManager
                                              .openFullScreenVideoPlayer(
                                                  context: context,
                                                  videoUri: userPublicProfile
                                                      .introVideoUri!,
                                                  autoPlay: true),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              UserAvatar(
                                                avatarUri: userPublicProfile
                                                    .introVideoThumbUri,
                                                size: kAvatarSize,
                                                border: true,
                                                borderWidth: 2,
                                              ),
                                              Icon(
                                                CupertinoIcons.play_circle,
                                                size: 40,
                                                color: Styles.white
                                                    .withOpacity(0.7),
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          )
                        ]),
                      )
                    ];
                  },
                  body: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyTabBarNav(
                            titles: [
                              'Workouts',
                              'Plans'
                            ],
                            superscriptIcons: [
                              userPublicProfile.workouts.isEmpty
                                  ? null
                                  : _buildNumberDisplay(
                                      userPublicProfile.workouts.length),
                              userPublicProfile.workoutPlans.isEmpty
                                  ? null
                                  : _buildNumberDisplay(
                                      userPublicProfile.workoutPlans.length),
                            ],
                            handleTabChange: _changeTab,
                            activeTabIndex: _activeTabIndex),
                        SizedBox(height: 8),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: _changeTab,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              FilterableCreatedWorkouts(
                                allWorkouts: userPublicProfile.workouts,
                                selectWorkout: (workoutId) =>
                                    context.navigateTo(
                                        WorkoutDetailsRoute(id: workoutId)),
                              ),
                              FilterableCreatedWorkoutPlans(
                                allWorkoutPlans: userPublicProfile.workoutPlans,
                                selectWorkoutPlan: (workoutPlanId) =>
                                    context.navigateTo(WorkoutPlanDetailsRoute(
                                        id: workoutPlanId)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )));
        });
  }
}

class _HeaderContent extends StatelessWidget {
  final UserPublicProfile userPublicProfile;
  final double avatarSize;
  const _HeaderContent(
      {Key? key, required this.userPublicProfile, this.avatarSize = 100})
      : super(key: key);

  final kButtonIconSize = 14.0;
  final verticalPadding = const EdgeInsets.symmetric(vertical: 6.0);

  @override
  Widget build(BuildContext context) {
    final hasSocialLinks = [
      userPublicProfile.youtubeUrl,
      userPublicProfile.instagramUrl,
      userPublicProfile.tiktokUrl,
      userPublicProfile.linkedinUrl,
      userPublicProfile.snapUrl,
    ].any((l) => l != null);

    return Padding(
      padding: EdgeInsets.only(top: avatarSize / 2),
      child: Card(
          padding: EdgeInsets.only(
              top: avatarSize / 2, left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 8),
              Padding(
                padding: verticalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      userPublicProfile.displayName,
                      size: FONTSIZE.BIG,
                    ),
                    if (userPublicProfile.countryCode != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CountryFlag(userPublicProfile.countryCode!, 34),
                      ),
                  ],
                ),
              ),
              if (Utils.textNotNull(userPublicProfile.tagline))
                Padding(
                  padding: verticalPadding,
                  child: MyText(
                    userPublicProfile.tagline!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    color: Styles.infoBlue,
                  ),
                ),
              if (Utils.textNotNull(userPublicProfile.countryCode) ||
                  Utils.textNotNull(userPublicProfile.townCity))
                Padding(
                  padding: verticalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (Utils.textNotNull(userPublicProfile.countryCode))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyText(Country.fromIsoCode(
                                  userPublicProfile.countryCode!)
                              .name),
                        ),
                      if (Utils.textNotNull(userPublicProfile.countryCode) &&
                          Utils.textNotNull(userPublicProfile.townCity))
                        Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.theme.primary.withOpacity(0.6),
                            )),
                      if (Utils.textNotNull(userPublicProfile.townCity))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyText(
                            userPublicProfile.townCity!,
                          ),
                        ),
                    ],
                  ),
                ),
              Padding(
                padding: verticalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BorderButton(
                      mini: true,
                      text: 'Connect',
                      prefix: Icon(
                        CupertinoIcons.person_crop_circle_badge_plus,
                        size: kButtonIconSize,
                      ),
                      onPressed: () => print('connect'),
                    ),
                    BorderButton(
                      mini: true,
                      text: 'Message',
                      prefix: Icon(
                        CupertinoIcons.mail,
                        size: kButtonIconSize,
                      ),
                      onPressed: () => print('message'),
                    ),
                    BorderButton(
                      mini: true,
                      text: 'Save',
                      prefix: Icon(
                        CupertinoIcons.heart_circle,
                        size: kButtonIconSize,
                      ),
                      onPressed: () => print('save'),
                    ),
                  ],
                ),
              ),
              if (hasSocialLinks)
                Padding(
                  padding: verticalPadding,
                  child: _SocialMediaIcons(
                    userPublicProfile: userPublicProfile,
                  ),
                ),
              if (Utils.textNotNull(userPublicProfile.bio))
                Padding(
                  padding: verticalPadding,
                  child: Column(
                    children: [
                      MyText(
                        userPublicProfile.bio!,
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        lineHeight: 1.1,
                      ),

                      /// TODO: Only show [read more] if the content has overflowed.
                      TextButton(
                          text: 'More...',
                          underline: false,
                          onPressed: () => context.showBottomSheet(
                              useRootNavigator: true,
                              expand: true,
                              child: TextViewer(userPublicProfile.bio!, 'Bio')))
                    ],
                  ),
                ),
            ],
          )),
    );
  }
}

class _SocialMediaIcons extends StatelessWidget {
  final UserPublicProfile userPublicProfile;
  const _SocialMediaIcons({Key? key, required this.userPublicProfile})
      : super(key: key);

  void _handleOpenSocialUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (Utils.textNotNull(userPublicProfile.instagramUrl))
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: InstagramIcon(),
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.instagramUrl!)),
        if (Utils.textNotNull(userPublicProfile.tiktokUrl))
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: TikTokIcon(),
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.tiktokUrl!)),
        if (Utils.textNotNull(userPublicProfile.snapUrl))
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: SnapIcon(),
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.snapUrl!)),
        if (Utils.textNotNull(userPublicProfile.linkedinUrl))
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: LinkedInIcon(),
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.linkedinUrl!)),
        if (Utils.textNotNull(userPublicProfile.youtubeUrl))
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: YouTubeIcon(),
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.youtubeUrl!)),
      ],
    );
  }
}
