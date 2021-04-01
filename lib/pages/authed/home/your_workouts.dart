import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class YourWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: UserWorkoutsQuery().document),
      builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
          result: result,
          builder: () {
            final _workouts =
                UserWorkouts$Query.fromJson(result.data ?? {}).userWorkouts;
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: NavBarTitle('Your Workouts'),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [H2('Filters, text search and tags')],
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _workouts.length,
                            itemBuilder: (context, index) =>
                                MyText(_workouts[index].name)),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
