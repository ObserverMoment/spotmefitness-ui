import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/components/user_input/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';

class ProfilePersonalDetails extends StatelessWidget {
  Map<String, dynamic> _getOptimistic(
          Map<String, dynamic> previous, Map<String, dynamic> updated) =>
      {
        'updateUser': {
          ...previous,
          ...updated,
        }
      };

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: AuthedUserQuery().document,
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic),
        builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
            result: result,
            builder: () {
              final _user =
                  AuthedUser$Query.fromJson(result.data ?? {}).authedUser;
              return Mutation(
                  options:
                      MutationOptions(document: UpdateUserMutation().document),
                  builder: (updateUserMutation, _) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            EditableTextFieldRow(
                              title: 'Name',
                              text: _user.displayName ?? '',
                              onSave: (newText) => updateUserMutation({
                                'data': {'displayName': newText},
                              },
                                  optimisticResult: _getOptimistic(
                                      _user.toJson(),
                                      {'displayName': newText})),
                              inputValidation: (String text) =>
                                  text.length > 2 && text.length <= 30,
                              validationMessage: 'Min 3, max 30 characters',
                              maxChars: 30,
                            ),
                            EditableTextFieldArea(
                              title: 'Bio',
                              text: _user.bio ?? '',
                              onSave: (newText) => updateUserMutation({
                                'data': {'bio': newText},
                              },
                                  optimisticResult: _getOptimistic(
                                      _user.toJson(), {'bio': newText})),
                              inputValidation: (t) => true,
                              maxDisplayLines: 2,
                            ),
                          ],
                        ),
                      ));
            }));
  }
}
