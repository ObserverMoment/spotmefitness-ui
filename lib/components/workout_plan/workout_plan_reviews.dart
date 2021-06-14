import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
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
  const WorkoutPlanReviews({
    Key? key,
    required this.reviews,
    this.itemSize = 30,
    this.itemCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final average = reviews.averageBy((r) => r.score) ?? 0.0;
    final dateSortedReviews = reviews.sortedBy<DateTime>((r) => r.createdAt);

    return Column(
      children: [
        dateSortedReviews.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    'No reviews yet',
                    subtext: true,
                  ),
                ),
              )
            : Expanded(
                child: Column(
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
                        color: Styles.starGold,
                      ),
                      unratedColor: Styles.starGold.withOpacity(0.2),
                      itemCount: itemCount,
                      itemSize: itemSize,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: MyText('From ${dateSortedReviews.length} reviews'),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dateSortedReviews.length,
                          itemBuilder: (c, i) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: WorkoutPlanReviewCard(
                                  review: dateSortedReviews[i],
                                ),
                              )),
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
