import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotmefitness_ui/components/cards/review_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:collection/collection.dart';

class WorkoutPlanReviews extends StatelessWidget {
  final List<WorkoutPlanReview> reviews;
  final double itemSize;
  final int itemCount;
  const WorkoutPlanReviews(
      {Key? key, required this.reviews, this.itemSize = 30, this.itemCount = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final average = reviews.averageBy((r) => r.score) ?? 0.0;
    final dateSortedReviews = reviews.sortedBy<DateTime>((r) => r.createdAt);
    return reviews.isEmpty
        ? Center(
            child: MyText(
              'No reviews yet...',
              size: FONTSIZE.SMALL,
              subtext: true,
            ),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  H1('${average.stringMyDouble()}'),
                  H3(' out of $itemCount'),
                ],
              ),
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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyText('From ${reviews.length} reviews'),
              ),
              Expanded(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reviews.length,
                    itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: WorkoutPlanReviewCard(
                            review: reviews[i],
                          ),
                        )),
              )
            ],
          );
  }
}
