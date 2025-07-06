import 'dart:async';

import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_demo/domain/repositories/authentication_repository.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
import 'package:flutter_demo/helper/local_storage_helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationHelper {
  static Future<bool> login({
    required AuthenticationRepository authenticationRepository, 
    required UserLoginRequest request,
    required DataStorageRepository dataStorageRepository,
    FutureOr<void> Function(bool, String, String)? callBack
  }) async {

    bool success = false;

    var result = await authenticationRepository.login(request);

    if(result.isCompleted) {
      final data = result.getData;      

      success = await LocalStorageHelper.saveRefreshToken(
        refreshToken: data?.refreshToken ?? "", 
        dataStorageRepository: dataStorageRepository
      );      

      if(success) {
        Authentication.setToken(
          accessToken: data?.accessToken ?? "",
          refreshToken: data?.refreshToken ?? ""
        );

        if(baseContext.currentContext != null) {
          var parentRef = ProviderScope.containerOf(baseContext.currentContext!);
          parentRef.read(userAvatarProvider.notifier).authentication();
        }
      }
    }

    await callBack?.call(success, Authentication.accessToken, Authentication.refreshToken);

    return success;
  }

  static Future<bool> logout({
    required DataStorageRepository dataStorageRepository,
    FutureOr<void> Function(bool)? callBack
  }) async {    

    final result = await LocalStorageHelper.deleteRefreshToken(dataStorageRepository: dataStorageRepository);

    if(result) {
      Authentication.clearToken();

      if(baseContext.currentContext != null) {
        var parentRef = ProviderScope.containerOf(baseContext.currentContext!);
        parentRef.read(userAvatarProvider.notifier).guest();
      }      
    }    

    await callBack?.call(result);

    return result;
  }

  static Future<bool> checkRefreshTokenStillActive({
    required AuthenticationRepository authenticationRepository,
    required DataStorageRepository dataStorageRepository,
  }) async {
    final refreshToken = await LocalStorageHelper.getRefreshToken(
      dataStorageRepository: dataStorageRepository
    );

    if(refreshToken.isNotEmpty) {
      Authentication.setRefreshToken(refreshToken);

      final result = await getRefreshToken(
        authenticationRepository: authenticationRepository,
        dataStorageRepository: dataStorageRepository
      );

      return result;
    }    

    return false;
  }

  static Future<bool> getRefreshToken({
    required AuthenticationRepository authenticationRepository,
    required DataStorageRepository dataStorageRepository,
  }) async {    

    final response = await authenticationRepository.refresh();

    if(response.isCompleted) {
      final data = response.getData;

      final saveResult = await LocalStorageHelper.saveRefreshToken(
        refreshToken: data?.refreshToken ?? "", 
        dataStorageRepository: dataStorageRepository
      );      

      if(saveResult) {
        Authentication.setToken(
          accessToken: data?.accessToken ?? "",
          refreshToken: data?.refreshToken ?? ""
        );
      }

      return saveResult;
    }

    return false;
  }
}