import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmefitness_ui/blocs/theme.dart';
import 'package:spotmefitness_ui/components/text.dart';

class UnAuthedLanding extends StatefulWidget {
  @override
  _UnAuthedLandingState createState() => _UnAuthedLandingState();
}

class _UnAuthedLandingState extends State<UnAuthedLanding> {
  late PageController _pageController;
  late CupertinoThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() => {});
    });
    _themeData = ThemeBloc.darkTheme;
  }

  Widget _logoHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'assets/logos/spotme_fitness_logo.svg',
            width: 50.0,
            color: _themeData.textTheme.textStyle.color,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: MyText(
              'SpotMe Fitness',
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
      theme: ThemeBloc.darkTheme,
      home: CupertinoPageScaffold(
          child: SafeArea(
        child: Column(children: [
          _logoHeader(),
          H1('Sign In'),
          H1('Start Free Trial'),
          Container(
            child: CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(10),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: Icon(CupertinoIcons.envelope_circle),
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CupertinoTextFormFieldRow(
                    prefix: Icon(CupertinoIcons.lock_circle),
                    placeholder: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  )
                ]),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 16),
            child: MyText(
              'Reset password',
              weight: FONTWEIGHT.BOLD,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                SizedBox.expand(
                    child: Container(
                  margin: EdgeInsets.all(4),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    'assets/stock_images/girls_group.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
                SizedBox.expand(
                    child: Container(
                  child: Image.asset(
                    'assets/stock_images/bars_man.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                )),
                SizedBox.expand(
                    child: Container(
                  child: Image.asset(
                    'assets/stock_images/yoga_girl.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
                SizedBox.expand(
                    child: Container(
                  child: Image.asset(
                    'assets/stock_images/bars_man.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
                SizedBox.expand(
                    child: Container(
                  child: Image.asset(
                    'assets/stock_images/girls_group.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsIndicator(
              dotsCount: 5,
              position:
                  _pageController.hasClients && _pageController.page != null
                      ? _pageController.page!
                      : 0,
              decorator: DotsDecorator(
                size: const Size.square(12.0),
                color: CupertinoColors.systemGrey3,
                activeColor: _themeData.primaryColor,
                activeSize: const Size(44.0, 12.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
