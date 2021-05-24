import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/coercers.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/country_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/date_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class ProfilePersonalPage extends StatelessWidget {
  Future<void> updateUserFields(
      BuildContext context, String id, String key, dynamic value) async {
    final variables =
        UpdateUserArguments(data: UpdateUserInput.fromJson({key: value}));

    await context.graphQLStore.mutate(
        mutation: UpdateUserMutation(variables: variables),
        customVariablesMap: {
          'data': {key: value}
        },
        broadcastQueryIds: [
          AuthedUserQuery().operationName
        ],
        optimisticData: {
          '__typename': 'User',
          'id': id,
          key: value
        });
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<AuthedUser$Query, json.JsonSerializable>(
        key: Key('ProfilePersonalPage - ${AuthedUserQuery().operationName}'),
        query: AuthedUserQuery(),
        fetchPolicy: QueryFetchPolicy.storeAndNetwork,
        loadingIndicator: ShimmerCardList(
          itemCount: 12,
          cardHeight: 20,
          cardPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        ),
        builder: (data) {
          final User user = data.authedUser;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                EditableTextFieldRow(
                  title: 'Name',
                  text: user.displayName ?? '',
                  onSave: (newText) => updateUserFields(
                      context, user.id, 'displayName', newText),
                  inputValidation: (String text) =>
                      text.length > 2 && text.length <= 30,
                  validationMessage: 'Min 3, max 30 characters',
                  maxChars: 30,
                ),
                EditableTextAreaRow(
                  title: 'Bio',
                  text: user.bio ?? '',
                  onSave: (newText) =>
                      updateUserFields(context, user.id, 'bio', newText),
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
                              context, user.id, 'countryCode', country.isoCode),
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
                              context,
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
                              context, user.id, 'gender', gender.apiValue)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
