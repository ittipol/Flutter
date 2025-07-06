import 'package:shared_preferences/shared_preferences.dart';

class AppThemeHelper {
  static bool _darkMode = false;
  static bool get isDarkModeEnabled => _darkMode;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('dark_theme') == null) {          
      await prefs.setBool('dark_theme', false);
    }

    _darkMode = prefs.getBool('dark_theme') ?? false;
  }

  static Future<void> setDarkMode(bool value) async {    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_theme', value);

    _darkMode = value;
  }
}