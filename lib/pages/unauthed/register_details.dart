import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/text_input.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';

class RegisterDetails extends StatelessWidget {
  final TextEditingController emailController;
  final bool Function() validateEmail;
  final TextEditingController passwordController;
  final bool Function() validatePassword;
  final bool Function() canSubmit;
  final void Function() registerNewUserAndContinue;
  final bool registeringNewUser;

  const RegisterDetails(
      {Key? key,
      required this.emailController,
      required this.validateEmail,
      required this.passwordController,
      required this.validatePassword,
      required this.canSubmit,
      required this.registerNewUserAndContinue,
      this.registeringNewUser = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyTextFormFieldRow(
              prefix: const Icon(CupertinoIcons.envelope_fill),
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: validateEmail,
              autofocus: true,
              autofillHints: const <String>[AutofillHints.email],
              backgroundColor: context.theme.background,
            ),
            const SizedBox(height: 10),
            MyPasswordFieldRow(
              controller: passwordController,
              validator: validatePassword,
              autofillHints: const <String>[AutofillHints.newPassword],
              backgroundColor: context.theme.background,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 24),
              child: Row(
                children: const [
                  MyText('Min 6 characters'),
                ],
              ),
            ),
            if (canSubmit())
              FadeIn(
                child: PrimaryButton(
                  onPressed: registerNewUserAndContinue,
                  text: 'Sign Up',
                  disabled: !canSubmit(),
                  loading: registeringNewUser,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
