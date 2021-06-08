import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutPlanReviewsSummary extends StatelessWidget {
  final List<WorkoutPlanReview> reviews;
  final double itemSize;
  final int itemCount;
  const WorkoutPlanReviewsSummary(
      {Key? key, required this.reviews, this.itemSize = 18, this.itemCount = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final average = reviews.averageBy((r) => r.score) ?? 0.0;
    return reviews.isEmpty
        ? MyText(
            'No reviews yet...',
            size: FONTSIZE.SMALL,
            subtext: true,
          )
        : Column(
            children: [
              Row(
                children: [
                  RatingBarIndicator(
                    rating: average,
                    itemBuilder: (context, index) => Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.amber.withOpacity(0.2),
                    itemCount: itemCount,
                    itemSize: itemSize,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  MyText(
                    average.stringMyDouble(),
                    size: FONTSIZE.BIG,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              MyText(
                'from ${reviews.length} reviews',
                size: FONTSIZE.TINY,
              )
            ],
          );
  }
}
