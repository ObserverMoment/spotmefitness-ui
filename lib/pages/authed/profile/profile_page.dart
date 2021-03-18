import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
            height: 200,
            width: 200,
            color: Styles.difficultyLevelThree,
            child: DestructiveButton(
              text: 'Sign Out',
              onPressed: () async => await GetIt.I<AuthBloc>().signOut(),
            )),
      ),
    );
  }
}
