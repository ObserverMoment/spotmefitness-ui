import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/benchmark/benchmark_entry_score_display.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/video/video_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class BenchmarkEntryCard extends StatelessWidget {
  final UserBenchmarkEntry entry;
  final UserBenchmark benchmark;
  BenchmarkEntryCard({required this.entry, required this.benchmark});
  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BenchmarkEntryScoreDisplay(
                    benchmark: benchmark,
                    entry: entry,
                    fontSize: FONTSIZE.HUGE,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              if (Utils.textNotNull(entry.note))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: MyText(entry.note!),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              children: [
                MyText(
                  entry.completedOn.dateString,
                  color: Styles.infoBlue,
                  size: FONTSIZE.SMALL,
                ),
                SizedBox(height: 6),
                MyText(
                  entry.completedOn.timeString,
                  color: Styles.infoBlue,
                  size: FONTSIZE.SMALL,
                ),
              ],
            ),
          ),
          VideoUploader(
            displaySize: Size(60, 60),
            onUploadSuccess: (String videoUri, String videoThumbUri) {},
            removeVideo: () {},
          )
        ],
      ),
    );
  }
}
