import 'package:flutter/material.dart';
import 'package:habit_tracker/core/style/colors.dart' as app;

class Fonts {
  Fonts._();

  static const TextStyle titleTextStyle = TextStyle(
    inherit: false,
    color: app.Colors.text,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    fontFamily: 'MPLUSRounded1c',
  );
  static TextStyle navigationBarItemTextStyle(bool active) {
    return TextStyle(
      inherit: false,
      color: app.Colors.text,
      fontSize: 14,
      fontWeight: active ? FontWeight.w800 : FontWeight.w500,
      letterSpacing: -0.5,
      fontFamily: 'MPLUSRounded1c',
      height: 1.26,
    );
  }
}
