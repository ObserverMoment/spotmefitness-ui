import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class BenchmarkEntryCard extends StatelessWidget {
  final UserBenchmarkEntry entry;
  BenchmarkEntryCard(this.entry);
  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  MyText(entry.completedOn.dateString),
                  MyText(entry.score.toString()),
                ],
              ),
              Row(
                children: [
                  MyText('video '),
                ],
              )
            ],
          ),
          if (Utils.textNotNull(entry.note)) MyText(entry.note!),
        ],
      ),
    );
  }
}
