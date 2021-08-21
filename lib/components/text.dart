import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

enum FONTSIZE {
  TINY,
  SMALL,
  MAIN,
  BIG,
  LARGE,
  HUGE,
  TABTITLE,
  DISPLAY,
  GIANT,
  EXTREME
}

const Map<FONTSIZE, double> _fontSizeMap = {
  FONTSIZE.TINY: 11,
  FONTSIZE.SMALL: 14,
  FONTSIZE.MAIN: 16,
  FONTSIZE.BIG: 18,
  FONTSIZE.LARGE: 21,
  FONTSIZE.HUGE: 24,
  FONTSIZE.DISPLAY: 40,
  FONTSIZE.GIANT: 50,
  FONTSIZE.EXTREME: 60,
  FONTSIZE.TABTITLE: 22,
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

  MyText(this.text,
      {this.textAlign = TextAlign.start,
      this.size = FONTSIZE.MAIN,
      this.overflow = TextOverflow.ellipsis,
      this.weight = FontWeight.normal,
      this.maxLines = 1,
      this.color,
      this.decoration,
      this.lineHeight = 1.1,
      this.subtext = false});

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
                ? context.theme.primary.withOpacity(0.6)
                : color != null
                    ? color
                    : context.theme.primary));
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

  MyHeaderText(this.text,
      {this.textAlign = TextAlign.start,
      this.size = FONTSIZE.MAIN,
      this.overflow = TextOverflow.ellipsis,
      this.weight = FontWeight.bold,
      this.maxLines = 1,
      this.color,
      this.decoration,
      this.lineHeight = 1.1,
      this.subtext = false,
      this.letterSpacing});

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
                    : color != null
                        ? color
                        : context.theme.primary)));
  }
}

class H1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  H1(this.text,
      {this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis});
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(text,
        color: color,
        textAlign: textAlign,
        size: FONTSIZE.HUGE,
        weight: FontWeight.bold,
        overflow: TextOverflow.ellipsis);
  }
}

class H2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  H2(this.text,
      {this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis});
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(text,
        color: color,
        textAlign: textAlign,
        size: FONTSIZE.LARGE,
        weight: FontWeight.bold,
        overflow: TextOverflow.ellipsis);
  }
}

class H3 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  H3(this.text,
      {this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis});
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(
      text,
      color: color,
      textAlign: textAlign,
      size: FONTSIZE.LARGE,
      weight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class H4 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final TextOverflow overflow;
  H4(this.text,
      {this.textAlign = TextAlign.start,
      this.color,
      this.overflow = TextOverflow.ellipsis});
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(
      text,
      color: color,
      textAlign: textAlign,
      size: FONTSIZE.BIG,
      weight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Use top left of a top nav bar in an IOs-ish style.
class NavBarLargeTitle extends StatelessWidget {
  final String title;
  NavBarLargeTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyHeaderText(
            title,
            textAlign: TextAlign.start,
            size: FONTSIZE.TABTITLE,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

/// Small size, bold, uppercase letters
class NavBarTitle extends StatelessWidget {
  final String text;
  NavBarTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return MyHeaderText(
      text.toUpperCase(),
      size: FONTSIZE.SMALL,
      weight: FontWeight.bold,
      textAlign: TextAlign.center,
    );
  }
}

/// Displays '(required)' in super text pos and style. For inputs.
class RequiredSuperText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(2, -8),
      child: MyText(
        '(required)',
        color: Styles.errorRed,
        weight: FontWeight.bold,
        size: FONTSIZE.TINY,
      ),
    );
  }
}

/// Should be the same as MyNavBar style.
class UnderlineTitle extends StatefulWidget {
  final String text;
  UnderlineTitle(this.text);

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
                weight: FontWeight.bold,
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
  const ViewMoreFullScreenTextBlock(
      {Key? key,
      required this.text,
      required this.title,
      this.maxLines = 4,
      this.textAlign = TextAlign.start,
      this.lineHeight = 1.3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.showBottomSheet(child: TextViewer(text, title)),
      child: MyText(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        lineHeight: lineHeight,
      ),
    );
  }
}

class TextViewer extends StatelessWidget {
  final String text;
  final String title;
  TextViewer(this.text, this.title);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            H2(title),
            SizedBox(height: 16),
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
