import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/pages/unauthed/register_beta_testing/register_beta_testing.dart';
import 'package:spotmefitness_ui/pages/unauthed/sign_in.dart';

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
          Positioned(
            top: screenHeight * 0.22,
            child: Column(
              children: [
                Text('Sofie',
                    style: GoogleFonts.voces(
                      fontSize: 60,
                      color: Styles.white,
                    )),
                MyText(
                  'Social Fitness Elevated',
                  weight: FontWeight.bold,
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
                      context, CupertinoPageRoute(builder: (_) => SignIn())),
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
