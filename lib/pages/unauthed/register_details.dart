import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class RegisterDetails extends StatelessWidget {
  final TextEditingController emailController;
  final bool Function() validateEmail;
  final TextEditingController passwordController;
  final bool Function() validatePassword;
  final bool Function() canSubmit;
  final void Function() registerNewUserAndContinue;
  final bool registeringNewUser;

  RegisterDetails(
      {required this.emailController,
      required this.validateEmail,
      required this.passwordController,
      required this.validatePassword,
      required this.canSubmit,
      required this.registerNewUserAndContinue,
      this.registeringNewUser = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyTextFormFieldRow(
              prefix: Icon(CupertinoIcons.envelope_fill),
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: validateEmail,
              autofocus: true,
              autofillHints: const <String>[AutofillHints.email],
              backgroundColor: context.theme.background,
            ),
            SizedBox(height: 10),
            MyPasswordFieldRow(
              controller: passwordController,
              validator: validatePassword,
              autofillHints: const <String>[AutofillHints.newPassword],
              backgroundColor: context.theme.background,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
