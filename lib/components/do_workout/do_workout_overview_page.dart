import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sofie_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/do_workout/do_workout_section_modifications.dart';
import 'package:sofie_ui/components/do_workout/do_workout_settings.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/audio/audio_players.dart';
import 'package:sofie_ui/components/media/video/uploadcare_video_player.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/extensions/enum_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/model/client_only_model.dart';
import 'package:sofie_ui/services/utils.dart';

class DoWorkoutOverview extends StatelessWidget {
  final VoidCallback handleExitRequest;

  /// Pass section index + 1 - because index 0 is the overview page.
  final void Function(int sectionIndex) navigateToSectionPage;
  final VoidCallback generateLog;
  const DoWorkoutOverview(
      {Key? key,
      required this.handleExitRequest,
      required this.navigateToSectionPage,
      required this.generateLog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutSections = context.select<DoWorkoutBloc, List<WorkoutSection>>(
        (b) => b.activeWorkout.workoutSections);

    final workout =
        context.select<DoWorkoutBloc, Workout>((b) => b.activeWorkout);

    final allSectionsComplete =
        context.select<DoWorkoutBloc, bool>((b) => b.allSectionsComplete);

    return CupertinoPageScaffold(
      child: Column(
        children: [
          _TopNavBar(
              handleExitRequest: handleExitRequest, generateLog: generateLog),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: _WorkoutIntroSummaryCard(
                      workout: workout,
                      allSectionsComplete: allSectionsComplete,
                      generateLog: generateLog),
                ),
                ...workoutSections
                    .map((workoutSection) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: _WorkoutSectionSummary(
                              workoutSection: workoutSection,
                              navigateToSectionPage: () =>
                                  navigateToSectionPage(
                                      workoutSection.sortPosition + 1)),
                        ))
                    .toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _WorkoutIntroSummaryCard extends StatelessWidget {
  final Workout workout;
  final bool allSectionsComplete;
  final VoidCallback generateLog;
  const _WorkoutIntroSummaryCard(
      {Key? key,
      required this.workout,
      required this.allSectionsComplete,
      required this.generateLog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentBox(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        backgroundColor: context.theme.cardBackground.withOpacity(0.97),
        borderRadius: 4,
        child: Column(
          children: [
            MyHeaderText(
              workout.name,
              maxLines: 2,
              size: FONTSIZE.five,
            ),
            const SizedBox(height: 10),
            if (Utils.textNotNull(workout.description))
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ViewMoreFullScreenTextBlock(
                  text: workout.description!,
                  title: workout.name,
                  textAlign: TextAlign.center,
                  fontSize: FONTSIZE.two,
                ),
              ),
            if (Utils.anyNotNull(
                [workout.introAudioUri, workout.introVideoUri]))
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (Utils.textNotNull(workout.introVideoUri))
                      _TopNavBarIcon(
                        iconData: CupertinoIcons.tv,
                        label: 'Intro Video',
                        onPressed: () =>
                            VideoSetupManager.openFullScreenVideoPlayer(
                                context: context,
                                videoUri: workout.introVideoUri!,
                                autoPlay: true,
                                autoLoop: true),
                      ),
                    if (Utils.textNotNull(workout.introAudioUri))
                      _TopNavBarIcon(
                        iconData: CupertinoIcons.waveform,
                        label: 'Intro Audio',
                        onPressed: () => AudioPlayerController.openAudioPlayer(
                            context: context,
                            audioUri: workout.introAudioUri!,
                            audioTitle: workout.name,
                            pageTitle: 'Intro Audio',
                            autoPlay: true),
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (allSectionsComplete)
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.0,
                          ),
                          child: MyText(
                            'All Sections Complete!',
                            size: FONTSIZE.four,
                            color: Styles.neonBlueOne,
                          ),
                        ),
                        MyButton(
                          backgroundColor: Styles.neonBlueOne,
                          contentColor: Styles.white,
                          withMinWidth: false,
                          onPressed: generateLog,
                          prefix: const Icon(CupertinoIcons.doc_text,
                              color: Styles.white),
                          text: 'Log Workout',
                        )
                      ],
                    )
                  else
                    MyButton(
                      contentColor: context.theme.primary,
                      backgroundGradient: Styles.neonBlueGradient,
                      withMinWidth: false,
                      onPressed: () => printLog(
                          'open section 1 and mark [do all] setting true'),
                      suffix: Icon(CupertinoIcons.play,
                          color: context.theme.primary),
                      text: 'Do All Sections',
                    ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _TopNavBar extends StatelessWidget {
  final VoidCallback handleExitRequest;
  final VoidCallback generateLog;
  const _TopNavBar(
      {Key? key, required this.handleExitRequest, required this.generateLog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: safeTopPadding),
      decoration:
          BoxDecoration(color: context.theme.background.withOpacity(0.85)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TopNavBarIcon(
              iconData: CupertinoIcons.clear_thick,
              label: 'Exit',
              onPressed: handleExitRequest,
            ),
            _TopNavBarIcon(
              iconData: CupertinoIcons.settings,
              label: 'Settings',
              onPressed: () => context.push(
                  fullscreenDialog: true, child: const DoWorkoutSettings()),
            ),
            _TopNavBarIcon(
              iconData: CupertinoIcons.doc_text,
              label: 'Log It',
              onPressed: generateLog,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopNavBarIcon extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onPressed;
  const _TopNavBarIcon({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.theme.cardBackground.withOpacity(0.8),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(iconData),
            const SizedBox(height: 2),
            MyText(label, size: FONTSIZE.one)
          ],
        ),
      ),
    );
  }
}

class _WorkoutSectionSummary extends StatelessWidget {
  final WorkoutSection workoutSection;
  final VoidCallback navigateToSectionPage;
  const _WorkoutSectionSummary(
      {Key? key,
      required this.workoutSection,
      required this.navigateToSectionPage})
      : super(key: key);

  Widget _buildSectionFooterButton(
      IconData iconData, String label, VoidCallback onPressed,
      {bool disabled = false}) {
    return AnimatedOpacity(
      duration: kStandardAnimationDuration,
      opacity: disabled ? 0.3 : 1,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: disabled ? null : onPressed,
        child: Column(
          children: [
            Row(
              children: [
                MyText(
                  label,
                  size: FONTSIZE.two,
                ),
                const SizedBox(width: 6),
                Icon(
                  iconData,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DoWorkoutBloc>();

    final isComplete = context.select<DoWorkoutBloc, bool>((b) =>
        b.getControllerForSection(workoutSection.sortPosition).sectionComplete);

    final hasStarted = context.select<DoWorkoutBloc, bool>((b) => b
        .getControllerForSection(workoutSection.sortPosition)
        .sectionHasStarted);

    final List<EquipmentWithLoad> equipmentsWithLoad =
        workoutSection.equipmentsWithLoad;

    return ContentBox(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      backgroundColor: context.theme.cardBackground.withOpacity(0.97),
      borderRadius: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WorkoutSectionTypeTag(
                    workoutSection: workoutSection,
                    fontSize: FONTSIZE.three,
                  ),
                  AnimatedSwitcher(
                    duration: kStandardAnimationDuration,
                    child: (!isComplete && hasStarted)
                        ? const Icon(
                            CupertinoIcons.pause_circle,
                            size: 30,
                            color: Styles.neonBlueOne,
                          )
                        : isComplete
                            ? const Icon(
                                CupertinoIcons.checkmark_alt_circle,
                                size: 30,
                                color: Styles.neonBlueOne,
                              )
                            : Container(),
                  ),
                ],
              ),
            ],
          ),
          if (Utils.textNotNull(workoutSection.name))
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: MyHeaderText(
                workoutSection.name!,
                size: FONTSIZE.four,
                weight: FontWeight.normal,
              ),
            ),
          if (Utils.textNotNull(workoutSection.note))
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ViewMoreFullScreenTextBlock(
                text: workoutSection.note!,
                title: 'Section Note',
                maxLines: 3,
                textAlign: TextAlign.left,
              ),
            ),
          if (equipmentsWithLoad.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: equipmentsWithLoad
                    .sorted((a, b) {
                      if (a.equipment.name == b.equipment.name) {
                        return (a.loadAmount ?? 0).compareTo(b.loadAmount ?? 0);
                      } else {
                        return a.equipment.name.compareTo(b.equipment.name);
                      }
                    })
                    .map((e) => _EquipmentWithLoadTag(
                          equipmentWithLoad: e,
                        ))
                    .toList(),
              ),
            ),
          const HorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSectionFooterButton(
                  CupertinoIcons.list_bullet,
                  'View / Modify',
                  () => Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>
                            ChangeNotifierProvider<DoWorkoutBloc>.value(
                          value: bloc,
                          child: DoWorkoutSectionModifications(
                              sectionIndex: workoutSection.sortPosition),
                        ),
                      ))),
              _buildSectionFooterButton(
                  CupertinoIcons.play, 'Do It', navigateToSectionPage,
                  disabled: isComplete),
            ],
          ),
        ],
      ),
    );
  }
}

class _EquipmentWithLoadTag extends StatelessWidget {
  final EquipmentWithLoad equipmentWithLoad;
  const _EquipmentWithLoadTag({Key? key, required this.equipmentWithLoad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = equipmentWithLoad.equipment.name;
    final isDumbbells = name == 'Dumbbells (Double)';
    final isKettleBells = name == 'Kettlebells (Double)';

    final individualLoadAmount = isDumbbells || isKettleBells
        ? (equipmentWithLoad.loadAmount! / 2)
        : equipmentWithLoad.loadAmount;

    final textColor = context.theme.background;
    const fontSize = FONTSIZE.two;

    return ContentBox(
      backgroundColor: context.theme.primary,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      borderRadius: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (individualLoadAmount != null)
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Row(
                children: [
                  MyText(
                    individualLoadAmount.stringMyDouble(),
                    color: textColor,
                    size: fontSize,
                  ),
                  MyText(
                    equipmentWithLoad.loadUnit.display,
                    color: textColor,
                    size: fontSize,
                  ),
                ],
              ),
            ),
          MyText(
            isDumbbells
                ? 'Dumbbell x 2'
                : isKettleBells
                    ? 'Kettlebell x 2'
                    : name,
            color: textColor,
            size: fontSize,
          ),
        ],
      ),
    );
  }
}
