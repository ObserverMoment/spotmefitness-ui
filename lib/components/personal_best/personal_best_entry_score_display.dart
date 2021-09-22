import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/data_utils.dart';

class PersonalBestEntryScoreDisplay extends StatelessWidget {
  final UserBenchmarkEntry entry;
  final UserBenchmark benchmark;
  final FONTSIZE fontSize;
  final FontWeight fontWeight;
  const PersonalBestEntryScoreDisplay(
      {Key? key,
      required this.entry,
      required this.benchmark,
      this.fontSize = FONTSIZE.three,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyText(
      DataUtils.buildBenchmarkEntryScoreText(benchmark, entry),
      size: fontSize,
      weight: fontWeight,
    );
  }
}
