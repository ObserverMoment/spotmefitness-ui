import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/full_screen_image_gallery.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ProgressJournalEntryCard extends StatelessWidget {
  final ProgressJournalEntry progressJournalEntry;
  ProgressJournalEntryCard(this.progressJournalEntry);

  final kMaxScore = 10;

  void _openImageGallery(BuildContext context) {
    context.push(
        child: FullScreenImageGallery(
      progressJournalEntry.progressPhotoUris,
      pageTitle: 'Progress Photos',
    ));
  }

  double _calcOverallScore() {
    final scores = [
      for (final s in [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.stressScore,
      ])
        if (s != null) s
    ];
    return scores.average;
  }

  bool _hasSubmittedScores() => [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.stressScore
      ].any((s) => s != null);

  List<Widget> _buildScoreIndicators() {
    final tags = ['Mood', 'Energy', 'Motivate', 'Stress'];
    final colors = [Styles.errorRed, Styles.infoBlue];
    return [
      for (final s in [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.stressScore,
      ])
        if (s != null) s
    ]
        .mapIndexed((i, s) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 3),
                  child: CircularPercentIndicator(
                    startAngle: 180,
                    backgroundColor: Styles.colorOne.withOpacity(0.35),
                    circularStrokeCap: CircularStrokeCap.round,
                    arcType: ArcType.HALF,
                    radius: 28.0,
                    lineWidth: 4.0,
                    percent: s / kMaxScore,
                    center: MyText(
                      s.toInt().toString(),
                      lineHeight: 1,
                      weight: FontWeight.bold,
                      size: FONTSIZE.SMALL,
                    ),
                    progressColor:
                        Color.lerp(colors[0], colors[1], s / kMaxScore),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  child: MyText(
                    tags[i],
                    size: FONTSIZE.TINY,
                    subtext: true,
                  ),
                ),
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final overall = _calcOverallScore();
    final int numPhotos = progressJournalEntry.progressPhotoUris.length;
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (progressJournalEntry.progressPhotoUris.isNotEmpty)
                GestureDetector(
                  onTap: () => _openImageGallery(context),
                  child: Container(
                    width: 90,
                    child: Column(
                      children: [
                        PhotoStackDisplay(
                          fileIds: progressJournalEntry.progressPhotoUris,
                          height: 80,
                          width: 80,
                        ),
                        MyText(
                          '${progressJournalEntry.progressPhotoUris.length} ${numPhotos == 1 ? "photo" : "photos"}',
                          size: FONTSIZE.TINY,
                          weight: FontWeight.bold,
                          subtext: true,
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      progressJournalEntry.createdAt.compactDateString,
                      weight: FontWeight.bold,
                      color: Styles.infoBlue,
                    ),
                    if (Utils.textNotNull(progressJournalEntry.note))
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 3),
                            child: MyText(
                              progressJournalEntry.note!,
                              maxLines: 2,
                              size: FONTSIZE.SMALL,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 8,
                      runSpacing: 8,
                      children: _buildScoreIndicators(),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (Utils.textNotNull(progressJournalEntry.voiceNoteUri))
                AudioThumbnailPlayer(
                    displaySize: Size(40, 40),
                    audioUri: progressJournalEntry.voiceNoteUri!),
              if (progressJournalEntry.bodyweight != null)
                MyText(
                  '${progressJournalEntry.bodyweight!.stringMyDouble()} kg',
                  weight: FontWeight.bold,
                ),
              if (Utils.textNotNull(progressJournalEntry.note))
                NoteIconViewerButton(progressJournalEntry.note!),
              if (_hasSubmittedScores())
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CircularPercentIndicator(
                    startAngle: 180,
                    backgroundColor: Styles.colorOne.withOpacity(0.35),
                    circularStrokeCap: CircularStrokeCap.round,
                    radius: 40.0,
                    lineWidth: 8.0,
                    percent: overall / kMaxScore,
                    center: MyText(
                      overall.toInt().toString(),
                      lineHeight: 1,
                      weight: FontWeight.bold,
                    ),
                    linearGradient: Styles.neonBlueGradient,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Something like this https://dribbble.com/shots/794208-Photo-Stack-UI-Sketch
class PhotoStackDisplay extends StatelessWidget {
  final List<String> fileIds;
  final double width;
  final double height;
  PhotoStackDisplay(
      {required this.fileIds, required this.width, required this.height});

  // Degree offset increases the deeper the stack.
  final int _degreeOffset = 5;
  final double _paddingPercent = 0.10;
  // Percent of total width - to scale the boxshadow
  final double _shadowConstant = 0.01;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * _paddingPercent,
            vertical: height * _paddingPercent),
        child: Stack(
          alignment: Alignment.center,
          children: fileIds
              .asMap()
              .map((index, String fileId) => MapEntry(
                  index,
                  Opacity(
                    opacity: max(0, 0.9 - (0.15 * index)),
                    child: Transform.rotate(
                        angle:
                            ((index.isEven ? index : -index) * _degreeOffset) *
                                pi /
                                180,
                        child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(width * _shadowConstant,
                                          width * _shadowConstant),
                                      blurRadius: width * _shadowConstant,
                                      color: Styles.black.withOpacity(0.5))
                                ]),
                            child: SizedUploadcareImage(
                              fileId,
                              displaySize: Size(width * 2, height * 2),
                            ))),
                  )))
              .values
              .toList()
              .reversed
              .toList(),
        ),
      ),
    );
  }
}
