import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/user_input/tag_managers/progress_journal_goal_tags_manager.dart';
import 'package:spotmefitness_ui/components/user_input/tag_managers/user_benchmark_tags_manager.dart';
import 'package:spotmefitness_ui/components/user_input/tag_managers/workout_tags_manager.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _loading = false;
  Widget _spacer() => SizedBox(height: 10);

  /// Don't show toast when clearing cache before signing out - only when just clearing cache.
  Future<void> _clearCache(BuildContext context, bool showToast) async {
    setState(() => _loading = true);
    await context.graphQLStore.clear();
    setState(() => _loading = false);
    if (showToast) {
      context.showToast(message: 'Cache cleared.');
    }
  }

  Future<void> _updateUserProfileScope(
      String userId, UserProfileScope scope) async {
    final variables = UpdateUserArguments(data: UpdateUserInput());

    await context.graphQLStore.mutate(
        mutation: UpdateUserMutation(variables: variables),
        customVariablesMap: {
          'data': {'userProfileScope': scope.apiValue}
        },
        broadcastQueryIds: [
          AuthedUserQuery().operationName
        ],
        optimisticData: {
          '__typename': 'User',
          'id': userId,
          'userProfileScope': scope.apiValue
        });
  }

  @override
  Widget build(BuildContext context) {
    final Color _headingColor =
        CupertinoTheme.of(context).primaryColor.withOpacity(0.70);

    return QueryObserver<AuthedUser$Query, json.JsonSerializable>(
        key: Key('SettingsPage - ${AuthedUserQuery().operationName}'),
        query: AuthedUserQuery(),
        loadingIndicator: ShimmerDetailsPage(),
        builder: (data) {
          final User user = data.authedUser;

          return MyPageScaffold(
            key: Key('SettingsPage - CupertinoPageScaffold'),
            navigationBar: MyNavBar(
              key: Key('SettingsPage - MyNavBar'),
              middle: NavBarTitle('Settings'),
            ),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BorderButton(
                      onPressed: () => {},
                      text: 'Upgrade to PRO',
                      prefix: Icon(CupertinoIcons.text_badge_star),
                    ),
                  ],
                ),
                _spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        'Dark Mode',
                      ),
                      SlidingSelect<ThemeName>(
                          value: context.watch<ThemeBloc>().themeName,
                          children: <ThemeName, Widget>{
                            ThemeName.dark: Icon(
                              CupertinoIcons.moon_fill,
                              color: context.theme.primary,
                            ),
                            ThemeName.light: Icon(
                              CupertinoIcons.sun_max_fill,
                              color:
                                  CupertinoColors.systemYellow.withOpacity(0.7),
                            ),
                          },
                          updateValue: (themeName) => context
                              .read<ThemeBloc>()
                              .switchToTheme(themeName)),
                    ],
                  ),
                ),
                _spacer(),
                MyText('ACCOUNT', color: _headingColor),
                _spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        'Profile Privacy',
                      ),
                      SlidingSelect<UserProfileScope>(
                          value: user.userProfileScope,
                          children: <UserProfileScope, Widget>{
                            UserProfileScope.private: MyText(
                              'Private',
                              size: FONTSIZE.SMALL,
                            ),
                            UserProfileScope.public: MyText(
                              'Public',
                              size: FONTSIZE.SMALL,
                            ),
                          },
                          updateValue: (scope) =>
                              _updateUserProfileScope(user.id, scope)),
                      InfoPopupButton(
                          infoWidget: MyText('Profile privacy explainer'))
                    ],
                  ),
                ),
                _spacer(),
                PageLink(
                  linkText: 'Subscription',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Linked accounts',
                  onPress: () => {},
                ),
                _spacer(),
                MyText(
                  'MANAGE TAGS',
                  color: _headingColor,
                ),
                _spacer(),
                PageLink(
                  linkText: 'Workout Tags',
                  onPress: () => context.push(
                      child: WorkoutTagsManager(allowCreateTagOnly: false)),
                ),
                _spacer(),
                PageLink(
                  linkText: 'Journal Goal Tags',
                  onPress: () => context.push(
                      child: ProgressJournalGoalTagsManager(
                          allowCreateTagOnly: false)),
                ),
                _spacer(),
                PageLink(
                  linkText: 'Personal Best Tags',
                  onPress: () => context.push(
                      child:
                          UserBenchmarkTagsManager(allowCreateTagOnly: false)),
                ),
                _spacer(),
                MyText(
                  'DATA',
                  color: _headingColor,
                ),
                _spacer(),
                PageLink(
                  linkText: 'Push notifications',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Health trackers',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Clear cache',
                  onPress: () => _clearCache(context, true),
                  icon: Icon(Icons.cached_rounded),
                  loading: _loading,
                ),
                _spacer(),
                MyText(
                  'SUPPORT',
                  color: _headingColor,
                ),
                _spacer(),
                PageLink(
                  linkText: 'Report a problem',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Help center',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Community discussions',
                  onPress: () => {},
                ),
                _spacer(),
                MyText(
                  'ABOUT US',
                  color: _headingColor,
                ),
                _spacer(),
                PageLink(
                  linkText: 'Our story',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Become a Spotter',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Become a Shaper',
                  onPress: () => {},
                ),
                PageLink(
                  linkText: 'Company policies',
                  onPress: () => {},
                ),
                _spacer(),
                PageLink(
                    linkText: 'Sign out',
                    onPress: () async {
                      _clearCache(context, false);
                      await GetIt.I<AuthBloc>().signOut();
                    },
                    icon: Icon(CupertinoIcons.square_arrow_right))
              ],
            )),
          );
        });
  }
}
