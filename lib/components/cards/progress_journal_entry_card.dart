import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ProgressJournalEntryCard extends StatelessWidget {
  final ProgressJournalEntry progressJournalEntry;
  ProgressJournalEntryCard(this.progressJournalEntry);

  void _openImageGallery() {}
  // void _openImageGallery() => Navigator.push(
  //     context,
  //     MaterialWithModalsPageRoute(
  //         builder: (context) => FullScreenImageGallery(
  //               widget.progressJournalEntry.progressPhotoUrls,
  //               pageTitle:
  //                   'Photos ${DateFormat.yMMMd('en_US').format(widget.progressJournalEntry.createdAt)}',
  //             )));

  bool _hasSubmittedScores() => [
        progressJournalEntry.moodScore,
        progressJournalEntry.energyScore,
        progressJournalEntry.motivationScore,
        progressJournalEntry.stressScore
      ].any((s) => s != null);

  @override
  Widget build(BuildContext context) {
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
                  onTap: _openImageGallery,
                  child: Container(
                    width: 100,
                    child: Column(
                      children: [
                        PhotoStackDisplay(
                          fileIds: progressJournalEntry.progressPhotoUris,
                          height: 90,
                          width: 90,
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
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        MyText(progressJournalEntry.moodScore.toString()),
                        MyText(progressJournalEntry.energyScore.toString()),
                        MyText(progressJournalEntry.motivationScore.toString()),
                        MyText(progressJournalEntry.stressScore.toString()),
                      ],
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
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: MyText(progressJournalEntry.voiceNoteUri!),
                ),
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
                  child: MyText('Score display'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ProgressJournalEntryListTile extends StatefulWidget {
//   final ProgressJournalEntry progressJournalEntry;
//   ProgressJournalEntryListTile(this.progressJournalEntry);

//   @override
//   _ProgressJournalEntryListTileState createState() =>
//       _ProgressJournalEntryListTileState();
// }

// class _ProgressJournalEntryListTileState
//     extends State<ProgressJournalEntryListTile> {
//   void _openViewEntryNotes() => showCupertinoModalBottomSheet(
//       context: context,
//       builder: (context) => FullPageTextViewer(
//             widget.progressJournalEntry.notes,
//           ));

//   void _openEntryImageGallery() => Navigator.push(
//       context,
//       MaterialWithModalsPageRoute(
//           builder: (context) => FullScreenImageGallery(
//                 widget.progressJournalEntry.progressPhotoUrls,
//                 pageTitle:
//                     'Photos ${DateFormat.yMMMd('en_US').format(widget.progressJournalEntry.createdAt)}',
//               )));

//   double _calcOverallScore() => [
//         widget.progressJournalEntry.moodScore,
//         widget.progressJournalEntry.energyScore,
//         widget.progressJournalEntry.motivationScore,
//         widget.progressJournalEntry.stressScore,
//       ].where((s) => s != null).average();

//   Widget _buildScoreDisplay(String name, double value, {Color color}) =>
//       Opacity(
//         opacity: value == null ? 0.25 : 1,
//         child: Container(
//           height: 30,
//           width: 110,
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//           decoration: BoxDecoration(
//             borderRadius: Styles.mediumRadius,
//             color: Styles.highlightThree.withOpacity(0.1),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 height: 22,
//                 decoration: BoxDecoration(
//                     border: value == null
//                         ? null
//                         : Border.all(color: color ?? Styles.infoBlue),
//                     borderRadius: Styles.sharpRadius),
//                 child: TinyText(
//                   value == null ? '-' : Utility.stringMyDouble(value),
//                   bold: value != null,
//                   subtext: value == null,
//                   color: Styles.white,
//                 ),
//               ),
//               SizedBox(width: 6),
//               TinyText(
//                 name,
//                 bold: value != null,
//               )
//             ],
//           ),
//         ),
//       );

//   bool _hasSubmittedScores() => [
//         widget.progressJournalEntry.moodScore,
//         widget.progressJournalEntry.energyScore,
//         widget.progressJournalEntry.motivationScore,
//         widget.progressJournalEntry.stressScore
//       ].any((s) => s != null);

//   @override
//   Widget build(BuildContext context) {
//     final int _numPhotos = widget.progressJournalEntry.progressPhotoUrls.length;
//     return MyCard(
//         padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
//         child: );
//   }
// }

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
