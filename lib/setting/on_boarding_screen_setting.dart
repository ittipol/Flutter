import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreenSetting {

  static Future<bool> get showOnBoardingScreen async => await _showOnBoardingScreen();

  static Future<bool> _showOnBoardingScreen() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (prefs.getBool('show_on_boarding_screen') ?? true) {
      return true;
    }

    return false;
  }
}