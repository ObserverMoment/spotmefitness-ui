import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions.dart';

class SettingsAndInfo extends StatelessWidget {
  Widget _spacer() => SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final Color _headingColor =
        CupertinoTheme.of(context).primaryColor.withOpacity(0.70);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
                  CupertinoSlidingSegmentedControl<ThemeName>(
                      groupValue: context.watch<ThemeBloc>().themeName,
                      children: <ThemeName, Widget>{
                        ThemeName.dark: Icon(
                          CupertinoIcons.moon_fill,
                          color: CupertinoColors.black,
                        ),
                        ThemeName.light: Icon(
                          CupertinoIcons.sun_max_fill,
                          color: CupertinoColors.systemYellow.withOpacity(0.7),
                        ),
                      },
                      onValueChanged: (themeName) =>
                          context.read<ThemeBloc>().switchToTheme(themeName!)),
                ],
              ),
            ),
            PageLink(
                linkText: 'Upgrade to PRO',
                onPress: () => {},
                infoHighlight: true,
                large: true,
                bold: true),
            _spacer(),
            MyText('ACCOUNT', color: _headingColor),
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
