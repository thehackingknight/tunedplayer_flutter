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
