import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ThemeColors {
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color black = const Color.fromRGBO(26, 26, 29, 1);
  static Color black10 = const Color.fromRGBO(245, 245, 245, 1);
  static Color black20 = const Color.fromRGBO(234, 234, 234, 1);
  static Color black60 = const Color.fromRGBO(109, 111, 124, 1);
  static Color error = const Color.fromRGBO(211, 34, 14, 1);

  static Color primary = black60;
}
