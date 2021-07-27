import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class BodyweightTrackerChart extends StatelessWidget {
  final ProgressJournal journal;
  BodyweightTrackerChart({Key? key, required this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstRecordedBodyweight = journal.progressJournalEntries
        .firstWhere((e) => e.bodyweight != null)
        .bodyweight;

    final minBodyweight = journal.progressJournalEntries.fold<double>(
        firstRecordedBodyweight ?? 0.0,
        (lowest, next) =>
            next.bodyweight == null ? lowest : min(lowest, next.bodyweight!));

    final maxBodyweight = journal.progressJournalEntries.fold<double>(
        firstRecordedBodyweight ?? 0.0,
        (highest, next) =>
            next.bodyweight == null ? highest : max(highest, next.bodyweight!));

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              'Bodyweight Tracker',
              weight: FontWeight.bold,
            ),
            if (firstRecordedBodyweight != null)
              BorderButton(
                  mini: true,
                  prefix: Icon(CupertinoIcons.fullscreen, size: 20),
                  onPressed: () => print('open full screen')),
          ],
        ),
      ),
      SizedBox(height: 12),
      MyText(
        'Bodyweight in ${journal.progressJournalEntries[0].bodyweightUnit.display}',
        size: FONTSIZE.SMALL,
      ),
      firstRecordedBodyweight == null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyText(
                'No bodyweight entries recorded.',
                maxLines: 3,
                subtext: true,
              ),
            )
          : SfCartesianChart(
              plotAreaBorderWidth: 0,
              enableAxisAnimation: true,
              primaryXAxis:
                  DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
              legend: Legend(),
              primaryYAxis: NumericAxis(
                  minimum: max(minBodyweight - 10, 0),
                  maximum: maxBodyweight + 10,
                  majorGridLines: MajorGridLines(width: 0)),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
                enablePinching: true,
                zoomMode: ZoomMode.x,
              ),
              series: [
                  LineSeries<ProgressJournalEntry, DateTime>(
                    color: Styles.infoBlue,
                    width: 3,
                    emptyPointSettings:
                        EmptyPointSettings(mode: EmptyPointMode.average),
                    dataSource: journal.progressJournalEntries,
                    xValueMapper: (ProgressJournalEntry e, _) => e.createdAt,
                    yValueMapper: (ProgressJournalEntry e, _) => e.bodyweight,
                  ),
                ]),
      SizedBox(height: 12),
    ]);
  }
}
