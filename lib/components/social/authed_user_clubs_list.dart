import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/cards/club_card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/lists.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

class AuthedUserClubsList extends StatelessWidget {
  const AuthedUserClubsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = UserClubsQuery();
    return StackAndFloatingButton(
      onPressed: () => context.navigateTo(ClubCreatorRoute()),
      buttonText: 'Club',
      child: QueryObserver<UserClubs$Query, json.JsonSerializable>(
          key: Key('SocialPage.AuthedUserClubsList - ${query.operationName}'),
          query: query,
          loadingIndicator: const ShimmerCardList(
            itemCount: 10,
            cardHeight: 240.0,
          ),
          builder: (data) {
            final clubs = data.userClubs;

            return clubs.isNotEmpty
                ? ListAvoidFAB(
                    itemCount: clubs.length,
                    itemBuilder: (c, i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: MyText('No clubs yet...'),
                      ),
                    ],
                  );
          }),
    );
  }
}
