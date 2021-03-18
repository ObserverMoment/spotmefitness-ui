import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/pages/unauthed/start_trial.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
  bool _validatePassword() => _passwordController.text.length > 7;

  bool _canSubmit() => _validateEmail() & _validatePassword();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: MyText('Sign In'),
      ),
      child: Column(
        children: [
          Container(
            child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(10),
                children: [
                  MyTextFormFieldRow(
                      prefix: Icon(CupertinoIcons.envelope_circle),
                      placeholder: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: _validateEmail),
                  MyTextFormFieldRow(
                    prefix: Icon(CupertinoIcons.lock_circle),
                    placeholder: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    validator: _validatePassword,
                    obscureText: true,
                  ),
                ]),
          ),
          SizedBox(height: 10),
          PrimaryButton(
              onPressed: () => {print('signing in')},
              text: 'Sign In',
              disabled: !_canSubmit()),
          TextButton(
            onPressed: () => {},
            text: 'Reset Password',
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: MyText('Not a member yet?'),
          ),
          SecondaryButton(
            text: 'Start Free Trial',
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      fullscreenDialog: true, builder: (_) => StartTrial()));
            },
          ),
        ],
      ),
    );
  }
}
