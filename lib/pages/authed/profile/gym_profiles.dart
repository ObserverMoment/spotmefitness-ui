import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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

              return _gymProfiles.isNotEmpty
                  ? ListView.builder(
                      itemCount: _gymProfiles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => MyText(index.toString()))
                  : ListView.builder(
                      itemCount: 40,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          MyText(index.toString()));
            }));
  }
}
