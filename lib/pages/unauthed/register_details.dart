import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';

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
      child: Column(
        children: [
          CupertinoFormSection.insetGrouped(
              margin: const EdgeInsets.all(16),
              footer: MyText('Password: Min 6 characters'),
              children: [
                MyTextFormFieldRow(
                  prefix: Icon(CupertinoIcons.envelope_fill),
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: validateEmail,
                  autofocus: true,
                ),
                MyPasswordFieldRow(
                  controller: passwordController,
                  validator: validatePassword,
                ),
              ]),
          SizedBox(height: 10),
          PrimaryButton(
            onPressed: registerNewUserAndContinue,
            text: 'Sign Up',
            disabled: !canSubmit(),
            loading: registeringNewUser,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
