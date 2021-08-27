import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ClubDetailsContent extends StatelessWidget {
  final Club club;
  const ClubDetailsContent({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageLink(linkText: 'Workouts (x)', bold: true, onPress: () => {}),
          PageLink(linkText: 'Plans (x)', bold: true, onPress: () => {}),
          PageLink(linkText: 'Challenges (x)', bold: true, onPress: () => {}),
        ],
      ),
    );
  }
}
