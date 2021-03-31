import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/gym_profile_creator.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions.dart';

class ProfileGymProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheOnly,
          document: GymProfilesQuery().document,
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.data != null) {
            print(result.source);
            print('ProfileGymProfilesPage');
            var box = Hive.box(HiveStore.defaultBoxName);
            for (final key in box.keys) {
              print(key);
              print(box.get(key));
              print('-------');
            }
            print(result.hashCode);
            print(result);
            final _gymProfiles = GymProfiles$Query.fromJson(result.data ?? {})
                .gymProfiles
                .reversed
                .toList();

            return StackAndFloatingButton(
              buttonIconData: CupertinoIcons.add,
              onPressed: () => context.push(
                  child: GymProfileCreator(), fullscreenDialog: true),
              child: _gymProfiles.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ListView.builder(
                          itemCount: _gymProfiles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () => context.push(
                                    child: GymProfileCreator(
                                      gymProfile: _gymProfiles[index],
                                    ),
                                    fullscreenDialog: true),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 3.0),
                                  child: GymProfileCard(
                                    gymProfile: _gymProfiles[index],
                                  ),
                                ),
                              )),
                    )
                  : MyText(
                      'No gym profiles yet...',
                      textAlign: TextAlign.center,
                    ),
            );
          } else {
            return MyText('loafing');
          }
        });
  }
}
