import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
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

  static Future<String> getRefreshToken() async {
    final storage = DataStorageLocal();
    final readResult = await storage.getData();

    if(readResult.isCompleted) {
      final data = readResult.getData ?? DataStorageEntity();      
      return data.refreshToken ?? "";
    }

    return "";
  }

  static Future<bool> saveRefreshToken({required DataStorageRepository dataStorageRepository, required String refreshToken}) async {
  
    if(refreshToken.isEmpty) {
      return false;
    }    

    final readResult = await dataStorageRepository.getData();
    if(readResult.isCompleted) {

      var data = readResult.getData ?? DataStorageEntity();
      data = data.copyWith(refreshToken: refreshToken);

      final saveResult = await dataStorageRepository.saveData(data);
      if(saveResult.isCompleted) {
        return true;
      }
    }    
    
    return false;
  }

  static Future<bool> deleteRefreshToken({required DataStorageRepository dataStorageRepository}) async {

    final readResult = await dataStorageRepository.getData();
    if(readResult.isCompleted) {

      var data = readResult.getData ?? DataStorageEntity();
      data = data.copyWith(refreshToken: "");

      final saveResult = await dataStorageRepository.saveData(data);
      if(saveResult.isCompleted) {
        return true;
      }
    }    
    
    return false;
  }

}