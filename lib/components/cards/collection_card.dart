import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final Color? backgroundColor;
  const CollectionCard(
      {Key? key, required this.collection, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planWithImage = collection.workoutPlans
        .firstWhereOrNull((wp) => wp.coverImageUri != null);

    final workoutWithImage = planWithImage != null
        ? null
        : collection.workouts.firstWhereOrNull((w) => w.coverImageUri != null);

    final selectedImageUri = planWithImage != null
        ? planWithImage.coverImageUri
        : workoutWithImage != null
            ? workoutWithImage.coverImageUri
            : null;

    return Card(
      backgroundImageUri: selectedImageUri,
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: MyHeaderText(
              collection.name,
              maxLines: 2,
              size: FONTSIZE.BIG,
              textAlign: TextAlign.center,
            ),
          ),
          if (Utils.textNotNull(
            collection.description,
          ))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: MyText(
                collection.description!,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: MyText(
              '${collection.workouts.length} ${collection.workouts.length == 1 ? "workout" : "workouts"}',
              color: Styles.colorTwo,
              weight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: MyText(
              '${collection.workoutPlans.length} ${collection.workoutPlans.length == 1 ? "plan" : "plans"}',
              color: Styles.colorTwo,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
