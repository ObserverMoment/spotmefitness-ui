import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';

class ClubDetailsContent extends StatelessWidget {
  final Club club;
  const ClubDetailsContent({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageLink(linkText: 'Workouts (x)', onPress: () => {}),
          PageLink(linkText: 'Plans (x)', onPress: () => {}),
          PageLink(linkText: 'Challenges (x)', onPress: () => {}),
        ],
      ),
    );
  }
}
