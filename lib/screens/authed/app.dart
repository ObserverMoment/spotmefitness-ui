import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';

class App extends StatelessWidget {
  App(String? firebaseUid);
  // Get User from DB
  // If successful render app
  // If not - sign out so that the user returns to the login page
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQL().clientNotifier,
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: CupertinoPageScaffold(
            child: SafeArea(
          child: Column(children: [
            Text('Hello world.'),
            Query(
                options: QueryOptions(document: EquipmentsQuery().document),
                builder: (QueryResult result,
                    {Future<QueryResult?> Function()? refetch,
                    FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return Text('Loading');
                  }

                  final equipments =
                      Equipments$Query.fromJson(result.data ?? {}).equipments;

                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return Row(
                        children: [Text(equipments[index].name)],
                      );
                    },
                    itemCount: equipments.length,
                  );
                })
          ]),
        )),
      ),
    );
  }
}
