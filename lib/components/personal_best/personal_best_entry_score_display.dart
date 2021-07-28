import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class PersonalBestEntryScoreDisplay extends StatelessWidget {
  final UserBenchmarkEntry entry;
  final UserBenchmark benchmark;
  final FONTSIZE fontSize;
  final FontWeight fontWeight;
  PersonalBestEntryScoreDisplay(
      {required this.entry,
      required this.benchmark,
      this.fontSize = FONTSIZE.MAIN,
      this.fontWeight = FontWeight.normal});

  String _buildScoreText() {
    switch (benchmark.benchmarkType) {
      case BenchmarkType.maxload:
        return '${entry.score.stringMyDouble()}${benchmark.loadUnit.display}';
      case BenchmarkType.fastesttime:
      case BenchmarkType.unbrokentime:
        return Duration(seconds: entry.score.round()).compactDisplay();
      case BenchmarkType.amrap:
      case BenchmarkType.unbrokenreps:
        return '${entry.score.stringMyDouble()} reps';
      default:
        return entry.score.stringMyDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyText(
      _buildScoreText(),
      size: fontSize,
      weight: fontWeight,
    );
  }
}
