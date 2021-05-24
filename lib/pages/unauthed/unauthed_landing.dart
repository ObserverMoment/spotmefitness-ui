import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/pages/unauthed/start_trial.dart';

import 'sign_in.dart';

class UnAuthedLanding extends StatefulWidget {
  @override
  _UnAuthedLandingState createState() => _UnAuthedLandingState();
}

class _UnAuthedLandingState extends State<UnAuthedLanding> {
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
        child: RoundedBox(
      child: Image.asset(
        'assets/stock_images/gym.jpg',
        fit: BoxFit.cover,
      ),
    )),
    SizedBox.expand(
        child: RoundedBox(
      child: Image.asset(
        'assets/stock_images/stretch.jpg',
        fit: BoxFit.fitHeight,
      ),
    )),
    SizedBox.expand(
        child: RoundedBox(
      child: Image.asset(
        'assets/stock_images/bars_man.jpg',
        fit: BoxFit.cover,
      ),
    )),
    SizedBox.expand(
        child: RoundedBox(
      child: Image.asset(
        'assets/stock_images/yoga_girl.jpg',
        fit: BoxFit.cover,
      ),
    )),
    SizedBox.expand(
        child: RoundedBox(
      child: Image.asset(
        'assets/stock_images/skip.jpg',
        fit: BoxFit.cover,
      ),
    )),
  ];

  Widget _logoHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'assets/logos/spotme_logo.svg',
            width: 60.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 10.0),
            child: MyText(
              'SpotMe Fitness',
              weight: FontWeight.bold,
              // Must pass a color to avoid MyText component trying to look up context.theme, which does not exist prior to the user reaching the authed section of the app.
              color: Styles.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.cupertinoDarkData,
        home: Builder(
          builder: (context) => CupertinoPageScaffold(
              child: SafeArea(
            top: false,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  controller: _pageController,
                  children: _featurePages,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _logoHeader(),
                ),
                Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: BasicProgressDots(
                            numDots: _featurePages.length,
                            currentIndex: _pageController.hasClients &&
                                    _pageController.page != null
                                ? _pageController.page!.toInt()
                                : 0,
                            color: Styles.white,
                          ),
                        ),
                        PrimaryButton(
                            text: 'Sign In',
                            onPressed: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (_) => SignIn()))),
                        SizedBox(height: 10),
                        SecondaryButton(
                          text: 'Free Trial',
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (_) => StartTrial())),
                        ),
                        SizedBox(height: 32),
                      ],
                    ))
              ],
            ),
          )),
        ));
  }
}
