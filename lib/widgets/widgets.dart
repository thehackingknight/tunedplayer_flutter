import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';

Widget T_Marquee(text,
    {double fs = 20,
    FontWeight fw = FontWeight.w500,
    double h = 30,
    double w = 228}) {
  return SizedBox(
    width: w,
    height: h,
    child: Marquee(
      text: text,
      velocity: 10,
      style: TextStyle(fontSize: fs, fontWeight: fw),
    ),
  );
}

Widget SizedText(String txt, TextStyle style, {double h = 22, double w = 250}) {
  return SizedBox(
    width: w,
    height: h,
    child: Text(
      txt,
      style: style,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    ),
  );
}
