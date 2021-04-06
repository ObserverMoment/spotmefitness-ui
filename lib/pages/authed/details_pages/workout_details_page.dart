import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/body_areas/targeted_body_areas.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/media/text_viewer.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:collection/collection.dart';

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

  Widget _buildAvatar(WorkoutById workout) {
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

  List<String> _sectionTitles(WorkoutById workout) {
    return workout.workoutSections
        .map((ws) => ws.name ?? 'Section ${(ws.sortPosition + 1).toString()}')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: WorkoutByIdQuery().document,
            variables: {'id': widget.id}),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final WorkoutById workout =
                  WorkoutById$Query.fromJson(result.data ?? {}).workoutById;
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: NavBarTitle(workout.name),
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
                        if (workout.workoutGoals.isNotEmpty ||
                            workout.workoutTags.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    DifficultyLevelTag(workout.difficultyLevel),
                                    ...workout.workoutGoals
                                        .map((g) => Tag(tag: g.name)),
                                    ...workout.workoutTags
                                        .map((t) => Tag(tag: t.tag))
                                  ].toList(),
                                ),
                              ],
                            ),
                          ),
                        if (Utils.textNotNull(workout.description))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyText(
                              workout.description!,
                              maxLines: 10,
                              lineHeight: 1.3,
                            ),
                          ),
                        if (Utils.anyNotNull(
                            [workout.introAudioUri, workout.introVideoUri]))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (workout.introVideoUri != null)
                                MyText('Intro Video'),
                              if (workout.introAudioUri != null)
                                MyText('Intro Intro Audio')
                            ],
                          ),
                        HorizontalLine(),
                        if (workout.workoutSections.length > 1)
                          MyTabBarNav(
                              titles: _sectionTitles(workout),
                              handleTabChange: _handleTabChange,
                              activeTabIndex: activeSectionTabIndex)
                        else if (workout.workoutSections[0].name != null)
                          UnderlineTitle(workout.workoutSections[0].name!),
                        FadeIn(
                            key: Key(activeSectionTabIndex.toString()),
                            child: WorkoutDetailsSection(workout
                                .workoutSections[activeSectionTabIndex])),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class WorkoutDetailsSection extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool scrollable;
  WorkoutDetailsSection(this.workoutSection, {this.scrollable = false});

  Set<Equipment> _uniqueEquipments() =>
      workoutSection.workoutSets.fold({}, (acum1, workoutSet) {
        final Set<Equipment> setEquipments =
            workoutSet.workoutMoves.fold({}, (acum2, workoutMove) {
          if (workoutMove.equipment != null) {
            acum2.add(workoutMove.equipment!);
          }
          if (workoutMove.move.requiredEquipments.isNotEmpty) {
            acum2.addAll(workoutMove.move.requiredEquipments);
          }
          return acum2;
        });
        acum1.addAll(setEquipments);
        return acum1;
      });

  @override
  Widget build(BuildContext context) {
    final Set<Equipment> _allEquipments = _uniqueEquipments();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WorkoutSectionTypeTag(workoutSection.workoutSectionType.name,
                    timecap: workoutSection.timecap),
                MiniButton(
                  prefix: SvgPicture.asset(
                    'assets/body_areas/full_front.svg',
                    width: 28,
                    alignment: Alignment.topCenter,
                    height: 20,
                    fit: BoxFit.fitWidth,
                    color: context.theme.background,
                  ),
                  text: 'Body >',
                  onPressed: () => context.push(
                      child: CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                              middle: NavBarTitle('Targeted Body Areas')),
                          child: TargetedBodyAreas(bodyAreaScores: [])),
                      fullscreenDialog: true),
                ),
                if (Utils.textNotNull(workoutSection.notes))
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context.push(
                          child: TextViewer(workoutSection.notes!, 'Notes'),
                          fullscreenDialog: true),
                      child: Icon(CupertinoIcons.doc_text_search)),
              ],
            ),
          ),
          if (_allEquipments.isNotEmpty)
            Container(
              height: 34,
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _allEquipments.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: context.theme.primary
                                          .withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(4),
                                  color: context.theme.cardBackground),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                                  MyText(_allEquipments.elementAt(index).name),
                            ),
                          )),
                ],
              ),
            ),
          if (workoutSection.rounds > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberRoundsIcon(workoutSection.rounds),
                ],
              ),
            ),
          if (Utils.anyNotNull([
            workoutSection.introAudioUri,
            workoutSection.introVideoUri,
            workoutSection.classAudioUri,
            workoutSection.classVideoUri
          ]))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (workoutSection.introAudioUri != null) MyText('Intro Audio'),
                if (workoutSection.classAudioUri != null) MyText('Class Audio'),
                if (workoutSection.introVideoUri != null) MyText('Intro Video'),
                if (workoutSection.classVideoUri != null) MyText('Class Video'),
              ],
            ),
          ListView.builder(
              physics: scrollable ? null : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: workoutSection.workoutSets.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: WorkoutSetDisplay(workoutSection.workoutSets[index]),
                  ))
        ],
      ),
    );
  }
}

class WorkoutSetDisplay extends StatelessWidget {
  final WorkoutSet workoutSet;
  final bool scrollable;
  WorkoutSetDisplay(this.workoutSet, {this.scrollable = false});
  @override
  Widget build(BuildContext context) {
    final List<WorkoutMove> _sortedMoves =
        workoutSet.workoutMoves.sortedBy<num>((wm) => wm.sortPosition);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (workoutSet.rounds > 1)
                MyText('Repeat ${workoutSet.rounds} times'),
              if (Utils.textNotNull(workoutSet.notes))
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.push(
                        child: TextViewer(workoutSet.notes!, 'Notes'),
                        fullscreenDialog: true),
                    child: Icon(CupertinoIcons.doc_text_search)),
            ],
          ),
          ListView.builder(
              physics: scrollable ? null : NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _sortedMoves.length,
              itemBuilder: (context, index) => WorkoutMoveDisplay(
                    _sortedMoves[index],
                    isLast: index == _sortedMoves.length - 1,
                  ))
        ],
      ),
    );
  }
}

class WorkoutMoveDisplay extends StatelessWidget {
  final WorkoutMove workoutMove;
  final bool isLast;
  WorkoutMoveDisplay(this.workoutMove, {this.isLast = false});

  Widget _buildRepDisplay() {
    switch (workoutMove.repType) {
      case WorkoutMoveRepType.reps:
        return Column(
          children: [
            MyText(
              '${workoutMove.reps.toInt().toString()}',
              lineHeight: 1.2,
            ),
            MyText(
              'reps',
              size: FONTSIZE.TINY,
            ),
          ],
        );
      case WorkoutMoveRepType.calories:
        return Column(
          children: [
            MyText(
              '${workoutMove.reps.toInt().toString()}',
              lineHeight: 1.2,
            ),
            MyText(
              'calories',
              size: FONTSIZE.TINY,
            ),
          ],
        );
      case WorkoutMoveRepType.distance:
        return Column(
          children: [
            MyText(
              '${workoutMove.reps.roundMyDouble(2).toString()}',
              lineHeight: 1.2,
            ),
            MyText(
              workoutMove.distanceUnit.display,
              size: FONTSIZE.TINY,
            ),
          ],
        );
      case WorkoutMoveRepType.time:
        return Duration(seconds: workoutMove.reps.toInt())
            .display(direction: Axis.vertical);
      default:
        throw Exception('${workoutMove.repType} is not a valid rep type.');
    }
  }

  Widget _buildLoadDisplay() {
    return Column(
      children: [
        MyText(
          '${workoutMove.loadAmount!.roundMyDouble(2).toString()}',
          lineHeight: 1.2,
        ),
        MyText(
          workoutMove.loadUnit.display,
          size: FONTSIZE.TINY,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _equipmentNames = [
      if (Utils.textNotNull(workoutMove.equipment?.name))
        workoutMove.equipment!.name,
      ...workoutMove.move.requiredEquipments.map((e) => e.name).toList()
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                      color: context.theme.primary.withOpacity(0.06)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(workoutMove.move.name),
              Row(
                  children: _equipmentNames
                      .asMap()
                      .map((index, name) => MapEntry(
                          index,
                          MyText(
                            index == _equipmentNames.length - 1
                                ? name
                                : '$name, ',
                            size: FONTSIZE.SMALL,
                            color: Styles.colorTwo,
                          )))
                      .values
                      .toList())
            ],
          ),
          Row(
            children: [
              if (Utils.hasLoad(workoutMove.loadAmount)) _buildLoadDisplay(),
              if (Utils.hasLoad(workoutMove.loadAmount))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyText([
                    WorkoutMoveRepType.distance,
                    WorkoutMoveRepType.time
                  ].contains(workoutMove.repType)
                      ? 'for'
                      : 'x'),
                ),
              _buildRepDisplay(),
            ],
          )
        ],
      ),
    );
  }
}
