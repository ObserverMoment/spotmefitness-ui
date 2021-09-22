import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/cards/participant_card.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class WorkoutPlanParticipants extends StatelessWidget {
  final List<UserSummary> userSummaries;
  const WorkoutPlanParticipants({Key? key, required this.userSummaries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: userSummaries.isEmpty
          ? const Center(
              child: MyText(
              'No participants yet',
              subtext: true,
            ))
          : ListView.builder(
              itemCount: userSummaries.length,
              itemBuilder: (c, i) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 4),
                    child: ParticipantCard(userSummary: userSummaries[i]),
                  )),
    );
  }
}
