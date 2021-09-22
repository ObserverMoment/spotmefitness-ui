import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/cards/review_card.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:supercharged/supercharged.dart';

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
        if (dateSortedReviews.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: MyText(
                'No reviews yet',
                subtext: true,
              ),
            ),
          )
        else
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        average.stringMyDouble(),
                        size: FONTSIZE.four,
                      ),
                      MyText(
                        ' out of $itemCount',
                        size: FONTSIZE.four,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBarIndicator(
                    rating: average,
                    itemBuilder: (context, index) => const Icon(
                      CupertinoIcons.star_fill,
                      color: Styles.starGold,
                    ),
                    unratedColor: Styles.starGold.withOpacity(0.2),
                    itemCount: itemCount,
                    itemSize: itemSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: MyText('From ${dateSortedReviews.length} reviews'),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dateSortedReviews.length,
                      itemBuilder: (c, i) => Padding(
                            padding: const EdgeInsets.all(6.0),
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
