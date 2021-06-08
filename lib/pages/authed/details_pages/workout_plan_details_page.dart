import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/menus/bottom_sheet_menu.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class WorkoutPlanDetailsPage extends StatefulWidget {
  final String id;
  WorkoutPlanDetailsPage({@PathParam('id') required this.id});

  @override
  _WorkoutPlanDetailsPageState createState() => _WorkoutPlanDetailsPageState();
}

class _WorkoutPlanDetailsPageState extends State<WorkoutPlanDetailsPage> {
  ScrollController _scrollController = ScrollController();

  /// 0 = Schedule List. 1 = Goals HeatMap / Calendar. 2 = Participants. 3 = reviews.
  int _activeTabIndex = 0;
  PageController _pageController = PageController();

  final _kthumbDisplaySize = Size(80, 80);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_activeTabIndex != _pageController.page!.round()) {
        setState(() {
          _activeTabIndex = _pageController.page!.round();
        });
      }
    });
  }

  void _handleTabChange(int index) {
    if (_pageController.page != index) {
      _pageController.jumpToPage(index);
    }
    setState(() => _activeTabIndex = index);
  }

  Widget _displayName(String text) => Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: MyText(text, weight: FontWeight.bold, size: FONTSIZE.SMALL),
      );

  Widget _buildAvatar(WorkoutPlan workoutPlan) {
    final radius = 40.0;

    return Row(
      children: [
        UserAvatar(
          avatarUri: workoutPlan.user.avatarUri,
          radius: radius,
        ),
        if (workoutPlan.user.displayName != '')
          _displayName(workoutPlan.user.displayName),
        if (workoutPlan.archived)
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                CupertinoIcons.archivebox,
                color: Styles.errorRed,
              ),
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = WorkoutPlanByIdQuery(
        variables: WorkoutPlanByIdArguments(id: widget.id));

    return QueryObserver<WorkoutPlanById$Query, WorkoutPlanByIdArguments>(
        key: Key('YourWorkoutPlansPage - ${query.operationName}-${widget.id}'),
        query: query,
        parameterizeQuery: true,
        loadingIndicator: ShimmerDetailsPage(title: 'Getting Ready'),
        builder: (data) {
          final workoutPlan = data.workoutPlanById;

          final String? authedUserId = GetIt.I<AuthBloc>().authedUser?.id;
          final bool isOwner = workoutPlan.user.id == authedUserId;

          return CupertinoPageScaffold(
            navigationBar: BorderlessNavBar(
              middle: NavBarTitle(workoutPlan.name),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.ellipsis_circle),
                onPressed: () => context.showBottomSheet(
                    child: BottomSheetMenu(
                        header: Row(
                          children: [
                            if (Utils.textNotNull(workoutPlan.coverImageUri))
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedUploadcareImage(
                                    workoutPlan.coverImageUri!,
                                    displaySize: Size(70, 70),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MyText(
                                    workoutPlan.name,
                                    weight: FontWeight.bold,
                                    size: FONTSIZE.BIG,
                                  ),
                                  MyText(
                                    'Workout Plan',
                                    subtext: true,
                                    weight: FontWeight.bold,
                                    size: FONTSIZE.BIG,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        items: [
                      BottomSheetMenuItem(
                          text: 'Share',
                          icon: Icon(CupertinoIcons.share),
                          onPressed: () => print('share')),
                      if (isOwner)
                        BottomSheetMenuItem(
                            text: 'Edit',
                            icon: Icon(CupertinoIcons.pencil),
                            onPressed: () => context.navigateTo(
                                WorkoutPlanCreatorRoute(
                                    workoutPlan: workoutPlan))),
                      BottomSheetMenuItem(
                          text: 'Export',
                          icon: Icon(CupertinoIcons.download_circle),
                          onPressed: () => print('export')),
                      if (isOwner)
                        BottomSheetMenuItem(
                            text:
                                workoutPlan.archived ? 'Unarchive' : 'Archive',
                            icon: Icon(
                              CupertinoIcons.archivebox,
                              color:
                                  workoutPlan.archived ? null : Styles.errorRed,
                            ),
                            isDestructive: !workoutPlan.archived,
                            onPressed: () => workoutPlan.archived
                                ? print('unarchive it')
                                : print('archive it')),
                    ])),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAvatar(workoutPlan),
                        Row(
                          children: [
                            DoItButton(onPressed: () => print('join the plan')),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => print('save to collection'),
                                child: Icon(CupertinoIcons.heart)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  HorizontalLine(),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: workoutPlan.coverImageUri != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              context.theme.cardBackground
                                                  .withOpacity(0.2),
                                              BlendMode.dstATop),
                                          image: UploadcareImageProvider(
                                              workoutPlan.coverImageUri!))
                                      : null),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        DifficultyLevelTag(
                                            workoutPlan.calcDifficulty),
                                        Tag(
                                          tag: workoutPlan.lengthString,
                                        ),
                                        Tag(
                                          tag:
                                              '${workoutPlan.sessionsPerWeek} days / week',
                                        ),
                                        ...workoutPlan.workoutTags
                                            .map((t) => Tag(
                                                  tag: t.tag,
                                                  color: Styles.colorOne,
                                                  textColor: Styles.white,
                                                ))
                                      ].toList(),
                                    ),
                                  ),
                                  if (Utils.textNotNull(
                                      workoutPlan.description))
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MyText(
                                        workoutPlan.description!,
                                        maxLines: 10,
                                        lineHeight: 1.3,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  if (Utils.anyNotNull([
                                    workoutPlan.introAudioUri,
                                    workoutPlan.introVideoUri
                                  ]))
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12.0, top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (workoutPlan.introVideoUri != null)
                                            VideoThumbnailPlayer(
                                              videoUri:
                                                  workoutPlan.introVideoUri,
                                              videoThumbUri: workoutPlan
                                                  .introVideoThumbUri,
                                              displaySize: _kthumbDisplaySize,
                                            ),
                                          if (workoutPlan.introAudioUri != null)
                                            AudioThumbnailPlayer(
                                              audioUri:
                                                  workoutPlan.introAudioUri!,
                                              displaySize: _kthumbDisplaySize,
                                              playerTitle:
                                                  '${workoutPlan.name} - Intro',
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ])),
                        ];
                      },
                      body: Column(
                        children: [
                          HorizontalLine(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 8),
                              child: MyTabBarNav(
                                  titles: [
                                    'Workouts',
                                    'Goals',
                                    'Reviews',
                                    'Participants',
                                  ],
                                  handleTabChange: _handleTabChange,
                                  activeTabIndex: _activeTabIndex)),
                          Expanded(
                            child: PageView(
                                controller: _pageController,
                                children: [
                                  MyText('Schedule List'),
                                  MyText('Goals'),
                                  MyText('Reviews'),
                                  MyText('Participants'),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
