import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/data_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return MyText(
      DataUtils.buildBenchmarkEntryScoreText(benchmark, entry),
      size: fontSize,
      weight: fontWeight,
    );
  }
}
