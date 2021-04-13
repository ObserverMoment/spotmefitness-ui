import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/workout/workout_section_display.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final String id;
  WorkoutDetailsPage({@PathParam('id') required this.id});

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  int activeSectionTabIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void _handleTabChange(int index) {
    if (pageController.page != index) {
      pageController.jumpToPage(index);
    }
    setState(() => activeSectionTabIndex = index);
  }

  Widget _buildAvatar(WorkoutData workout) {
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
    } else if (workout.userInfo?.avatarUri != null) {
      return Row(
        children: [
          UserAvatar(
            avatarUri: workout.userInfo!.avatarUri!,
            radius: radius,
          ),
          if (workout.userInfo!.displayName != null &&
              workout.userInfo!.displayName != '')
            _displayName('By ${workout.userInfo!.displayName}')
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

  List<String> _sectionTitles(WorkoutData workout) {
    return workout.workoutSections
        .map((ws) => ws.name ?? 'Section ${(ws.sortPosition + 1).toString()}')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final _queryVars = WorkoutByIdArguments(id: widget.id);
    return Query(
        options: QueryOptions(
            document: WorkoutByIdQuery(variables: _queryVars).document,
            variables: _queryVars.toJson()),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final WorkoutData _workoutData =
                  WorkoutById$Query.fromJson(result.data ?? {}).workoutData;
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: NavBarTitle(_workoutData.name),
                  trailing: Icon(CupertinoIcons.ellipsis),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAvatar(_workoutData),
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
                        if (_workoutData.workoutGoals.isNotEmpty ||
                            _workoutData.workoutTags.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    DifficultyLevelTag(
                                        _workoutData.difficultyLevel),
                                    ..._workoutData.workoutGoals
                                        .map((g) => Tag(tag: g.name)),
                                    ..._workoutData.workoutTags
                                        .map((t) => Tag(tag: t.tag))
                                  ].toList(),
                                ),
                              ],
                            ),
                          ),
                        if (Utils.textNotNull(_workoutData.description))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyText(
                              _workoutData.description!,
                              maxLines: 10,
                              lineHeight: 1.3,
                            ),
                          ),
                        if (Utils.anyNotNull([
                          _workoutData.introAudioUri,
                          _workoutData.introVideoUri
                        ]))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (_workoutData.introVideoUri != null)
                                MyText('Intro Video'),
                              if (_workoutData.introAudioUri != null)
                                MyText('Intro Intro Audio')
                            ],
                          ),
                        HorizontalLine(),
                        if (_workoutData.workoutSections.length > 1)
                          MyTabBarNav(
                              titles: _sectionTitles(_workoutData),
                              handleTabChange: _handleTabChange,
                              activeTabIndex: activeSectionTabIndex)
                        else if (_workoutData.workoutSections[0].name != null)
                          UnderlineTitle(_workoutData.workoutSections[0].name!),
                        FadeIn(
                            key: Key(activeSectionTabIndex.toString()),
                            child: WorkoutDetailsSection(_workoutData
                                .workoutSections[activeSectionTabIndex])),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
