import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/gym_profile_creator.dart';
import 'package:spotmefitness_ui/constants.dart';
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
            buttonIconData: CupertinoIcons.add,
            pageHasBottomNavBar: true,
            onPressed: () => context.push(
                child: GymProfileCreator(), fullscreenDialog: true),
            child: gymProfiles.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,

                        // Hack...+ 1 to allow for building a sized box spacer to lift up above the floating button.
                        itemCount: gymProfiles.length + 1,
                        itemBuilder: (c, i) {
                          if (i == gymProfiles.length) {
                            return SizedBox(
                                height: kAssumedFloatingButtonHeight +
                                    kBottomNavBarHeight);
                          } else {
                            return GestureDetector(
                              onTap: () => context.push(
                                  child: GymProfileCreator(
                                    gymProfile: gymProfiles[i],
                                  ),
                                  fullscreenDialog: true),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 3.0),
                                child: GymProfileCard(
                                  gymProfile: gymProfiles[i],
                                ),
                              ),
                            );
                          }
                        }),
                  )
                : MyText(
                    'No gym profiles yet...',
                    textAlign: TextAlign.center,
                  ),
          );
        });
  }
}
