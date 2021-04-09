import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/services/debounce.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class WelcomeModal extends StatefulWidget {
  @override
  _WelcomeModalState createState() => _WelcomeModalState();
}

class _WelcomeModalState extends State<WelcomeModal> {
  TextEditingController _nameController = TextEditingController();
  bool? _nameIsUnique;
  Debouncer _debouncer = Debouncer();
  String? _avatarUri;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      if (_nameController.text.length > 2) {
        _debouncer.run(_checkNameIsUnique);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _checkNameIsUnique() async {
    if (_nameController.text.length > 2) {
      final _vars =
          CheckUniqueDisplayNameArguments(displayName: _nameController.text);

      final _res = await GraphQL().client.query(QueryOptions(
          document: CheckUniqueDisplayNameQuery(variables: _vars).document,
          variables: _vars.toJson()));

      final _isUnique = CheckUniqueDisplayName$Query.fromJson(_res.data ?? {})
          .checkUniqueDisplayName;
      setState(() => _nameIsUnique = _isUnique);
    }
  }

  bool _validateName() =>
      _nameController.text.length > 2 &&
      _nameIsUnique != null &&
      _nameIsUnique!;

  Future<void> _handleExit() async {
    if (_validateName()) {
      final _vars = UpdateUserArguments(
          data: UpdateUserInput(
              displayName: _nameController.text, hasOnboarded: true));

      await GraphQL().client.mutate(
            MutationOptions(
              document: UpdateUserMutation(variables: _vars).document,
              variables: _vars.toJson(),
              onError: (e) => throw new Exception(e),
            ),
          );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox.expand(
                child: RoundedBox(
              child: Image.asset(
                'assets/stock_images/limber.jpg',
                fit: BoxFit.cover,
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            H1(
                              'While you warm up...',
                              textAlign: TextAlign.center,
                              color: Styles.black,
                            ),
                            MyText(
                              '(Completely optional!)',
                              color: Styles.grey,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText('Add a display name?',
                            weight: FontWeight.bold,
                            size: FONTSIZE.LARGE,
                            color: CupertinoColors.black),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.theme.primary.withOpacity(0.7),
                        )),
                    child: Stack(
                      children: [
                        CupertinoTextField(
                          controller: _nameController,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                          placeholder: 'Name...',
                          cursorColor:
                              CupertinoColors.secondarySystemGroupedBackground,
                          style: TextStyle(
                              color: CupertinoColors.black, fontSize: 17),
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.inactiveGray,
                              fontSize: 17),
                          decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        if (_validateName())
                          Positioned(
                              right: 10,
                              top: 18,
                              child: FadeIn(
                                child: Icon(
                                  CupertinoIcons.checkmark_alt_circle_fill,
                                  color: Styles.infoBlue,
                                ),
                              ))
                      ],
                    ),
                  ),
                  GrowInOut(
                    show: _nameController.text.length < 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText('- At least 3 characters.',
                            color: Styles.errorRed),
                      ],
                    ),
                  ),
                  if (_nameIsUnique != null && _nameController.text.length > 2)
                    GrowIn(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: _nameIsUnique!
                                ? MyText(
                                    "This name is available 🙂",
                                    color: CupertinoColors.black,
                                  )
                                : MyText("Someone's already taken this one 😒",
                                    color: Styles.errorRed),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText('Upload an avatar?',
                            weight: FontWeight.bold,
                            size: FONTSIZE.LARGE,
                            color: CupertinoColors.black),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserAvatarUploader(
                        avatarUri: _avatarUri,
                        onUploadSuccess: (uri) =>
                            setState(() => _avatarUri = uri),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                child: SecondaryButton(
                    prefix: Icon(Icons.run_circle_rounded),
                    text: "Let's go!",
                    onPressed: _handleExit))
          ],
        ),
      )),
    );
  }
}
