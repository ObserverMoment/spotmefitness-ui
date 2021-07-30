import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class GymProfileCard extends StatelessWidget {
  final GymProfile gymProfile;
  GymProfileCard({required this.gymProfile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          MyText(
            gymProfile.name,
            weight: FontWeight.bold,
            lineHeight: 1.5,
          ),
          if (gymProfile.description != null)
            MyText(
              gymProfile.description!,
              textAlign: TextAlign.center,
              maxLines: 3,
              lineHeight: 1.5,
            ),
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
