import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class BenchmarkCard extends StatelessWidget {
  final UserBenchmark userBenchmark;
  BenchmarkCard(this.userBenchmark);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(userBenchmark.name),
    );
  }
}
