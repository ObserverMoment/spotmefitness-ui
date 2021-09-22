import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sofie_ui/blocs/auth_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/text_input.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/pages/unauthed/reset_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      backgroundColor: context.theme.barBackground,
      navigationBar: const MyNavBar(
        middle: NavBarTitle('Sign In'),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: MyTextFormFieldRow(
              prefix: const Icon(CupertinoIcons.envelope_fill),
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: _validateEmail,
              autofocus: true,
              autofillHints: const <String>[AutofillHints.email],
              backgroundColor: context.theme.background,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: MyPasswordFieldRow(
              controller: _passwordController,
              validator: _validatePassword,
              autofillHints: const <String>[AutofillHints.password],
              backgroundColor: context.theme.background,
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
              loading: _signingInUser,
              onPressed: _signIn,
              text: 'Sign In',
              disabled: !_canSubmit()),
          TextButton(
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => const ResetPassword())),
            text: 'Reset Password',
          ),
        ],
      ),
    );
  }
}
