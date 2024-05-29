import 'package:flutter/material.dart';
import 'package:flutter_demo/setting/app_theme_setting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 16
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 24
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 32
      )
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
    textTheme: const TextTheme(      
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 16
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 24
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 32
      ),
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

  static ThemeData getTheme() {
    if(AppThemeSetting.isDarkModeEnabled) {
      return AppTheme.darkMode;
    }

    return AppTheme.lightMode;
  }
}