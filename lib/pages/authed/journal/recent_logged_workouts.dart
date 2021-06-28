import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/logged_workout_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class RecentLoggedWorkouts extends StatelessWidget {
  final kLoggedWorkoutCardHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    final query = UserLoggedWorkoutsQuery(
        variables: UserLoggedWorkoutsArguments(take: 20));

    return QueryObserver<UserLoggedWorkouts$Query, json.JsonSerializable>(
        key: Key('RecentLoggedWorkouts - ${query.operationName}'),
        query: query,
        fullScreenError: false,
        loadingIndicator: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: ShimmerCard(
                  height: kLoggedWorkoutCardHeight,
                ),
              ),
            ),
          ],
        ),
        builder: (data) {
          final logs = data.userLoggedWorkouts
              .sortedBy<DateTime>((l) => l.completedOn)
              .reversed
              .toList();

          return logs.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H2(
                            'Logs',
                          ),
                          TextButton(
                            onPressed: () =>
                                context.pushRoute(YourLoggedWorkoutsRoute()),
                            underline: false,
                            text: 'All',
                            suffix: Icon(CupertinoIcons.arrow_right_square),
                          )
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: kLoggedWorkoutCardHeight,
                        viewportFraction: 0.90,
                        enableInfiniteScroll: false,
                      ),
                      itemCount: logs.length + 1,
                      itemBuilder: (c, i, _) {
                        if (i == logs.length) {
                          return TextButton(
                            onPressed: () =>
                                context.pushRoute(YourLoggedWorkoutsRoute()),
                            underline: false,
                            text: 'View all',
                            suffix: Icon(CupertinoIcons.arrow_right_square),
                            fontSize: FONTSIZE.BIG,
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                                onTap: () => context.navigateTo(
                                    LoggedWorkoutDetailsRoute(id: logs[i].id)),
                                child: LoggedWorkoutCard(logs[i])),
                          );
                        }
                      },
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            'No recent logs',
                            subtext: true,
                          ),
                          CreateTextIconButton(
                              text: 'Add Log',
                              onPressed: () => print('open add log flow'))
                        ],
                      )),
                );
        });
  }
}
