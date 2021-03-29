import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions.dart';

class GymProfileCard extends StatelessWidget {
  final GymProfiles$Query$GymProfile gymProfile;
  GymProfileCard({required this.gymProfile});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: context.theme.cardBackground,
          boxShadow: [Styles.cardBoxShadow],
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          MyText(gymProfile.name),
          if (gymProfile.description != null) MyText(gymProfile.description!),
          if (gymProfile.bodyweightOnly)
            MyText('No equipment - bodyweight only'),
          if (gymProfile.equipments?.isNotEmpty ?? false)
            MyText(gymProfile.equipments!.length.toString())
        ],
      ),
    );
  }
}
