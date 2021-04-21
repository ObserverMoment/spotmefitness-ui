import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/coercers.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/country_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/date_selector.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';

class ProfilePersonalPage extends StatelessWidget {
  Future<void> updateUserFields(
      GraphQLClient client, String id, String key, dynamic value) async {
    Map<String, dynamic> data = {
      'data': {key: value}
    };
    final String fragment = '''
          fragment field on User {
            $key
          }
        ''';

    final vars = UpdateUserArguments.fromJson(data);

    await GraphQL.updateObjectWithOptimisticFragment(
      client: client,
      document: UpdateUserMutation(variables: vars).document,
      operationName: UpdateUserMutation(variables: vars).operationName,
      variables: data,
      fragment: fragment,
      objectId: id,
      objectType: 'User',
      optimisticData: {key: value},
    );
  }

  @override
  Widget build(BuildContext context) {
    return QueryResponseBuilder(
        options: QueryOptions(
          document: AuthedUserQuery().document,
        ),
        builder: (result, {fetchMore, refetch}) {
          final User user =
              AuthedUser$Query.fromJson(result.data ?? {}).authedUser;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                EditableTextFieldRow(
                  title: 'Name',
                  text: user.displayName,
                  onSave: (newText) => updateUserFields(
                      context.graphQLClient, user.id, 'displayName', newText),
                  inputValidation: (String text) =>
                      text.length > 2 && text.length <= 30,
                  validationMessage: 'Min 3, max 30 characters',
                  maxChars: 30,
                ),
                EditableTextAreaRow(
                  title: 'Bio',
                  text: user.bio ?? '',
                  onSave: (newText) => updateUserFields(
                      context.graphQLClient, user.id, 'bio', newText),
                  inputValidation: (t) => true,
                  maxDisplayLines: 2,
                ),
                TappableRow(
                    title: 'Country',
                    display: user.countryCode != null
                        ? SelectedCountryDisplay(user.countryCode!)
                        : null,
                    onTap: () => context.push(
                        fullscreenDialog: true,
                        child: CountrySelector(
                          selectedCountry: user.countryCode != null
                              ? Country.fromIsoCode(user.countryCode!)
                              : null,
                          selectCountry: (country) => updateUserFields(
                              context.graphQLClient,
                              user.id,
                              'countryCode',
                              country.isoCode),
                        ))),
                TappableRow(
                    title: 'Birthdate',
                    display: user.birthdate != null
                        ? MyText(user.birthdate!.dateString)
                        : null,
                    onTap: () => context.push(
                        fullscreenDialog: true,
                        child: DateSelector(
                          selectedDate: user.birthdate,
                          saveDate: (date) => updateUserFields(
                              context.graphQLClient,
                              user.id,
                              'birthdate',
                              fromDartDateTimeToGraphQLDateTime(date)),
                        ))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            'Gender',
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SlidingSelect<Gender>(
                          value: user.gender,
                          children: <Gender, Widget>{
                            for (final v in Gender.values
                                .where((v) => v != Gender.artemisUnknown))
                              v: MyText(v.display)
                          },
                          updateValue: (gender) => updateUserFields(
                              context.graphQLClient,
                              user.id,
                              'gender',
                              gender.apiValue)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
