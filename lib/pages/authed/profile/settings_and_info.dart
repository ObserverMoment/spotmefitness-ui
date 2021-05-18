import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class SettingsAndInfoPage extends StatefulWidget {
  @override
  _SettingsAndInfoPageState createState() => _SettingsAndInfoPageState();
}

class _SettingsAndInfoPageState extends State<SettingsAndInfoPage> {
  bool _loading = false;
  Widget _spacer() => SizedBox(height: 10);

  Future<void> _cleareCache(BuildContext context) async {
    setState(() => _loading = true);
    await context.graphQLStore.clear();
    setState(() => _loading = false);
    context.showToast(message: 'Cache cleared.');
  }

  @override
  Widget build(BuildContext context) {
    final Color _headingColor =
        CupertinoTheme.of(context).primaryColor.withOpacity(0.70);

    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle('SETTINGS'),
      ),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    'Dark Mode',
                    weight: FontWeight.bold,
                  ),
                  SlidingSelect<ThemeName>(
                      value: context.watch<ThemeBloc>().themeName,
                      children: <ThemeName, Widget>{
                        ThemeName.dark: Icon(
                          CupertinoIcons.moon_fill,
                          color: CupertinoColors.white,
                        ),
                        ThemeName.light: Icon(
                          CupertinoIcons.sun_max_fill,
                          color: CupertinoColors.systemYellow.withOpacity(0.7),
                        ),
                      },
                      updateValue: (themeName) =>
                          context.read<ThemeBloc>().switchToTheme(themeName)),
                ],
              ),
            ),
            PageLink(
              linkText: 'Upgrade to PRO',
              onPress: () => {},
              infoHighlight: true,
            ),
            _spacer(),
            MyText('ACCOUNT', color: _headingColor),
            _spacer(),
            PageLink(
              linkText: 'Profile Privacy',
              onPress: () => {},
            ),
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
              'CONTENT',
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
              onPress: () => _cleareCache(context),
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
                onPress: () async => await GetIt.I<AuthBloc>().signOut(),
                icon: Icon(CupertinoIcons.square_arrow_right))
          ],
        ),
      )),
    );
  }
}
