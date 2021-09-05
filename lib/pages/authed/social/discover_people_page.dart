import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/user_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:auto_route/auto_route.dart';

class DiscoverPeoplePage extends StatelessWidget {
  const DiscoverPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query =
        UserPublicProfilesQuery(variables: UserPublicProfilesArguments());
    return QueryObserver<UserPublicProfiles$Query, json.JsonSerializable>(
        key: Key('DiscoverPeoplePage- ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerListPage(),
        builder: (data) {
          final authedUserId = GetIt.I<AuthBloc>().authedUser!.id;
          final publicProfiles = data.userPublicProfiles
              .where((p) => authedUserId != p.id)
              .toList();

          return MyPageScaffold(
              navigationBar: MyNavBar(middle: NavBarTitle('Discover People')),
              child: publicProfiles.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: publicProfiles.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 0.75,
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemBuilder: (c, i) => GestureDetector(
                                onTap: () => context.navigateTo(
                                    UserPublicProfileDetailsRoute(
                                        userId: publicProfiles[i].id)),
                                child: UserProfileCard(
                                  profileSummary: publicProfiles[i],
                                ),
                              )),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ContentBox(
                              child: BorderButton(
                                  withBorder: false,
                                  mini: true,
                                  prefix: Icon(CupertinoIcons.search_circle),
                                  text: 'Find people',
                                  onPressed: () => context
                                      .navigateTo(DiscoverPeopleRoute())),
                            ),
                          ),
                        ),
                      ],
                    ));
        });
  }
}
