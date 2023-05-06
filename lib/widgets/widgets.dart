import 'package:flutter/widgets.dart';
import 'package:marquee/marquee.dart';

Widget T_Marquee(text,
    {double fs = 20,
    FontWeight fw = FontWeight.w500,
    double h = 30,
    double w = 228}) {
  return FractionallySizedBox(
    widthFactor: w,
    heightFactor: h,
    child: Marquee(
      text: text,
      velocity: 10,
      style: TextStyle(fontSize: fs, fontWeight: fw),
    ),
  );
}

class SizedText extends StatefulWidget {

  String txt;
  TextStyle style;
  double h;
  double w;

   SizedText({Key? key, required this.txt, required this.style, this.h = 22, required this.w}) : super(key: key);

  @override
  State<SizedText> createState() => _SizedTextState();
}

class _SizedTextState extends State<SizedText> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: widget.w,
      height: widget.h,
      child: Text(
       widget. txt,
        style: widget.style,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }
}

