import 'package:flutter/cupertino.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/media/video/video_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class DoWorkoutOverviewPage extends StatelessWidget {
  const DoWorkoutOverviewPage({Key? key}) : super(key: key);

  void _handleExitRequest(BuildContext context) {
    context.read<DoWorkoutBloc>().pauseWorkout();

    context.showDialog(
        useRootNavigator: true,
        title: 'Leave the Workout?',
        barrierDismissible: true,
        actions: [
          CupertinoDialogAction(
              child: MyText('Leave without logging'),
              onPressed: () {
                context.pop(rootNavigator: true); // Dialog.
                context.popRoute(); // Do workout.
              }),
          CupertinoDialogAction(
              child: MyText('Log progress, then Leave'),
              onPressed: () {
                context.pop(rootNavigator: true); // Dialog.
                context.read<DoWorkoutBloc>().generatePartialLog();
              }),
          CupertinoDialogAction(
              child: MyText('Restart the workout'),
              onPressed: () {
                context.pop(rootNavigator: true); // Dialog.
                /// TODO:
                // _handleResetWorkout();
              }),
          CupertinoDialogAction(
              child: MyText('Cancel'),
              onPressed: () => context.pop(rootNavigator: true) // Dialog.,
              ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final workout = context.watch<DoWorkoutBloc>().workout;

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
          Column(
            children: [
              _IntroSummaryCard(
                workout: workout,
                handleExitRequest: () => _handleExitRequest(context),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemCount: workout.workoutSections.length,
                    itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: _WorkoutSectionSummary(
                              workoutSection: workout.workoutSections[i]),
                        )),
              ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     child: CustomScrollView(
              //       slivers: [
              //         SliverStickyHeader(
              //           header: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: PrimaryButton(
              //                 text: 'Do All',
              //                 onPressed: () => print('do all flow'),
              //                 prefixIconData: CupertinoIcons.play_circle),
              //           ),
              //           sliver: SliverPadding(
              //             padding: const EdgeInsets.symmetric(vertical: 16),
              //             sliver: SliverList(
              //               delegate: SliverChildBuilderDelegate(
              //                 (c, i) => Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(vertical: 6.0),
              //                   child: _WorkoutSectionSummary(
              //                       workoutSection: workout.workoutSections[i]),
              //                 ),
              //                 childCount: workout.workoutSections.length,
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IntroSummaryCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback handleExitRequest;
  const _IntroSummaryCard(
      {Key? key, required this.workout, required this.handleExitRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = MediaQuery.of(context).padding.top;
    final headerRadius = Radius.circular(30);
    final kMediaThumbDisplaySize = Size(70.0, 70.0);

    return Container(
      padding: EdgeInsets.only(top: safeTopPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: headerRadius, bottomRight: headerRadius),
          color: context.theme.background.withOpacity(0.95)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            MyHeaderText(
              workout.name,
              maxLines: 2,
              size: FONTSIZE.LARGE,
              weight: FontWeight.normal,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _IntroSummaryCardIcon(
                    iconData: CupertinoIcons.clear_thick,
                    label: 'Quit',
                  ),
                  _IntroSummaryCardIcon(
                    iconData: CupertinoIcons.tv,
                    label: 'Video',
                  ),
                  _IntroSummaryCardIcon(
                    iconData: CupertinoIcons.waveform,
                    label: 'Audio',
                  ),
                  _IntroSummaryCardIcon(
                    iconData: CupertinoIcons.settings,
                    label: 'Settings',
                  ),
                  _IntroSummaryCardIcon(
                    iconData: CupertinoIcons.play_rectangle,
                    label: 'Do All',
                  ),
                ],
              ),
            ),

            // if (Utils.textNotNull(workout.description))
            //   Padding(
            //     padding: const EdgeInsets.only(bottom: 12.0),
            //     child: ViewMoreFullScreenTextBlock(
            //       text: workout.description!,
            //       title: workout.name,
            //     ),
            //   ),
            // if (Utils.anyNotNull([workout.introAudioUri, workout.introVideoUri]))
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         if (workout.introVideoUri != null)
            //           VideoThumbnailPlayer(
            //             videoUri: workout.introVideoUri,
            //             videoThumbUri: workout.introVideoThumbUri,
            //             displaySize: kMediaThumbDisplaySize,
            //             tag: 'Intro',
            //           ),
            //         if (workout.introAudioUri != null)
            //           AudioThumbnailPlayer(
            //             audioUri: workout.introAudioUri!,
            //             displaySize: kMediaThumbDisplaySize,
            //             playerTitle: '${workout.name} - Intro',
            //             tag: 'Intro',
            //           ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

class _IntroSummaryCardIcon extends StatelessWidget {
  final IconData iconData;
  final String label;
  const _IntroSummaryCardIcon(
      {Key? key, required this.iconData, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => print('open'),
      child: Column(
        children: [
          Icon(iconData),
          MyText(
            label,
            size: FONTSIZE.TINY,
          )
        ],
      ),
    );
  }
}

class _WorkoutSectionSummary extends StatelessWidget {
  final WorkoutSection workoutSection;
  const _WorkoutSectionSummary({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Equipment> uniqueEquipments = workoutSection.uniqueEquipments;

    return ContentBox(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      backgroundColor: Styles.greyOne.withOpacity(0.92),
      borderRadius: 26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WorkoutSectionTypeTag(
                workoutSection: workoutSection,
                fontSize: FONTSIZE.BIG,
                withBorder: false,
                fontColor: Styles.white,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => print('open'),
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.play_rectangle,
                      color: Styles.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (Utils.textNotNull(workoutSection.note))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ViewMoreFullScreenTextBlock(
                text: workoutSection.note!,
                title: 'Section Note',
                textColor: Styles.white,
                maxLines: 3,
              ),
            ),
          if (uniqueEquipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                spacing: 6,
                runSpacing: 4,
                children: uniqueEquipments
                    .map((e) => Tag(
                          tag: e.name,
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
