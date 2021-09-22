import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/pages/unauthed/register_beta_testing/register_beta_testing.dart';
import 'package:sofie_ui/pages/unauthed/sign_in.dart';

class UnauthedLandingPage extends StatefulWidget {
  const UnauthedLandingPage({Key? key}) : super(key: key);

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

  final List<Widget> _featurePages = [
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
            top: screenHeight * 0.10,
            child: SvgPicture.asset('assets/logos/sofie_logo.svg',
                width: 40, color: Styles.white),
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
                const MyText(
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
                  onPressed: () => Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => const SignIn())),
                  backgroundColor: Styles.white,
                  contentColor: Styles.black,
                ),
                const SizedBox(height: 12),
                SecondaryButton(
                  text: 'Sign Up to Beta Testing',
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => const RegisterBetaTesting())),
                ),
                const SizedBox(height: 24),
                BasicProgressDots(
                  numDots: _featurePages.length,
                  currentIndex:
                      _pageController.hasClients && _pageController.page != null
                          ? _pageController.page!.toInt()
                          : 0,
                  color: Styles.neonBlueOne,
                ),
              ],
            ),
          ),
        ],
      ));
    });
  }
}
