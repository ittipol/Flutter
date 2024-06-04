import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {

  static Future<void> clearKeychainValues() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('is_first_app_launch') ?? true) {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
      
      await prefs.setBool('is_first_app_launch', false);
    }
  }

}