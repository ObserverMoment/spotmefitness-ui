import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/club_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/services/store/query_observer.dart';

class YourClubsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final query = UserClubsQuery();

    return QueryObserver<UserClubs$Query, json.JsonSerializable>(
        key: Key('SocialPage.HorizontalClubsList - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerDetailsPage(),
        builder: (data) {
          final clubs = data.userClubs;

          return MyPageScaffold(
              navigationBar: BorderlessNavBar(
                middle: NavBarTitle('Clubs'),
                trailing: CreateIconButton(
                  onPressed: () => context.navigateTo(ClubCreatorRoute()),
                ),
              ),
              child: data.userClubs.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: clubs.length,
                      itemBuilder: (c, i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: () => context
                              .navigateTo(ClubDetailsRoute(id: clubs[i].id)),
                          child: ClubCard(
                            club: clubs[i],
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: ContentBox(
                              child: BorderButton(
                                  withBorder: false,
                                  mini: true,
                                  prefix: Icon(CupertinoIcons.search_circle),
                                  text: 'Find clubs',
                                  onPressed: () => print('find clubs flow')),
                            ),
                          ),
                        ),
                      ],
                    ));
        });
  }
}
