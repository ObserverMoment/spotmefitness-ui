import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/club_summary_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class DiscoverClubsPage extends StatelessWidget {
  const DiscoverClubsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(middle: NavBarTitle('Discover Clubs')),
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _HorizontalClubsList(),
                  )
                ]))
              ],
          body: Container(
            child: Center(
                child: MyHeaderText(
              'Club finder coming soon!',
              size: FONTSIZE.BIG,
            )),
          )),
    );
  }
}

class _HorizontalClubsList extends StatelessWidget {
  const _HorizontalClubsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = UserClubsQuery();
    return QueryObserver<UserClubs$Query, json.JsonSerializable>(
        key: Key('SocialPage._HorizontalClubsList - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerHorizontalCardList(
          listHeight: 140,
        ),
        builder: (data) {
          final clubs = data.userClubs;

          return Container(
            height: 140,
            alignment: Alignment.centerLeft,
            child: data.userClubs.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: clubs.length,
                    itemBuilder: (c, i) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClubSummaryCard(
                        club: clubs[i],
                      ),
                    ),
                  )
                : Center(
                    child: ContentBox(
                      child: MyText('No clubs yet...'),
                    ),
                  ),
          );
        });
  }
}
