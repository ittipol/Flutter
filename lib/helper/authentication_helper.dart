import 'package:flutter/foundation.dart';
import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/helper/local_storage_helper.dart';
import 'package:flutter_demo/setting/app_api_url_setting.dart';

class AuthenticationHelper {
  static void logout({void Function()? callBack}) {
    Authentication.logout();

    LocalStorageHelper.deleteRefreshToken(dataStorageRepository: DataStorageRepositoryImpl(
      dataStorageLocalDataSources: DataStorageLocal()
    ));

    callBack?.call();
  }

  static Future<void> getToken() async {
    final refreshToken = await LocalStorageHelper.getRefreshToken();

    debugPrint("ZZZZ+++++++++++++>>>>>>>>>>>>>> getRefreshToken ----- [ $refreshToken ]");

    if(refreshToken.isNotEmpty) {
      Authentication.refreshToken = refreshToken;
      await getNewRefreshToken();
    }    
  }

  static Future<bool> getNewRefreshToken() async {    

    final authenticationRepository = AuthenticationRepositoryImpl(
      authenticationRemoteDataSources: AuthenticationRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl))
    );

    // final api = AuthenticationRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl));
    final response = await authenticationRepository.refresh();

    if(response.isCompleted) {

      final data = response.getData;

      Authentication.accessToken = data?.accessToken ?? "";
      Authentication.refreshToken = data?.refreshToken ?? "";

      LocalStorageHelper.saveRefreshToken(refreshToken: Authentication.refreshToken, dataStorageRepository: DataStorageRepositoryImpl(
        dataStorageLocalDataSources: DataStorageLocal()
      ));

      return true;
    }

    return false;
  }
}