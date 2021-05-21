import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

enum FONTSIZE { TINY, SMALL, MAIN, BIG, LARGE, HUGE, DISPLAY }

const Map<FONTSIZE, double> _fontSizeMap = {
  FONTSIZE.TINY: 11,
  FONTSIZE.SMALL: 14,
  FONTSIZE.MAIN: 16,
  FONTSIZE.BIG: 18,
  FONTSIZE.LARGE: 20,
  FONTSIZE.HUGE: 24,
  FONTSIZE.DISPLAY: 40
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
      this.lineHeight = 1.5,
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
    return MyText(text,
        color: color,
        textAlign: textAlign,
        size: FONTSIZE.HUGE,
        lineHeight: 1.6,
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
    return MyText(text,
        color: color,
        textAlign: textAlign,
        size: FONTSIZE.LARGE,
        lineHeight: 1.6,
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
    return MyText(
      text,
      color: color,
      textAlign: textAlign,
      size: FONTSIZE.BIG,
      lineHeight: 1.6,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        H1(
          title,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

/// Small size, bold, uppercase letters
class NavBarTitle extends StatelessWidget {
  final String text;
  NavBarTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return MyText(text.toUpperCase(),
        size: FONTSIZE.SMALL, weight: FontWeight.bold);
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
              MyText(
                widget.text,
                weight: FontWeight.bold,
                lineHeight: 1.2,
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

// class H extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final double fontSize;
//   final TextOverflow overflow;

//   H(this.text,
//       {this.color,
//       this.textAlign = TextAlign.start,
//       this.fontSize,
//       this.overflow = TextOverflow.ellipsis})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return MyText(
//       text,
//       bold: true,
//       fontSize: fontSize,
//       color: color,
//       textAlign: textAlign,
//       overflow: overflow,
//     );
//   }
// }

// class H1 extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final TextOverflow overflow;

//   H1(this.text,
//       {this.color, this.textAlign, this.overflow = TextOverflow.ellipsis})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return H(
//       text,
//       fontSize: Styles.fontSizeH1,
//       color: color,
//       textAlign: textAlign,
//       overflow: overflow,
//     );
//   }
// }

// class H2 extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final TextOverflow overflow;

//   H2(this.text,
//       {this.color, this.textAlign, this.overflow = TextOverflow.ellipsis})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return H(
//       text,
//       fontSize: Styles.fontSizeH2,
//       color: color,
//       textAlign: textAlign,
//       overflow: overflow,
//     );
//   }
// }

// class H3 extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final TextOverflow overflow;

//   H3(this.text,
//       {this.color, this.textAlign, this.overflow = TextOverflow.ellipsis})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return H(
//       text,
//       fontSize: Styles.fontSizeH3,
//       color: color,
//       textAlign: textAlign,
//       overflow: overflow,
//     );
//   }
// }

// class LargeText extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final bool bold;
//   final int maxLines;
//   final TextOverflow overflow;

//   /// subtext will fade the text by adding some opacity.
//   final bool subtext;

//   LargeText(this.text,
//       {this.color,
//       this.textAlign,
//       this.bold = false,
//       this.subtext = false,
//       this.maxLines,
//       this.overflow})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return MyText(
//       text,
//       fontSize: Styles.fontSizeH2,
//       color: color,
//       subtext: subtext,
//       bold: bold,
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
// }

// class SmallText extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final bool bold;
//   final int maxLines;
//   final TextOverflow overflow;

//   /// subtext will fade the text by adding some opacity.
//   final bool subtext;

//   SmallText(this.text,
//       {this.color,
//       this.textAlign,
//       this.bold = false,
//       this.subtext = false,
//       this.maxLines,
//       this.overflow})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return MyText(
//       text,
//       fontSize: Styles.fontSizeSmall,
//       color: color,
//       subtext: subtext,
//       bold: bold,
//       textAlign: textAlign,
//       maxLines: maxLines,
//       overflow: overflow,
//     );
//   }
// }

// class TinyText extends StatelessWidget {
//   final String text;
//   final Color color;
//   final TextAlign textAlign;
//   final bool bold;

//   /// subtext will fade the text by adding some opacity.
//   final bool subtext;
//   final int maxLines;
//   final TextOverflow overflow;

//   TinyText(this.text,
//       {this.color,
//       this.textAlign,
//       this.bold = false,
//       this.subtext = false,
//       this.maxLines,
//       this.overflow})
//       : assert(text != null);

//   @override
//   Widget build(BuildContext context) {
//     return MyText(text,
//         fontSize: Styles.fontSizeTiny,
//         color: color,
//         subtext: subtext,
//         bold: bold,
//         textAlign: textAlign,
//         overflow: overflow,
//         maxLines: maxLines);
//   }
// }

// class InfoDialogTitle extends StatelessWidget {
//   final String text;
//   InfoDialogTitle(this.text);
//   @override
//   Widget build(BuildContext context) {
//     return H3(
//       text,
//     );
//   }
// }

// class InfoDialogText extends StatelessWidget {
//   final String text;
//   InfoDialogText(this.text);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0, bottom: 4, left: 6, right: 6),
//       child: MyText(
//         text,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }
