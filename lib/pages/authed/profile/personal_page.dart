import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/coercers.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/country_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/date_selector.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/country.dart';
import 'package:spotmefitness_ui/extensions.dart';

class ProfilePersonalPage extends StatelessWidget {
  Map<String, dynamic> _getOptimistic(AuthedUser$Query$User updatedUser) {
    return {'updateUser': updatedUser.toJson()};
  }

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
                              onSave: (newText) => updateUserMutation(
                                {
                                  'data': {'displayName': newText},
                                },
                                optimisticResult: () {
                                  _user.displayName = newText;
                                  return _getOptimistic(_user);
                                }(),
                              ),
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
                              }, optimisticResult: () {
                                _user.bio = newText;
                                return _getOptimistic(_user);
                              }()),
                              inputValidation: (t) => true,
                              maxDisplayLines: 2,
                            ),
                            TappableRow(
                                title: 'Country',
                                display: _user.countryCode != null
                                    ? SelectedCountryDisplay(_user.countryCode!)
                                    : null,
                                onTap: () => context.push(
                                    fullscreenDialog: true,
                                    child: CountrySelector(
                                      selectedCountry: _user.countryCode != null
                                          ? Country.fromIsoCode(
                                              _user.countryCode!)
                                          : null,
                                      selectCountry: (country) =>
                                          updateUserMutation({
                                        'data': {
                                          'countryCode': country.isoCode
                                        },
                                      }, optimisticResult: () {
                                        _user.countryCode = country.isoCode;
                                        return _getOptimistic(_user);
                                      }()),
                                    ))),
                            TappableRow(
                                title: 'Birthdate',
                                display: _user.birthdate != null
                                    ? MyText(_user.birthdate!.dateString)
                                    : null,
                                onTap: () => context.push(
                                    fullscreenDialog: true,
                                    child: DateSelector(
                                      selectedDate: _user.birthdate,
                                      saveDate: (date) => updateUserMutation({
                                        'data': {
                                          'birthdate':
                                              fromDartDateTimeToGraphQLDateTime(
                                                  date)
                                        },
                                      }, optimisticResult: () {
                                        _user.birthdate = date;
                                        return _getOptimistic(_user);
                                      }()),
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
                                  SizedBox(height: 4),
                                  CupertinoSlidingSegmentedControl<Gender>(
                                    groupValue: _user.gender,
                                    children: <Gender, Widget>{
                                      for (final v in Gender.values.where(
                                          (v) => v != Gender.artemisUnknown))
                                        v: MyText(v.display)
                                    },
                                    onValueChanged: (gender) =>
                                        updateUserMutation({
                                      'data': {'gender': gender!.apiValue},
                                    }, optimisticResult: () {
                                      _user.gender = gender;
                                      return _getOptimistic(_user);
                                    }()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
            }));
  }
}
