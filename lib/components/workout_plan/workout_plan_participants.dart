import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/participant_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutPlanParticipants extends StatelessWidget {
  final List<UserSummary> userSummaries;
  const WorkoutPlanParticipants({Key? key, required this.userSummaries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: userSummaries.isEmpty
          ? Center(
              child: MyText(
              'No participants yet',
              subtext: true,
            ))
          : ListView.builder(
              itemCount: userSummaries.length,
              itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ParticipantCard(userSummary: userSummaries[i]),
                  )),
    );
  }
}
