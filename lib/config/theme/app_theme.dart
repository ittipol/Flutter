import 'package:flutter/material.dart';

final class AppTheme {

  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      onBackground: Colors.grey.shade300,
      background: Colors.white,
      primary: Colors.blue.shade800,
      secondary: Colors.blue.shade700,
      tertiary: Colors.blue.shade600,
      onSurface: Colors.black
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.white,
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarBrightness: Brightness.light,
      // )
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade800,
    )
  );

  static final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      onBackground: Colors.grey.shade700,
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      tertiary: Colors.grey.shade600,
      onSurface: Colors.white
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.black,
      //   statusBarIconBrightness: Brightness.light,
      //   statusBarBrightness: Brightness.dark
      // )
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey.shade900,
    )
  );
}