import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/lists.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';

class ProfileGymProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryObserver<GymProfiles$Query, json.JsonSerializable>(
        key:
            Key('ProfileGymProfilesPage - ${GymProfilesQuery().operationName}'),
        query: GymProfilesQuery(),
        fetchPolicy: QueryFetchPolicy.storeFirst,
        loadingIndicator: ShimmerCardList(
          itemCount: 8,
          cardHeight: 160,
        ),
        builder: (data) {
          final gymProfiles = data.gymProfiles.reversed.toList();
          return StackAndFloatingButton(
            pageHasBottomNavBar: true,
            buttonText: 'Add Profile',
            onPressed: () => context.pushRoute(GymProfileCreatorRoute()),
            child: gymProfiles.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4, right: 4),
                    child: ListAvoidFAB(
                      itemCount: gymProfiles.length,
                      itemBuilder: (c, i) => GestureDetector(
                        onTap: () => context.pushRoute(
                          GymProfileCreatorRoute(
                            gymProfile: gymProfiles[i],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: GymProfileCard(
                            gymProfile: gymProfiles[i],
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: MyText(
                      'No gym profiles yet...',
                      textAlign: TextAlign.center,
                    ),
                  ),
          );
        });
  }
}
