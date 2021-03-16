import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/screens/unauthed/register_details.dart';
import 'package:spotmefitness_ui/screens/unauthed/trial_selector.dart';
import 'package:spotmefitness_ui/services/auth.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';

class StartTrial extends StatefulWidget {
  @override
  _StartTrialState createState() => _StartTrialState();
}

class _StartTrialState extends State<StartTrial> {
  TrialType? _trialType;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  PageController _pageController = PageController();
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
    _pageController.addListener(() {
      setState(() => _currentStage = _pageController.page!.toInt());
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _setTrialType(TrialType trialType) =>
      setState(() => _trialType = trialType);

  bool _validateEmail() => EmailValidator.validate(_emailController.text);
  bool _validatePassword() => _passwordController.text.length > 5;

  bool _canSubmitRegisterDetails() => _validateEmail() && _validatePassword();

  void _registerNewUserAndContinue() async {
    setState(() => _registeringNewUser = true);
    try {
      await GetIt.I<AuthService>().registerWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      setState(() => _registeringNewUser = false);
    } catch (e) {
      print(e.toString());
      setState(() => _registrationError = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () => Navigator.pop(context),
              child: MyText('Cancel')),
        ),
        child: Column(children: [
          H2(
            '3 MONTH FREE TRIAL',
          ),
          StageProgressIndicator(
            numStages: 3,
            titles: ['Select trial', 'Sign up', 'GO!'],
            currentStage: _currentStage,
          ),
          SizedBox(height: 16),
          if (_registrationError != null)
            GrowIn(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  _registrationError!,
                  color: Styles.errorRed,
                ),
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TrialSelector(
                    trialType: _trialType,
                    setTrialType: _setTrialType,
                    goToEnterDetails: () => _animateToPage(1)),
                RegisterDetails(
                  canSubmit: _canSubmitRegisterDetails,
                  emailController: _emailController,
                  validateEmail: _validateEmail,
                  passwordController: _passwordController,
                  validatePassword: _validatePassword,
                  registerNewUserAndContinue: _registerNewUserAndContinue,
                  registeringNewUser: _registeringNewUser,
                ),
              ],
            ),
          )
        ]));
  }
}
