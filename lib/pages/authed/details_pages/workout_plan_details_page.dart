import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

class WorkoutPlanDetailsPage extends StatelessWidget {
  final String id;
  WorkoutPlanDetailsPage({@PathParam('id') required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyText(id.toString()),
    );
  }
}
