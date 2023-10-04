import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsTheme {
  ColorScheme lightColorsScheme() =>
      const ColorScheme.light(
          primary: Color(0xff5e6cc2),
          primaryContainer: Color(0xff414a86),
          onPrimary: Colors.white,
          secondary: Color(0xffbf4c55),
          secondaryContainer: Color(0xff933a41),
          onSecondary: Colors.white,
          tertiary: Color(0xff454555),
          surface: Colors.white,
          onSurface: Colors.black87
      );
}