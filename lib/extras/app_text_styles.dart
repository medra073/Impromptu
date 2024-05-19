import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle appleSDGothicNeo(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var textStyle = TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "AppleSDGothicNeo");
    return textStyle;
  }
}
