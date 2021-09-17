import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/do_workout/do_workout_settings.dart';
import 'package:spotmefitness_ui/components/do_workout/view_workout_section_moves.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_players.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/video/uploadcare_video_player.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/client_only_model.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:collection/collection.dart';

class DoWorkoutOverview extends StatelessWidget {
  final VoidCallback handleExitRequest;

  /// Pass section index + 1 - because index 0 is the overview page.
  final void Function(int sectionIndex) navigateToSectionPage;
  const DoWorkoutOverview(
      {Key? key,
      required this.handleExitRequest,
      required this.navigateToSectionPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutSections = context.select<DoWorkoutBloc, List<WorkoutSection>>(
        (b) => b.activeWorkout.workoutSections);

    final workout =
        context.select<DoWorkoutBloc, Workout>((b) => b.activeWorkout);

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          SizedBox.expand(
            child: workout.coverImageUri != null
                ? SizedUploadcareImage(workout.coverImageUri!)
                : Image.asset(
                    'assets/home_page_images/home_page_workouts.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox.expand(
            child: Container(color: Styles.black.withOpacity(0.4)),
          ),
          Column(
            children: [
              _TopNavBar(
                handleExitRequest: handleExitRequest,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(14),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: _WorkoutIntroSummaryCard(
                        workout: workout,
                      ),
                    ),
                    ...workoutSections
                        .map((workoutSection) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
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
        ],
      ),
    );
  }
}

class _WorkoutIntroSummaryCard extends StatelessWidget {
  final Workout workout;
  const _WorkoutIntroSummaryCard({Key? key, required this.workout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentBox(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        backgroundColor: context.theme.cardBackground.withOpacity(0.97),
        borderRadius: 26,
        child: Column(
          children: [
            MyHeaderText(
              workout.name,
              maxLines: 2,
              size: FONTSIZE.LARGE,
              weight: FontWeight.normal,
            ),
            if (Utils.textNotNull(workout.description))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ViewMoreFullScreenTextBlock(
                  text: workout.description!,
                  title: workout.name,
                  textAlign: TextAlign.center,
                  fontSize: FONTSIZE.SMALL,
                ),
              ),
            if (Utils.anyNotNull(
                [workout.introAudioUri, workout.introVideoUri]))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  PrimaryButton(
                    withMinWidth: false,
                    onPressed: () =>
                        print('open section 1 and mark do all settings true'),
                    suffixIconData: CupertinoIcons.play,
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
  const _TopNavBar({Key? key, required this.handleExitRequest})
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
                  fullscreenDialog: true, child: DoWorkoutSettings()),
            ),
            _TopNavBarIcon(
              iconData: CupertinoIcons.plus_slash_minus,
              label: 'Modify',
              onPressed: () => print('open modifications'),
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
            SizedBox(height: 2),
            MyText(label, size: FONTSIZE.TINY)
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
      IconData iconData, String label, VoidCallback onPressed) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Column(
        children: [
          Row(
            children: [
              MyText(
                label,
                size: FONTSIZE.SMALL,
              ),
              SizedBox(width: 6),
              Icon(
                iconData,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DoWorkoutBloc>();

    final List<EquipmentWithLoad> equipmentsWithLoad =
        workoutSection.equipmentsWithLoad;

    return ContentBox(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      backgroundColor: context.theme.cardBackground.withOpacity(0.97),
      borderRadius: 26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 4),
                child: WorkoutSectionTypeTag(
                  workoutSection: workoutSection,
                  fontSize: FONTSIZE.MAIN,
                ),
              ),
            ],
          ),
          if (Utils.textNotNull(workoutSection.name))
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: MyHeaderText(
                workoutSection.name!,
                size: FONTSIZE.BIG,
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
              ),
            ),
          if (equipmentsWithLoad.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 4),
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
          HorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSectionFooterButton(
                  CupertinoIcons.list_bullet,
                  'View Moves',
                  () => Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>
                            ChangeNotifierProvider<DoWorkoutBloc>.value(
                          value: bloc,
                          child: ViewWorkoutSectionMoves(
                              sectionIndex: workoutSection.sortPosition),
                        ),
                      ))),
              _buildSectionFooterButton(
                  CupertinoIcons.play, 'Do Section', navigateToSectionPage),
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
    final fontSize = FONTSIZE.SMALL;

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
