import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

class WelcomeModal extends StatefulWidget {
  @override
  _WelcomeModalState createState() => _WelcomeModalState();
}

class _WelcomeModalState extends State<WelcomeModal> {
  TextEditingController _nameController = TextEditingController();
  bool? _nameIsUnique;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool _validateName() =>
      _nameController.text.length > 2 &&
      _nameIsUnique != null &&
      _nameIsUnique!;

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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('While you warm up...',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.assistant(
                                fontSize: 26,
                                color: CupertinoColors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 4),
                          MyText(
                            '(Completely optional 🙂!)',
                            color: CupertinoColors.black,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Add a display name?',
                          style: GoogleFonts.assistant(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: CupertinoColors.black)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            context.read<ThemeBloc>().primary.withOpacity(0.7),
                      )),
                  child: CupertinoTextField(
                    controller: _nameController,
                    padding: const EdgeInsets.all(18),
                    placeholder: 'At least 3 characters...',
                    placeholderStyle:
                        TextStyle(color: CupertinoColors.inactiveGray),
                    decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                GrowInOut(
                  show: _nameIsUnique != null && !_nameIsUnique!,
                  child: MyText(
                    "Someone's already taken this one 😒",
                    color: CupertinoColors.black,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Upload an avatar image?',
                          style: GoogleFonts.assistant(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: CupertinoColors.black)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                child: SecondaryButton(
                    prefix: Icon(Icons.run_circle_rounded),
                    text: "Let's go!",
                    onPressed: () => Navigator.pop(context)))
          ],
        ),
      )),
    );
  }
}
