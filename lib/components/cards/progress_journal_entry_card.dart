import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_thumbnail_player.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class ProgressJournalEntryCard extends StatelessWidget {
  final ProgressJournal parentJournal;
  final ProgressJournalEntry progressJournalEntry;
  ProgressJournalEntryCard(
      {required this.progressJournalEntry, required this.parentJournal});

  final kMaxScore = 10;

  double _calcOverallAverage() {
    final scores = [
      for (final s in [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.confidenceScore,
      ])
        if (s != null) s
    ];
    return scores.average;
  }

  bool _hasSubmittedScores() => [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.confidenceScore
      ].any((s) => s != null);

  List<Widget> _buildScoreIndicators() {
    final tags = ['Mood', 'Energy', 'Motivation', 'Confidence'];

    return [
      for (final s in [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.confidenceScore,
      ])
        if (s != null) s
    ]
        .mapIndexed((i, s) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3),
                  child: CircularPercentIndicator(
                    startAngle: 180,
                    backgroundColor: Styles.colorOne.withOpacity(0.35),
                    circularStrokeCap: CircularStrokeCap.round,
                    arcType: ArcType.HALF,
                    radius: 40.0,
                    lineWidth: 3.0,
                    percent: s / kMaxScore,
                    center: MyText(
                      s.toInt().toString(),
                      lineHeight: 1,
                      weight: FontWeight.bold,
                      size: FONTSIZE.SMALL,
                    ),
                    progressColor: Color.lerp(
                        kBadScoreColor, kGoodScoreColor, s / kMaxScore),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: MyText(
                    tags[i],
                    size: FONTSIZE.TINY,
                  ),
                ),
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        MyText(
                          progressJournalEntry.createdAt.compactDateString,
                          weight: FontWeight.bold,
                          color: Styles.infoBlue,
                        ),
                        if (progressJournalEntry.bodyweight != null)
                          MyText(
                            ' - ${progressJournalEntry.bodyweight!.stringMyDouble()} ${parentJournal.bodyweightUnit.display}',
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 8,
                    runSpacing: 8,
                    children: _buildScoreIndicators(),
                  )
                ],
              ),
              if (_hasSubmittedScores())
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CircularPercentIndicator(
                    startAngle: 180,
                    backgroundColor: Styles.colorOne.withOpacity(0.35),
                    circularStrokeCap: CircularStrokeCap.round,
                    radius: 60.0,
                    lineWidth: 9.0,
                    percent: _calcOverallAverage() / kMaxScore,
                    center: MyText(
                      _calcOverallAverage().toInt().toString(),
                      lineHeight: 1,
                      weight: FontWeight.bold,
                    ),
                    progressColor: Color.lerp(kBadScoreColor, kGoodScoreColor,
                        _calcOverallAverage() / kMaxScore),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (Utils.textNotNull(progressJournalEntry.note))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 6, right: 8),
                    child: MyText(
                      progressJournalEntry.note!,
                      maxLines: 4,
                      size: FONTSIZE.SMALL,
                      overflow: TextOverflow.ellipsis,
                      lineHeight: 1.3,
                    ),
                  ),
                ),
              if (Utils.textNotNull(progressJournalEntry.voiceNoteUri))
                AudioThumbnailPlayer(
                    displaySize: Size(56, 56),
                    iconData: CupertinoIcons.mic_fill,
                    audioUri: progressJournalEntry.voiceNoteUri!),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [],
          ),
        ],
      ),
    );
  }
}

/// Not being used in this widget anymore after Progress Photos functionality was moved to another module.
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
