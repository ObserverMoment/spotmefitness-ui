import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

class BenchmarkDetailsPage extends StatelessWidget {
  final String id;
  BenchmarkDetailsPage({@PathParam('id') required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText('BenchmarkDetailsPage'),
    );
  }
}
