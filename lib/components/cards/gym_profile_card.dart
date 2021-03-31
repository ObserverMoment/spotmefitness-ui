import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions.dart';

class GymProfileCard extends StatelessWidget {
  final GymProfile gymProfile;
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
          MyText(
            gymProfile.name,
            weight: FontWeight.bold,
          ),
          if (gymProfile.description != null) MyText(gymProfile.description!),
          if (gymProfile.equipments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                height: 70,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: gymProfile.equipments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 70,
                            child: EquipmentTile(
                              equipment: gymProfile.equipments[index],
                              fontSize: FONTSIZE.TINY,
                              iconSize: 26,
                              withBorder: false,
                            ),
                          ),
                        )),
              ),
            ),
        ],
      ),
    );
  }
}
