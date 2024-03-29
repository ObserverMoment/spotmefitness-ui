import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/images/image_viewer.dart';
import 'package:sofie_ui/components/media/images/user_avatar.dart';
import 'package:sofie_ui/components/media/video/uploadcare_video_player.dart';
import 'package:sofie_ui/components/navigation.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/country.dart';
import 'package:sofie_ui/pages/authed/home/your_plans/your_created_workout_plans.dart';
import 'package:sofie_ui/pages/authed/home/your_workouts/your_created_workouts.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/sharing_and_linking.dart';
import 'package:sofie_ui/services/store/query_observer.dart';
import 'package:sofie_ui/services/stream.dart';
import 'package:sofie_ui/services/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPublicProfileDetailsPage extends StatefulWidget {
  final String userId;
  const UserPublicProfileDetailsPage(
      {Key? key, @PathParam('userId') required this.userId})
      : super(key: key);

  @override
  _UserPublicProfileDetailsPageState createState() =>
      _UserPublicProfileDetailsPageState();
}

class _UserPublicProfileDetailsPageState
    extends State<UserPublicProfileDetailsPage> {
  int _activeTabIndex = 0;
  late PageController _pageController;
  late ScrollController _scrollController;

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
    await SharingAndLinking.shareLink(
        'profile/${userPublicProfile.id}', 'Check out this profile!');
  }

  /// Top right of tabs to indicate how many of each type are in the list.
  Widget _buildNumberDisplay(int number) {
    return Positioned(
      top: 0,
      right: 8,
      child: MyText(
        number.toString(),
        size: FONTSIZE.two,
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
        loadingIndicator: const ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;
          final bool isAuthedUserProfile = authedUserId == widget.userId;
          final userPublicProfile = data.userPublicProfileById;

          return MyPageScaffold(
              navigationBar: MyNavBar(
                middle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyHeaderText(
                      userPublicProfile.displayName,
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
                  child: const Icon(CupertinoIcons.ellipsis),
                  onPressed: () => openBottomSheetMenu(
                      context: context,
                      child: BottomSheetMenu(
                          header: BottomSheetMenuHeader(
                            name: userPublicProfile.displayName,
                            subtitle: 'Profile',
                            imageUri: userPublicProfile.avatarUri,
                          ),
                          items: [
                            BottomSheetMenuItem(
                                text: 'Share',
                                icon: const Icon(CupertinoIcons.paperplane),
                                onPressed: () =>
                                    _shareUserProfile(userPublicProfile)),
                            if (!isAuthedUserProfile)
                              BottomSheetMenuItem(
                                  text: 'Block',
                                  icon: const Icon(CupertinoIcons.nosign),
                                  onPressed: () => printLog('block')),
                            if (!isAuthedUserProfile)
                              BottomSheetMenuItem(
                                  text: 'Report',
                                  icon: const Icon(
                                      CupertinoIcons.exclamationmark_circle),
                                  onPressed: () => printLog('report')),
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
                                  isAuthedUserProfile: isAuthedUserProfile,
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
                      children: [
                        MyTabBarNav(
                            titles: const [
                              'Workouts',
                              'Plans',
                              'Posts',
                            ],
                            superscriptIcons: [
                              if (userPublicProfile.workouts.isEmpty)
                                null
                              else
                                _buildNumberDisplay(
                                    userPublicProfile.workouts.length),
                              if (userPublicProfile.workoutPlans.isEmpty)
                                null
                              else
                                _buildNumberDisplay(
                                    userPublicProfile.workoutPlans.length),
                              null,
                            ],
                            handleTabChange: _changeTab,
                            activeTabIndex: _activeTabIndex),
                        const SizedBox(height: 8),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: _changeTab,
                            physics: const NeverScrollableScrollPhysics(),
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
                              const Center(child: MyHeaderText('Coming soon!')),
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
  final bool isAuthedUserProfile;
  const _HeaderContent(
      {Key? key,
      required this.userPublicProfile,
      this.avatarSize = 100,
      required this.isAuthedUserProfile})
      : super(key: key);

  EdgeInsets get verticalPadding => const EdgeInsets.symmetric(vertical: 6.0);

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 10),
              if (Utils.textNotNull(userPublicProfile.countryCode) ||
                  Utils.textNotNull(userPublicProfile.townCity))
                Padding(
                  padding: verticalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
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
              if (!isAuthedUserProfile)
                Padding(
                  padding: verticalPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserFeedConnectionButton(
                        otherUserId: userPublicProfile.id,
                      ),
                      const SizedBox(width: 8),
                      BorderButton(
                        text: 'Message',
                        prefix: const Icon(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ViewMoreFullScreenTextBlock(
                      text: userPublicProfile.bio!, title: 'Bio'),
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

  Future<void> _handleOpenSocialUrl(String url) async {
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
          const Icon(CupertinoIcons.link, size: 16),
          const SizedBox(width: 6),
          MyText(
            url,
            size: FONTSIZE.two,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
