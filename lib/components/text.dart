import 'package:flutter/cupertino.dart';

const double HUGE_FONT_SIZE = 24;
const double LARGE_FONT_SIZE = 20;
const double MAIN_FONT_SIZE = 16;
const double SMALL_FONT_SIZE = 13;
const double TINY_FONT_SIZE = 11;

enum FONTWEIGHT { LIGHT, REGULAR, BOLD }

const fontWeightMap = {
  FONTWEIGHT.LIGHT: FontWeight.w300,
  FONTWEIGHT.REGULAR: FontWeight.w400,
  FONTWEIGHT.BOLD: FontWeight.w500,
};

class MyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double size;
  final FONTWEIGHT weight;
  final TextOverflow overflow;
  final int? maxLines;

  MyText(
    this.text, {
    this.textAlign = TextAlign.start,
    this.size = MAIN_FONT_SIZE,
    this.overflow = TextOverflow.ellipsis,
    this.weight = FONTWEIGHT.REGULAR,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontWeight: fontWeightMap[weight],
          fontSize: size,
        ));
  }
}

class H1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  H1(this.text, {this.textAlign = TextAlign.start});
  @override
  Widget build(BuildContext context) {
    return MyText(text,
        textAlign: textAlign, size: HUGE_FONT_SIZE, weight: FONTWEIGHT.BOLD);
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
