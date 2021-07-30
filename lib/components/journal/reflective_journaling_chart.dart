import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

class ReflectiveJournalingChart extends StatefulWidget {
  final ProgressJournal journal;
  ReflectiveJournalingChart({Key? key, required this.journal})
      : super(key: key);

  @override
  _ReflectiveJournalingChartState createState() =>
      _ReflectiveJournalingChartState();
}

class _ReflectiveJournalingChartState extends State<ReflectiveJournalingChart> {
  bool _showMood = false;
  bool _showMotivation = false;
  bool _showEnergy = false;
  bool _showConfidence = false;
  bool _showAverage = true;

  final List<String> lineNames = const [
    'Mood',
    'Energy',
    'Motivation',
    'Confidence',
    'Average'
  ];

  final List<Color> legendColors = const [
    Styles.colorOne, // Mood
    Styles.colorTwo, // Energy
    Styles.colorThree, // Motivation
    Styles.colorFour, // Confidence
    Styles.infoBlue, // Average
  ];

  LineSeries _buildLine(List<_ScorePointData> data, int lineIndex) {
    return LineSeries<_ScorePointData, DateTime>(
        name: lineNames[lineIndex],
        color: legendColors[lineIndex],
        width: 4,
        emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.average),
        dataSource: data,
        enableTooltip: true,
        markerSettings: MarkerSettings(
          isVisible: true,
          height: 12,
          width: 12,
        ),
        xValueMapper: (_ScorePointData d, _) => d.dateTime,
        yValueMapper: (_ScorePointData d, _) => d.score);
  }

  List<ChartSeries> _buildLines() {
    final sortedEntries = widget.journal.progressJournalEntries
        .sortedBy<DateTime>((e) => e.createdAt);

    return <ChartSeries>[
      if (_showAverage)
        _buildLine(
            sortedEntries
                .map((e) =>
                    _ScorePointData(e.createdAt, _calcEntryScoreAverage(e)))
                .toList(),
            4),
      if (_showMood)
        _buildLine(
            sortedEntries
                .map((e) => _ScorePointData(e.createdAt, e.moodScore))
                .toList(),
            0),
      if (_showEnergy)
        _buildLine(
            sortedEntries
                .map((e) => _ScorePointData(e.createdAt, e.energyScore))
                .toList(),
            1),
      if (_showMotivation)
        _buildLine(
            sortedEntries
                .map((e) => _ScorePointData(e.createdAt, e.motivationScore))
                .toList(),
            2),
      if (_showConfidence)
        _buildLine(
            sortedEntries
                .map((e) => _ScorePointData(e.createdAt, e.confidenceScore))
                .toList(),
            3),
    ];
  }

  double? _calcEntryScoreAverage(ProgressJournalEntry entry) {
    final scores = [
      for (final s in [
        entry.moodScore,
        entry.energyScore,
        entry.motivationScore,
        entry.confidenceScore,
      ])
        if (s != null) s
    ];
    return scores.isNotEmpty ? scores.average : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              'Reflective Journaling Scores',
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      SfCartesianChart(
          plotAreaBorderWidth: 0,
          enableAxisAnimation: true,
          tooltipBehavior: TooltipBehavior(
              enable: true,
              duration: 6000,
              format: 'SCORE: point.y | point.x',
              decimalPlaces: 1,
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          primaryXAxis: DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 10,
              majorGridLines: MajorGridLines(width: 0)),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enablePinching: true,
            zoomMode: ZoomMode.x,
          ),
          series: _buildLines()),
      SizedBox(height: 8),
      Wrap(
          spacing: 12,
          runSpacing: 4,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            _ScoreChartLegendItem(
                color: legendColors[4],
                name: 'Average',
                isActive: _showAverage,
                onPressed: () => setState(() => _showAverage = !_showAverage)),
            _ScoreChartLegendItem(
                color: legendColors[0],
                name: 'Mood',
                isActive: _showMood,
                onPressed: () => setState(() => _showMood = !_showMood)),
            _ScoreChartLegendItem(
                color: legendColors[1],
                name: 'Energy',
                isActive: _showEnergy,
                onPressed: () => setState(() => _showEnergy = !_showEnergy)),
            _ScoreChartLegendItem(
                color: legendColors[2],
                name: 'Motivation',
                isActive: _showMotivation,
                onPressed: () =>
                    setState(() => _showMotivation = !_showMotivation)),
            _ScoreChartLegendItem(
                color: legendColors[3],
                name: 'Confidence',
                isActive: _showConfidence,
                onPressed: () =>
                    setState(() => _showConfidence = !_showConfidence)),
          ]),
    ]);
  }
}

class _ScorePointData {
  final double? score;
  final DateTime dateTime;
  const _ScorePointData(this.dateTime, this.score);
}

class _ScoreChartLegendItem extends StatelessWidget {
  final Color color;
  final String name;
  final bool isActive;
  final void Function() onPressed;
  const _ScoreChartLegendItem(
      {Key? key,
      required this.color,
      required this.name,
      required this.isActive,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: AnimatedOpacity(
        duration: kStandardAnimationDuration,
        opacity: isActive ? 1 : 0.6,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          decoration: BoxDecoration(
              border: Border.all(color: context.theme.primary),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6),
              MyText(
                name,
                size: FONTSIZE.SMALL,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
