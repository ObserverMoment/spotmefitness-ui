import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/user_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
        customLeading: NavBarLargeTitle('Social'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: MyText(
                'Chat to friends and workout buddies, join clubs and find great coaches!',
                maxLines: 6,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: PublicProfilesGrid())
          ],
        ),
      ),
    );
  }
}

class PublicProfilesGrid extends StatelessWidget {
  const PublicProfilesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query =
        UserPublicProfilesQuery(variables: UserPublicProfilesArguments());

    return QueryObserver<UserPublicProfiles$Query, json.JsonSerializable>(
        key: Key('SocialPage - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerCardGrid(
          itemCount: 12,
          maxCardWidth: 200,
        ),
        builder: (data) {
          final profileSummaries = data.userPublicProfiles;

          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: profileSummaries.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 0.8,
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemBuilder: (c, i) => GestureDetector(
                      onTap: () => context.navigateTo(
                          UserPublicProfileDetailsRoute(
                              userId: profileSummaries[i].id)),
                      child: UserProfileCard(
                        profileSummary: profileSummaries[i],
                      ),
                    )),
          );
        });
  }
}
