import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/body_areas/targeted_body_areas_page_view.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/icons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:sofie_ui/components/media/video/video_thumbnail_player.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/workout/workout_set_display.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/data_type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.graphql.dart';
import 'package:sofie_ui/services/utils.dart';

class WorkoutDetailsSection extends StatelessWidget {
  final WorkoutSection workoutSection;
  final bool scrollable;
  final bool showMediaThumbs;
  final bool showSectionTypeTag;
  const WorkoutDetailsSection(this.workoutSection,
      {Key? key,
      this.scrollable = false,
      this.showMediaThumbs = true,
      this.showSectionTypeTag = true})
      : super(key: key);

  Size get _kthumbDisplaySize => const Size(64, 64);

  List<BodyAreaMoveScore> bodyAreaMoveScoresFromSection() {
    return workoutSection.workoutSets.fold(
        <BodyAreaMoveScore>[],
        (acum1, workoutSet) => [
              ...acum1,
              ...workoutSet.workoutMoves.fold(
                  <BodyAreaMoveScore>[],
                  (acum2, workoutMove) =>
                      [...acum2, ...workoutMove.move.bodyAreaMoveScores])
            ]);
  }

  @override
  Widget build(BuildContext context) {
    final sortedSets =
        workoutSection.workoutSets.sortedBy<num>((ws) => ws.sortPosition);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (showSectionTypeTag)
                WorkoutSectionTypeTag(
                  workoutSection: workoutSection,
                  fontSize: FONTSIZE.three,
                ),
            ],
          ),
          const SizedBox(height: 4),
          if (showMediaThumbs &&
              Utils.anyNotNull([
                workoutSection.introAudioUri,
                workoutSection.introVideoUri,
                workoutSection.classAudioUri,
                workoutSection.classVideoUri
              ]))
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (workoutSection.introVideoUri != null)
                    VideoThumbnailPlayer(
                        videoUri: workoutSection.introVideoUri,
                        videoThumbUri: workoutSection.introVideoThumbUri,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Intro'),
                  if (workoutSection.classVideoUri != null)
                    VideoThumbnailPlayer(
                        videoUri: workoutSection.classVideoUri,
                        videoThumbUri: workoutSection.classVideoThumbUri,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Class'),
                  if (workoutSection.introAudioUri != null)
                    AudioThumbnailPlayer(
                        audioUri: workoutSection.introAudioUri!,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Intro'),
                  if (workoutSection.classAudioUri != null)
                    AudioThumbnailPlayer(
                        audioUri: workoutSection.classAudioUri!,
                        displaySize: _kthumbDisplaySize,
                        tag: 'Class'),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (workoutSection.rounds > 1)
                  ContentBox(
                    child: NumberRoundsIcon(
                      rounds: workoutSection.rounds,
                      alignment: Axis.vertical,
                    ),
                  ),
                if (workoutSection.isAMRAP)
                  ContentBox(
                      child: CompactTimerIcon(
                          duration: Duration(seconds: workoutSection.timecap))),
                BorderButton(
                  mini: true,
                  prefix: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/body_areas/body_button.svg',
                        width: 54,
                        alignment: Alignment.topCenter,
                        color: context.theme.primary.withOpacity(0.3),
                      ),
                      const Icon(
                        CupertinoIcons.smallcircle_circle_fill,
                        color: Styles.infoBlue,
                        size: 30,
                      ),
                    ],
                  ),
                  withBorder: false,
                  onPressed: () => context.push(
                      child: TargetedBodyAreasPageView(
                        bodyAreaMoveScores: bodyAreaMoveScoresFromSection(),
                      ),
                      fullscreenDialog: true),
                ),
              ],
            ),
          ),
          if (Utils.textNotNull(workoutSection.note))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ViewMoreFullScreenTextBlock(
                  text: workoutSection.note!,
                  title: 'Section Note',
                  textAlign: TextAlign.center),
            ),
          if (sortedSets.isNotEmpty)
            Flexible(
              child: ListView(
                physics:
                    scrollable ? null : const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: sortedSets
                    .map((workoutSet) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: WorkoutSetDisplay(
                              workoutSet: workoutSet,
                              workoutSectionType:
                                  workoutSection.workoutSectionType),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
