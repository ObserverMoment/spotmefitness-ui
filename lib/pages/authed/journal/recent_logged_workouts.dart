import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_workout_card.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';

class RecentLoggedWorkouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserLoggedWorkouts$Query, json.JsonSerializable>(
        key: Key(
            'RecentLoggedWorkouts - ${UserLoggedWorkoutsQuery().operationName}'),
        query: UserLoggedWorkoutsQuery(),
        loadingIndicator: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: ShimmerCard(
                  height: 200,
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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      'Recent Logs',
                      weight: FontWeight.bold,
                    ),
                    CreateTextIconButton(
                        text: 'Add Log', onPressed: () => print('add log')),
                    TextButton(
                      onPressed: () =>
                          context.pushRoute(YourLoggedWorkoutsRoute()),
                      underline: false,
                      text: 'View all',
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 230,
                child: LayoutBuilder(
                    builder: (context, constraints) => Swiper(
                        itemBuilder: (c, i) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                  onTap: () => context.pushRoute(
                                      LoggedWorkoutDetailsRoute(
                                          id: logs[i].id)),
                                  child: LoggedWorkoutCard(logs[i])),
                            ),
                        itemCount: logs.length,
                        itemWidth: constraints.maxWidth,
                        itemHeight: 220,
                        viewportFraction: 0.93,
                        scale: 0.97,
                        loop: false)),
              ),
            ],
          );
        });
  }
}
