import 'package:flutter/cupertino.dart';

enum FONTSIZE { TINY, SMALL, MAIN, LARGE, HUGE }

const Map<FONTSIZE, double> _fontSizeMap = {
  FONTSIZE.TINY: 11,
  FONTSIZE.SMALL: 13,
  FONTSIZE.MAIN: 16,
  FONTSIZE.LARGE: 20,
  FONTSIZE.HUGE: 24
};

enum FONTWEIGHT { LIGHT, REGULAR, BOLD }

const Map<FONTWEIGHT, FontWeight> _fontWeightMap = {
  FONTWEIGHT.LIGHT: FontWeight.w300,
  FONTWEIGHT.REGULAR: FontWeight.w400,
  FONTWEIGHT.BOLD: FontWeight.w500,
};

class MyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FONTSIZE size;
  final FONTWEIGHT weight;
  final TextOverflow overflow;
  final int? maxLines;
  final Color? color;
  final TextDecoration? decoration;

  MyText(this.text,
      {this.textAlign = TextAlign.start,
      this.size = FONTSIZE.MAIN,
      this.overflow = TextOverflow.ellipsis,
      this.weight = FONTWEIGHT.REGULAR,
      this.maxLines = 1,
      this.color,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
            fontWeight: _fontWeightMap[weight],
            decoration: decoration,
            fontSize: _fontSizeMap[size],
            color: color));
  }
}

class H1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  H1(this.text, {this.textAlign = TextAlign.start});
  @override
  Widget build(BuildContext context) {
    return MyText(text,
        textAlign: textAlign, size: FONTSIZE.HUGE, weight: FONTWEIGHT.BOLD);
  }
}

class H2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  H2(this.text, {this.textAlign = TextAlign.start});
  @override
  Widget build(BuildContext context) {
    return MyText(text,
        textAlign: textAlign, size: FONTSIZE.LARGE, weight: FONTWEIGHT.BOLD);
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
