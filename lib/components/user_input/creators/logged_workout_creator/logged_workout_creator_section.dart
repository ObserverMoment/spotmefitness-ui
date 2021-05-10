import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class LoggedWorkoutCreatorSection extends StatelessWidget {
  final List<CreateLoggedWorkoutSectionInLoggedWorkoutInput> sections;
  LoggedWorkoutCreatorSection(this.sections);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MyText('Duration'),
          MyText('AMRAPS?'),
          MyText('Structure - editable?'),
        ],
      ),
    );
  }
}
