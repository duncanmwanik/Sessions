import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import '../../_config/styling/styler.dart';

const double pomodoroIcon = 50.0;
const double pomodoro = 30.0;
const double onBoarding = 24.0;
const double title = 22.0;
const double large = 20.0;
const double appBar = 18.0;
const double normal = 16.0;
const double medium = 14.0;
const double small = 12.0;
const double tiny = 10.0;

class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    this.size,
    required this.text,
    this.fontWeight,
    this.overflow,
    this.textColor,
    this.textAlign,
    this.textDecoration,
    this.maxlines,
    this.faded = false,
    this.isCrossed = false,
  }) : super(key: key);

  final double? size;
  final String text;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextDecoration? textDecoration;
  final int? maxlines;
  final bool faded;
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxlines,
      style: TextStyle(
        fontSize: size ?? textSizeNormal,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: textColor ?? (faded ? styler.textColorFaded() : styler.textColor()),
        decoration: textDecoration ?? (isCrossed ? TextDecoration.lineThrough : null),
      ),
    );
  }
}

class PinnedInfoText extends StatelessWidget {
  const PinnedInfoText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: text == 'Pinned' ? 7 : 15, bottom: 15),
      child: AppText(size: small, text: text),
    );
  }
}

class HtmlText extends StatelessWidget {
  const HtmlText({Key? key, this.size = medium, required this.text, this.overflow, this.textAlign}) : super(key: key);

  final double size;
  final String text;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w500, color: styler.textColor()),
      tags: {
        'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.w700, color: styler.textColor(), fontSize: size)),
      },
    );
  }
}
