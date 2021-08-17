import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screenshot/screenshot.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_created_workout_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_workouts/your_created_workouts.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/sharing_and_linking.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/stream.dart';
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
  ScreenshotController screenshotController = ScreenshotController();

  final kAvatarSize = 100.0;

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

  Future<void> _shareUserProfile(UserPublicProfile userPublicProfile) async {
    SharingAndLinking.shareImageRenderOfWidget(
        context: context,
        text: '${kDeepLinkSchema}profile/${userPublicProfile.id}',
        subject: 'Check out this profile!',
        widgetForImageCapture: SizedBox(
          height: 100,
          width: 100,
          child: userPublicProfile.avatarUri != null
              ? SizedUploadcareImage(
                  userPublicProfile.avatarUri!,
                  displaySize: Size(300, 300),
                )
              : SvgPicture.asset(
                  'assets/logos/spotme_logo.svg',
                  fit: BoxFit.cover,
                ),
        ));
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

          return MyPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyHeaderText(
                      userPublicProfile.displayName ?? 'Unnamed',
                    ),
                    if (userPublicProfile.countryCode != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: CountryFlag(userPublicProfile.countryCode!, 24),
                      ),
                  ],
                ),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(CupertinoIcons.ellipsis_circle),
                  onPressed: () => context.showBottomSheet(
                      child: BottomSheetMenu(
                          header: BottomSheetMenuHeader(
                            name: userPublicProfile.displayName ?? 'Unnamed',
                            subtitle: 'Profile',
                            imageUri: userPublicProfile.avatarUri,
                          ),
                          items: [
                        BottomSheetMenuItem(
                            text: 'Share',
                            icon: Icon(CupertinoIcons.paperplane),
                            onPressed: () =>
                                _shareUserProfile(userPublicProfile)),
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
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, bottom: 6),
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
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyTabBarNav(
                            titles: [
                              'Workouts',
                              'Plans',
                              'Posts',
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
                              null,
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
                              Center(child: MyHeaderText('Coming soon!')),
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

    final hasAvatar = Utils.textNotNull(userPublicProfile.avatarUri);

    return Padding(
      padding: EdgeInsets.only(top: hasAvatar ? avatarSize / 2 : 0),
      child: Card(
          padding: EdgeInsets.only(
              top: hasAvatar ? avatarSize / 2 : 8,
              left: 10,
              right: 10,
              bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 8),
              if (Utils.textNotNull(userPublicProfile.countryCode) ||
                  Utils.textNotNull(userPublicProfile.townCity))
                Padding(
                  padding: verticalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.location,
                        size: 20,
                      ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserFeedConnectionButton(
                      otherUserId: userPublicProfile.id,
                    ),
                    SizedBox(width: 8),
                    BorderButton(
                      text: 'Message',
                      prefix: Icon(
                        CupertinoIcons.chat_bubble_2,
                        size: 15,
                      ),
                      onPressed: () => context.navigateTo(OneToOneChatRoute(
                        otherUserId: userPublicProfile.id,
                      )),
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
                    weight: FontWeight.bold,
                  ),
                ),
              if (Utils.textNotNull(userPublicProfile.bio))
                GestureDetector(
                  onTap: () => context.showBottomSheet(
                      useRootNavigator: true,
                      expand: true,
                      child: TextViewer(userPublicProfile.bio!, 'Bio')),
                  child: Padding(
                    padding: verticalPadding,
                    child: Column(
                      children: [
                        MyText(
                          '${userPublicProfile.bio!}...',
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          lineHeight: 1.1,
                        ),
                      ],
                    ),
                  ),
                ),
              if (hasSocialLinks)
                Padding(
                  padding: verticalPadding,
                  child: _SocialMediaLinks(
                    userPublicProfile: userPublicProfile,
                  ),
                ),
            ],
          )),
    );
  }
}

class _SocialMediaLinks extends StatelessWidget {
  final UserPublicProfile userPublicProfile;
  const _SocialMediaLinks({Key? key, required this.userPublicProfile})
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        if (Utils.textNotNull(userPublicProfile.instagramUrl))
          _SocialLink(
              url: userPublicProfile.instagramUrl!,
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.instagramUrl!)),
        if (Utils.textNotNull(userPublicProfile.tiktokUrl))
          _SocialLink(
              url: userPublicProfile.tiktokUrl!,
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.tiktokUrl!)),
        if (Utils.textNotNull(userPublicProfile.snapUrl))
          _SocialLink(
              url: userPublicProfile.snapUrl!,
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.snapUrl!)),
        if (Utils.textNotNull(userPublicProfile.linkedinUrl))
          _SocialLink(
              url: userPublicProfile.linkedinUrl!,
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.linkedinUrl!)),
        if (Utils.textNotNull(userPublicProfile.youtubeUrl))
          _SocialLink(
              url: userPublicProfile.youtubeUrl!,
              onPressed: () =>
                  _handleOpenSocialUrl(userPublicProfile.youtubeUrl!)),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final String url;
  final VoidCallback onPressed;
  const _SocialLink({Key? key, required this.url, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.link, size: 16),
          SizedBox(width: 6),
          MyText(
            url,
            size: FONTSIZE.SMALL,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
