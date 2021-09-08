import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/pages/unauthed/register_beta_testing/beta_explained.dart';
import 'package:spotmefitness_ui/pages/unauthed/register_details.dart';
import 'package:spotmefitness_ui/pages/unauthed/trial_selector.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class RegisterBetaTesting extends StatefulWidget {
  @override
  _RegisterBetaTestingState createState() => _RegisterBetaTestingState();
}

class _RegisterBetaTestingState extends State<RegisterBetaTesting> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  int _currentStage = 0;
  bool _registeringNewUser = false;
  String? _registrationError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateEmail() => EmailValidator.validate(_emailController.text);
  bool _validatePassword() => _passwordController.text.length > 5;

  bool _canSubmitRegisterDetails() => _validateEmail() && _validatePassword();

  void _registerNewUserAndContinue() async {
    setState(() => _registeringNewUser = true);
    try {
      await GetIt.I<AuthBloc>().registerWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      print(e.toString());
      if (mounted) setState(() => _registrationError = e.toString());
    } finally {
      setState(() => _registeringNewUser = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: context.theme.barBackground,
        navigationBar: MyNavBar(
          withoutLeading: true,
          trailing: NavBarCancelButton(context.pop),
          middle: Row(
            children: [
              NavBarLargeTitle('WELCOME TO SOFIE!'),
            ],
          ),
        ),
        child: Column(children: [
          SizedBox(height: 10),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.push(child: BetaExplained()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyHeaderText(
                  'Great, but what IS "Beta"?',
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.info),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: MyText(
              'Happy? Then just enter an email address and password to get started.',
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
          RegisterDetails(
            canSubmit: _canSubmitRegisterDetails,
            emailController: _emailController,
            passwordController: _passwordController,
            registerNewUserAndContinue: _registerNewUserAndContinue,
            validateEmail: _validateEmail,
            validatePassword: _validatePassword,
          ),
          if (_registrationError != null)
            GrowIn(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  _registrationError!,
                  color: Styles.errorRed,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ]));
  }
}
