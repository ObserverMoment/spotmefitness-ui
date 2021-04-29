import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String id;
  WorkoutDetailsPage({@PathParam('id') required this.id});

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  int _activeSectionTabIndex = 0;
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  final _kthumbDisplaySize = Size(80, 80);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_activeSectionTabIndex != _pageController.page!.round()) {
        setState(() {
          _activeSectionTabIndex = _pageController.page!.round();
        });
      }
    });
  }

  void _handleTabChange(int index) {
    if (_pageController.page != index) {
      _pageController.jumpToPage(index);
    }
    setState(() => _activeSectionTabIndex = index);
  }

  Widget _buildAvatar(Workout workout) {
    final radius = 40.0;

    Widget _displayName(String text) => Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: MyText(text, weight: FontWeight.bold, size: FONTSIZE.SMALL),
        );

    if (workout.contentAccessScope == ContentAccessScope.official) {
      return Row(
        children: [
          SpotMeAvatar(
            radius: radius,
          ),
          _displayName('By SpotMe')
        ],
      );
    } else if (workout.user?.avatarUri != null) {
      return Row(
        children: [
          UserAvatar(
            avatarUri: workout.user!.avatarUri!,
            radius: radius,
          ),
          if (workout.user!.displayName != '')
            _displayName('By ${workout.user!.displayName}')
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            CupertinoIcons.person,
            size: radius,
          ),
          _displayName('By Unknown')
        ],
      );
    }
  }

  List<String> _sectionTitles(List<WorkoutSection> sortedWorkoutSections) {
    return sortedWorkoutSections
        .map((ws) => ws.name ?? 'Section ${(ws.sortPosition + 1).toString()}')
        .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _queryVars = WorkoutByIdArguments(id: widget.id);
    return QueryResponseBuilder(
        options: QueryOptions(
            document: WorkoutByIdQuery(variables: _queryVars).document,
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            variables: _queryVars.toJson()),
        builder: (result, {fetchMore, refetch}) {
          final Workout workout =
              WorkoutById$Query.fromJson(result.data ?? {}).workoutById;

          final List<WorkoutSection> sortedWorkoutSections =
              workout.workoutSections.sortedBy<num>((ws) => ws.sortPosition);

          return CupertinoPageScaffold(
            navigationBar: BasicNavBar(
              middle: NavBarTitle(workout.name),
              trailing: Icon(CupertinoIcons.ellipsis),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAvatar(workout),
                        Row(
                          children: [
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => {},
                                child: Icon(CupertinoIcons.heart)),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => {},
                              child: Icon(CupertinoIcons.calendar),
                            ),
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
                                  image: workout.coverImageUri != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              context.theme.cardBackground
                                                  .withOpacity(0.2),
                                              BlendMode.dstATop),
                                          image: UploadcareImageProvider(
                                              workout.coverImageUri!))
                                      : null),
                              child: Column(
                                children: [
                                  if (workout.workoutGoals.isNotEmpty ||
                                      workout.workoutTags.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 5,
                                        runSpacing: 5,
                                        children: [
                                          DifficultyLevelTag(
                                              workout.difficultyLevel),
                                          ...workout.workoutGoals
                                              .map((g) => Tag(tag: g.name)),
                                          ...workout.workoutTags.map((t) => Tag(
                                                tag: t.tag,
                                                color: Styles.colorOne,
                                                textColor: Styles.white,
                                              ))
                                        ].toList(),
                                      ),
                                    ),
                                  if (Utils.textNotNull(workout.description))
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: MyText(
                                        workout.description!,
                                        maxLines: 10,
                                        lineHeight: 1.3,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  if (Utils.anyNotNull([
                                    workout.introAudioUri,
                                    workout.introVideoUri
                                  ]))
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 12.0, top: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (workout.introVideoUri != null)
                                            VideoThumbnailPlayer(
                                              videoUri: workout.introVideoUri,
                                              videoThumbUri:
                                                  workout.introVideoThumbUri,
                                              displaySize: _kthumbDisplaySize,
                                            ),
                                          if (workout.introAudioUri != null)
                                            AudioThumbnailPlayer(
                                              audioUri: workout.introAudioUri!,
                                              displaySize: _kthumbDisplaySize,
                                              playerTitle:
                                                  '${workout.name} - Intro',
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
                              child: workout.workoutSections.length > 1
                                  ? MyTabBarNav(
                                      titles:
                                          _sectionTitles(sortedWorkoutSections),
                                      handleTabChange: _handleTabChange,
                                      activeTabIndex: _activeSectionTabIndex)
                                  : UnderlineTitle(
                                      workout.workoutSections[0].name!)),
                          if (sortedWorkoutSections.isNotEmpty)
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                children: sortedWorkoutSections
                                    .map((ws) => SingleChildScrollView(
                                        child: WorkoutDetailsSection(ws)))
                                    .toList(),
                              ),
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
