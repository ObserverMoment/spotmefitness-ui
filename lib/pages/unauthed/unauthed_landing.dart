import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/pages/unauthed/register_beta_testing/register_beta_testing.dart';
import 'package:spotmefitness_ui/pages/unauthed/sign_in.dart';
import 'package:spotmefitness_ui/pages/unauthed/start_trial.dart';

class UnauthedLandingPage extends StatefulWidget {
  @override
  _UnauthedLandingPageState createState() => _UnauthedLandingPageState();
}

class _UnauthedLandingPageState extends State<UnauthedLandingPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() => {});
    });
  }

  List<Widget> _featurePages = [
    SizedBox.expand(
        child: Image.asset(
      'assets/stock_images/stretch.jpg',
      fit: BoxFit.fitHeight,
    )),
    SizedBox.expand(
        child: Image.asset(
      'assets/stock_images/bars_man.jpg',
      fit: BoxFit.cover,
    )),
    SizedBox.expand(
        child: Image.asset(
      'assets/stock_images/skip.jpg',
      fit: BoxFit.cover,
    )),
    SizedBox.expand(
        child: Image.asset(
      'assets/stock_images/yoga_girl.jpg',
      fit: BoxFit.cover,
    )),
    SizedBox.expand(
        child: Image.asset(
      'assets/stock_images/gym.jpg',
      fit: BoxFit.cover,
    )),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenHeight = constraints.maxHeight;
      return CupertinoPageScaffold(
          child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          PageView(
            controller: _pageController,
            children: _featurePages,
          ),
          // Positioned(
          //   top: screenHeight * 0.1,
          //   child: Opacity(
          //     opacity: 0.4,
          //     child: SvgPicture.asset(
          //       'assets/logos/spotme_logo.svg',
          //       width: 20.0,
          //     ),
          //   ),
          // ),
          Positioned(
            top: screenHeight * 0.22,
            child: Column(
              children: [
                Text('Sofie',
                    style: GoogleFonts.voces(
                      fontSize: 60,
                    )),
                // Text('Sofie',
                //     style: GoogleFonts.katibeh(
                //       fontSize: 60,
                //     )),
                // Text('Sofie',
                //     style: GoogleFonts.bigShouldersInlineDisplay(
                //       fontSize: 60,
                //     )),
                // Text('Sofie',
                //     style: GoogleFonts.plaster(
                //       fontSize: 60,
                //     )),
                MyText(
                  'Social Fitness Elevated',
                  weight: FontWeight.bold,
                  // Must pass a color to avoid MyText component trying to look up context.theme, which does not exist prior to the user reaching the authed section of the app.
                  color: Styles.white,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            child: Column(
              children: [
                MyButton(
                  text: 'Sign In',
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          fullscreenDialog: true, builder: (_) => SignIn())),
                  backgroundColor: Styles.white,
                  contentColor: Styles.black,
                  withMinWidth: true,
                ),
                SizedBox(height: 12),
                SecondaryButton(
                  text: 'Sign Up to Beta Testing',
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => RegisterBetaTesting())),
                ),
                SizedBox(height: 24),
                BasicProgressDots(
                  numDots: _featurePages.length,
                  currentIndex:
                      _pageController.hasClients && _pageController.page != null
                          ? _pageController.page!.toInt()
                          : 0,
                  color: Styles.peachRed,
                ),
              ],
            ),
          ),
        ],
      ));
    });
  }
}
