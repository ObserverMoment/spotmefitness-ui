import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final String id;
  WorkoutDetailsPage({@PathParam('id') required this.id});
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: WorkoutByIdQuery().document, variables: {'id': id}),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final WorkoutById workout =
                  WorkoutById$Query.fromJson(result.data ?? {}).workoutById;
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: NavBarTitle(workout.name),
                  trailing: Icon(CupertinoIcons.ellipsis),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (workout.userInfo?.avatarUri != null)
                            UserAvatar(
                              avatarUri: workout.userInfo!.avatarUri!,
                              radius: 40,
                            ),
                          // if (workout.userInfo?.name != null)
                          //   MyText(workout.userInfo?.name!)
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
