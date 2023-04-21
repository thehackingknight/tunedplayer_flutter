import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const TAG = "tunedplayer: ";
const orange = Color.fromRGBO(255, 106, 6, 1);
const orange_2 = Color.fromRGBO(255, 134, 54, 0.979);

void print(msg) {
  debugPrint("$TAG $msg");
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

double calcSize(double size, double max) {
  var percentage = (size / max);
  print(max);
  print(percentage);

  return max * percentage;
}
