import 'package:flutter/material.dart';

class CColors {
  static var darkBlue = const Color(0xFF50499B);
  static var primary = const Color(0xFF6A61CF);
  static var lightPurple = const Color(0xFFDDDBF1);
  static var mediumPurple = const Color(0xFFBBB7E7);
  static var purple = const Color(0xFFBCB8E7);
  static var lightGrey = const Color(0xFFD9D9D9);

  static var backgroundGradient =  LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFBCB8E7),
        Colors.grey[50] ?? Colors.grey.withOpacity(0.5),
      ]);

  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, CColors.getSwatch(color));
  }

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;
    const lowDivisor = 6;
    const highDivisor = 5;
    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;
    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}
