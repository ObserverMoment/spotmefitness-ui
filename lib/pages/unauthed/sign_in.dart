import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/pages/unauthed/reset_password.dart';
import 'package:spotmefitness_ui/pages/unauthed/start_trial.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _signingInUser = false;
  String? _signInError;

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

  bool _canSubmit() => _validateEmail() & _validatePassword();

  Future<void> _signIn() async {
    setState(() => _signingInUser = true);
    try {
      await GetIt.I<AuthBloc>().signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) setState(() => _signInError = e.toString());
    } finally {
      setState(() => _signingInUser = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        heroTag: 'SignIn',
        middle: MyText(
          'Sign In',
          weight: FontWeight.bold,
        ),
      ),
      child: Column(
        children: [
          CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.all(16),
              children: [
                if (_signInError != null)
                  GrowIn(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(
                        _signInError!,
                        color: Styles.errorRed,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                MyTextFormFieldRow(
                  prefix: Icon(CupertinoIcons.envelope_fill),
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: _validateEmail,
                  autofocus: true,
                  autofillHints: const <String>[AutofillHints.email],
                ),
                MyPasswordFieldRow(
                  controller: _passwordController,
                  validator: _validatePassword,
                  autofillHints: const <String>[AutofillHints.password],
                ),
              ]),
          SizedBox(height: 10),
          PrimaryButton(
              loading: _signingInUser,
              onPressed: _signIn,
              text: 'Sign In',
              disabled: !_canSubmit()),
          TextButton(
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true, builder: (_) => ResetPassword())),
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
