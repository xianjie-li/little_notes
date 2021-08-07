
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyleVars {
  /* 文字 */
  static const double fs = 16;
  static const double fsSM = 14;
  static const double fsLG = 18;
  static const double fsXL = 24;

  /* 边距 */
  static const double padding = 12;
  static const double paddingSM = 8;
  static const double paddingLG = 16;

  /* 圆角 */
  static const double radius = 6;
  static const double radiusSM = 4;
  static const double radiusLG = 8;
  static const double radiusML = 12;

  /* 颜色 */
  static final Color themeFontColor = Colors.pink.shade300;
  static final Color colorSecond = Colors.black54;
  // 文字颜色
  static final Color colorTitle = Colors.black87;
  static final Color color = Color(0xFF101010);
  // 配色
  static const MaterialColor theme = MaterialColor(
    _themePrimaryValue,
    <int, Color>{
      50: Color(0xFFfff0f6),
      100: Color(0xFFfff0f3),
      200: Color(0xFFfff0f4),
      300: Color(0xFFffe0ea),
      400: Color(0xFFffb8cf),
      500: Color(_themePrimaryValue),
      600: Color(0xffef6198),
      700: Color(0xffdc4e8b),
      800: Color(0xffd03176),
      900: Color(0xFFD01876),
    },
  );
  static const int _themePrimaryValue = 0xFFff8eb8;
}
