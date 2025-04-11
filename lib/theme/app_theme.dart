import 'package:flutter/material.dart';

class AppTheme {

  static const Color themeSeedColor = Color(0xff887FB1);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: themeSeedColor,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: themeSeedColor,
    brightness: Brightness.dark,
  );

}

