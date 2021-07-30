import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/creators/gym_profile_creator.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:json_annotation/json_annotation.dart' as json;
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
          final gymProfiles = data.gymProfiles;
          return StackAndFloatingButton(
            pageHasBottomNavBar: true,
            buttonText: 'Add Profile',
            onPressed: () => context.push(
                child: GymProfileCreator(), fullscreenDialog: true),
            child: gymProfiles.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 4, right: 4),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,

                        // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
                        itemCount: gymProfiles.length + 1,
                        itemBuilder: (c, i) {
                          if (i == gymProfiles.length) {
                            return SizedBox(
                                height: kAssumedFloatingButtonHeight +
                                    EnvironmentConfig.bottomNavBarHeight);
                          } else {
                            return GestureDetector(
                              onTap: () => context.push(
                                  child: GymProfileCreator(
                                    gymProfile: gymProfiles[i],
                                  ),
                                  fullscreenDialog: true),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: GymProfileCard(
                                  gymProfile: gymProfiles[i],
                                ),
                              ),
                            );
                          }
                        }),
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
