import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/cards/gym_profile_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ProfileGymProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: GymProfilesQuery().document),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final _gymProfiles =
                  GymProfiles$Query.fromJson(result.data ?? {}).gymProfiles;

              return StackAndFloatingButton(
                buttonIconData: CupertinoIcons.add,
                onPressed: () => print('floaty'),
                child: _gymProfiles.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: ListView.builder(
                            itemCount: _gymProfiles.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: GymProfileCard(
                                    gymProfile: _gymProfiles[index],
                                  ),
                                )),
                      )
                    : MyText('No gym profiles yet...'),
              );
            }));
  }
}
