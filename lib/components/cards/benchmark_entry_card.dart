import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class BenchmarkEntryCard extends StatelessWidget {
  final UserBenchmarkEntry entry;
  BenchmarkEntryCard(this.entry);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText('BenchmarkEntryCard'),
    );
  }
}
