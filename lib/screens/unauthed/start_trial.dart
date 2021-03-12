import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';

enum TrialType { BASIC, PRO }

class StartTrial extends StatefulWidget {
  @override
  _StartTrialState createState() => _StartTrialState();
}

class _StartTrialState extends State<StartTrial> {
  TrialType? _trialType;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _setTrialType(TrialType trialType) =>
      setState(() => _trialType = trialType);

  bool _validateName() => _nameController.text.length > 2;
  bool _validateEmail() => EmailValidator.validate(_emailController.text);
  bool _validatePassword() => _passwordController.text.length > 7;

  bool _canSubmit() =>
      _validateName() && _validateEmail() && _validatePassword();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: Column(children: [
          MyText(
            '3 MONTH FREE TRIAL',
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Expanded(
                    child: TrialSelector(
                        trialType: _trialType,
                        setTrialType: _setTrialType,
                        goToEnterDetails: () => _animateToPage(1))),
                Expanded(
                  child: RegisterDetails(
                      canSubmit: _canSubmit,
                      nameController: _nameController,
                      validateName: _validateName,
                      emailController: _emailController,
                      validateEmail: _validateEmail,
                      passwordController: _passwordController,
                      validatePassword: _validatePassword,
                      goBackToTrialSelect: () => _animateToPage(0)),
                )
              ],
            ),
          )
        ]));
  }
}

class TrialSelector extends StatelessWidget {
  final TrialType? trialType;
  final Function(TrialType trialType) setTrialType;
  final void Function() goToEnterDetails;
  TrialSelector(
      {this.trialType,
      required this.setTrialType,
      required this.goToEnterDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: H2('1. Trial Type'),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            GestureDetector(
              onTap: () => setTrialType(TrialType.BASIC),
              child: TrialSelectorBox(
                name: 'BASIC',
                cost: 4.99,
                isSelected: trialType == TrialType.BASIC,
                content: Column(
                  children: [
                    MyText('Feature 1'),
                    MyText('Feature 2'),
                    MyText('Feature 3'),
                    MyText('Feature 4'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setTrialType(TrialType.PRO),
              child: TrialSelectorBox(
                name: 'PRO',
                cost: 9.99,
                isSelected: trialType == TrialType.PRO,
                content: Column(
                  children: [
                    MyText('All from BASIC +'),
                    MyText('Feature a'),
                    MyText('Feature b'),
                    MyText('Feature c'),
                  ],
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyText(
            'Free for 3 months, then billed monthly. Cancel anytime.',
            size: FONTSIZE.SMALL,
          ),
        ),
        if (trialType != null)
          FadeIn(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: PrimaryButton(
                onPressed: goToEnterDetails,
                text: 'Continue',
              ),
            ),
          ),
      ],
    );
  }
}

class TrialSelectorBox extends StatelessWidget {
  final String name;
  final double cost;
  final Widget content;
  final bool isSelected;
  TrialSelectorBox(
      {required this.name,
      required this.cost,
      required this.content,
      required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: isSelected
                        ? CupertinoTheme.of(context).primaryColor
                        : CupertinoColors.white.withOpacity(0.8))),
            padding: const EdgeInsets.all(10),
            width: 160,
            child: Column(
              children: [
                H1(name),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: content,
                ),
                MyText('£${cost.toString()} / month',
                    weight: FONTWEIGHT.BOLD, size: FONTSIZE.LARGE),
              ],
            )),
        if (isSelected)
          Positioned(
              top: 5,
              right: 5,
              child:
                  FadeIn(child: Icon(CupertinoIcons.check_mark_circled_solid)))
      ],
    );
  }
}

class RegisterDetails extends StatelessWidget {
  final TextEditingController nameController;
  final bool Function() validateName;
  final TextEditingController emailController;
  final bool Function() validateEmail;
  final TextEditingController passwordController;
  final bool Function() validatePassword;
  final bool Function() canSubmit;
  final void Function() goBackToTrialSelect;

  RegisterDetails(
      {required this.nameController,
      required this.validateName,
      required this.emailController,
      required this.validateEmail,
      required this.passwordController,
      required this.validatePassword,
      required this.canSubmit,
      required this.goBackToTrialSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: H2('2. Enter your details'),
        ),
        Container(
          child: CupertinoFormSection.insetGrouped(
              margin: EdgeInsets.all(10),
              children: [
                MyTextFormFieldRow(
                  prefix: Icon(CupertinoIcons.person_fill),
                  placeholder: 'Display Name',
                  keyboardType: TextInputType.emailAddress,
                  controller: nameController,
                  validator: validateName,
                ),
                MyTextFormFieldRow(
                  prefix: Icon(CupertinoIcons.envelope_fill),
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: validateEmail,
                ),
                MyTextFormFieldRow(
                  prefix: Icon(CupertinoIcons.lock_shield_fill),
                  placeholder: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: passwordController,
                  validator: validatePassword,
                )
              ]),
        ),
        SizedBox(height: 10),
        PrimaryButton(
          onPressed: () => {print('setup trial and register user')},
          text: 'Get Started',
          disabled: !canSubmit(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
