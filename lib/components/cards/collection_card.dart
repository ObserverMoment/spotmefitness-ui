import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:collection/collection.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  const CollectionCard({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planWithImage = collection.workoutPlans
        .firstWhereOrNull((wp) => Utils.textNotNull(wp.coverImageUri));

    final workoutWithImage = planWithImage != null
        ? null
        : collection.workouts
            .firstWhereOrNull((w) => Utils.textNotNull(w.coverImageUri));

    final selectedImageUri = planWithImage != null
        ? planWithImage.coverImageUri
        : workoutWithImage != null
            ? workoutWithImage.coverImageUri
            : null;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 80,
            width: 80,
            child: selectedImageUri != null
                ? SizedUploadcareImage(selectedImageUri)
                : Image.asset(
                    'assets/home_page_images/home_page_collections.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyHeaderText(
                collection.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                lineHeight: 1.4,
              ),
              if (Utils.textNotNull(
                collection.description,
              ))
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        collection.description!,
                        maxLines: 2,
                        lineHeight: 1.3,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 6),
              Wrap(
                spacing: 10,
                runSpacing: 6,
                children: [
                  MyText(
                    '${collection.workouts.length} ${collection.workouts.length == 1 ? "workout" : "workouts"}',
                    color: Styles.colorTwo,
                  ),
                  MyText(
                    '${collection.workoutPlans.length} ${collection.workoutPlans.length == 1 ? "plan" : "plans"}',
                    color: Styles.colorTwo,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
