import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';

enum FONTSIZE {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  eleven,
  twelve
}

Map<FONTSIZE, double> _fontSizeMap = {
  FONTSIZE.one: 11,
  FONTSIZE.two: 14,
  FONTSIZE.three: 16,
  FONTSIZE.four: 18,
  FONTSIZE.five: 22,
  FONTSIZE.seven: 25,
  FONTSIZE.six: 28,
  FONTSIZE.eight: 32,
  FONTSIZE.nine: 38,
  FONTSIZE.ten: 48,
  FONTSIZE.eleven: 58,
  FONTSIZE.twelve: 60,
};

class MyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FONTSIZE size;
  final FontWeight weight;
  final TextOverflow overflow;
  final int? maxLines;
  final Color? color;
  final TextDecoration? decoration;
  final double? lineHeight;
  final bool subtext;

  const MyText(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.size = FONTSIZE.three,
      this.overflow = TextOverflow.ellipsis,
      this.weight = FontWeight.normal,
      this.maxLines = 1,
      this.color,
      this.decoration,
      this.lineHeight = 1.1,
      this.subtext = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
            fontWeight: weight,
            decoration: decoration,
            height: lineHeight,
            fontSize: _fontSizeMap[size],
            color: subtext
                ? context.theme.primary.withOpacity(0.7)
                : color ?? context.theme.primary));
  }
}

class MyHeaderText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FONTSIZE size;
  final FontWeight weight;
  final TextOverflow overflow;
  final int? maxLines;
  final Color? color;
  final TextDecoration? decoration;
  final double? lineHeight;
  final double? letterSpacing;
  final bool subtext;

  const MyHeaderText(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.size = FONTSIZE.three,
      this.overflow = TextOverflow.ellipsis,
      this.weight = FontWeight.bold,
      this.maxLines = 1,
      this.color,
      this.decoration,
      this.lineHeight = 1.1,
      this.subtext = false,
      this.letterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.archivo(
            textStyle: TextStyle(
                fontWeight: weight,
                decoration: decoration,
                height: lineHeight,
                fontSize: _fontSizeMap[size],
                letterSpacing: letterSpacing,
                color: subtext
                    ? context.theme.primary.withOpacity(0.6)
                    : color ?? context.theme.primary)));
  }
}

class H1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;

  const H1(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(text,
        color: color, textAlign: textAlign, size: FONTSIZE.six);
  }
}

class H2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  const H2(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(text,
        color: color, textAlign: textAlign, size: FONTSIZE.five);
  }
}

class H3 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  const H3(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHeaderText(
      text,
      color: color,
      textAlign: textAlign,
      size: FONTSIZE.five,
    );
  }
}

class H4 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  const H4(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHeaderText(
      text,
      color: color,
      textAlign: textAlign,
      size: FONTSIZE.four,
    );
  }
}

/// Use top left of a top nav bar in an IOs-ish style.
class NavBarLargeTitle extends StatelessWidget {
  final String title;
  const NavBarLargeTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyHeaderText(
            title,
            size: FONTSIZE.seven,
          ),
        ],
      ),
    );
  }
}

/// Small size, bold, uppercase letters
class NavBarTitle extends StatelessWidget {
  final String text;
  const NavBarTitle(this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(
      text.toUpperCase(),
      size: FONTSIZE.two,
      textAlign: TextAlign.center,
    );
  }
}

/// For when we want the title to be on the left of the nav bar and an action button on the right.
/// E.g. Selecting from a list before popping.
class LeadingNavBarTitle extends StatelessWidget {
  final String text;
  final FONTSIZE fontSize;
  const LeadingNavBarTitle(this.text,
      {Key? key, this.fontSize = FONTSIZE.three})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          MyHeaderText(
            text.toUpperCase(),
            size: fontSize,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Displays a widget up and to the right of normal text position. i.e super.
class SuperText extends StatelessWidget {
  final Widget child;
  const SuperText({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -8),
      child: child,
    );
  }
}

/// Displays '(required)' in super text pos and style. For inputs.
class RequiredSuperText extends StatelessWidget {
  const RequiredSuperText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SuperText(
      child: Icon(
        CupertinoIcons.exclamationmark_circle_fill,
        size: 14,
        color: Styles.errorRed,
      ),
    );
  }
}

/// Should be the same as MyNavBar style.
class UnderlineTitle extends StatefulWidget {
  final String text;
  const UnderlineTitle(this.text, {Key? key}) : super(key: key);

  @override
  _UnderlineTitleState createState() => _UnderlineTitleState();
}

class _UnderlineTitleState extends State<UnderlineTitle> {
  // Create global key that can track the actual rendered size of the text.
  late GlobalKey globalTextBoxKey;
  double? renderedWidth;

  @override
  void initState() {
    super.initState();
    globalTextBoxKey = GlobalKey();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Get renderBox widths of the text elements.
      renderedWidth = globalTextBoxKey.currentContext!.size!.width;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        key: globalTextBoxKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              MyHeaderText(
                widget.text,
                lineHeight: 1.3,
              ),
              Container(
                height: 2.5,
                width: renderedWidth ?? 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Styles.colorOne,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// Block of text that, on tap, will open a full screen text viewer modal.
class ViewMoreFullScreenTextBlock extends StatelessWidget {
  final String text;
  final String title;
  final int maxLines;
  final TextAlign textAlign;
  final double lineHeight;
  final FONTSIZE? fontSize;
  final bool subtext;
  final Color? textColor;
  const ViewMoreFullScreenTextBlock(
      {Key? key,
      required this.text,
      required this.title,
      this.maxLines = 4,
      this.textAlign = TextAlign.start,
      this.lineHeight = 1.3,
      this.fontSize,
      this.subtext = false,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.showBottomSheet(child: TextViewer(text, title)),
      child: MyText(text,
          maxLines: maxLines,
          textAlign: textAlign,
          lineHeight: lineHeight,
          size: fontSize ?? FONTSIZE.three,
          subtext: subtext,
          color: textColor),
    );
  }
}

class TextViewer extends StatelessWidget {
  final String text;
  final String title;
  const TextViewer(this.text, this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            H2(title),
            const SizedBox(height: 16),
            MyText(
              text,
              maxLines: 999,
            ),
          ],
        ),
      ),
    );
  }
}
