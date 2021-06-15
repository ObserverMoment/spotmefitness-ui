import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  const CollectionCard({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          MyText(collection.name),
          if (Utils.textNotNull(collection.description))
            MyText(collection.description!),
          MyText('${collection.workouts.length} workouts'),
          MyText('${collection.workoutPlans.length} workout plans'),
        ],
      ),
    );
  }
}
