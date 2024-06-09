import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/helper/local_storage_helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_demo/setting/app_api_url_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DioInterceptor extends Interceptor {

  final ignoredPaths = [ApiEndPointConstant.refreshToken];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    debugPrint("--------------------- onRequest ======> [ ${options.path} ]");

    if(Authentication.isLoggedIn) {      
      debugPrint("--------------------- onRequest [ ${options.path == ApiEndPointConstant.refreshToken} ]");      

      if(options.path == ApiEndPointConstant.refreshToken) {
        debugPrint("#######################--------------------- refreshToken start ======> XXXX");
        options.headers['Authorization'] = "Bearer ${Authentication.refreshToken}";
      }else {
        options.headers['Authorization'] = "Bearer ${Authentication.accessToken}";
      }
    }    
    
    // options.headers["Content-Type"] = "application/json";    

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {

    debugPrint("--------------------- onResponse ======> [ ${response.realUri} ]");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    
    debugPrint("--------------------- onError ======>");
    debugPrint("--------------------- onError [HttpStatus] ======> [ ${err.response?.statusCode} ]");

    switch (err.response?.statusCode) {
      case HttpStatus.badRequest:
        return handler.next(err);
      case HttpStatus.unauthorized:

        final isIgnoredPath = ignoredPaths.contains(err.requestOptions.path);

        int retry = 0;
        if(err.requestOptions.headers['retry'] != null) {
          retry = err.requestOptions.headers['retry'];
        }

        if(!isIgnoredPath && Authentication.isLoggedIn && retry < 0) {                    

          // get new refresh token
          await AuthenticationHelper.getNewRefreshToken();

          // if(result) {
          //   try {
          //     err.requestOptions.headers['retry'] = ++retry;
          //     return handler.resolve(await _retry(err.requestOptions));
          //   } on DioException catch (e) {
          //     // If the request fails again, pass the error to the next interceptor in the chain.
          //     return handler.next(e);
          //   }
          // }else {
          //   // logout
          //   var parentRef = ProviderScope.containerOf(baseContext.currentContext!);
            
          //   Authentication.logout();
          //   // await parentRef.read(landingPageStateProvider.notifier).loginGuest();
          //   parentRef.read(userHomeProvider.notifier).update(isLoggedIn: false);

          //   Navigator.popUntil(baseContext.currentContext!, (route) => route.settings.name == RouteName.home);
          // }

          try {
            err.requestOptions.headers['retry'] = ++retry;
            return handler.resolve(await _retry(err.requestOptions));
          } on DioException catch (e) {
            // If the request fails again, pass the error to the next interceptor in the chain.
            return handler.next(e);
          }
                            
          // Return to prevent the next interceptor in the chain from being executed.
          // return;
        }else {

          // show dialog
          if(modalDialogKey.currentContext == null) {            

            AuthenticationHelper.logout();                      

            await ModalDialogWidget().showModalDialogWithOkButton(
              context: baseContext.currentContext!,
              body: Text(
                "Session expired",
                textAlign: TextAlign.center,
                style: const TextStyle().copyWith(
                  fontSize: 16.spMin,
                  color: Colors.black
                ),
              ),
              onTap: () {

                var parentRef = ProviderScope.containerOf(baseContext.currentContext!);
                if(parentRef.read(isShowLoaderOverlayProvider.notifier).isLoaderOverlayShow()) {
                  parentRef.read(isShowLoaderOverlayProvider.notifier).hide();
                }

                if(Navigator.canPop(baseContext.currentContext!)) Navigator.popUntil(baseContext.currentContext!, (route) => route.settings.name == RouteName.home);
              }
            );
          }          
                  
        }           

        break;
      default:
    }

    // if (err.response?.statusCode == 401) {
    //   // Refresh the user's authentication token.
    //   await _refreshToken();
    //   // Retry the request.
    //   try {
    //     handler.resolve(await _retry(err.requestOptions));
    //   } on DioException catch (e) {
    //     // If the request fails again, pass the error to the next interceptor in the chain.
    //     handler.next(e);
    //   }
    //   // Return to prevent the next interceptor in the chain from being executed.
    //   return;
    // }

    // Pass the error to the next interceptor in the chain.
    // handler.next(err);

    super.onError(err, handler);
  }

  // Future<bool> _refreshToken() async {    

  //   final api = AuthenticationRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl));
  //   final response = await api.refresh();

  //   if(response.isCompleted) {
  //     final data = response.getData;

  //     Authentication.accessToken = data?.accessToken ?? "";
  //     Authentication.refreshToken = data?.refreshToken ?? "";

  //     // _saveData(Authentication.refreshToken);
  //     LocalStorageHelper.saveRefreshToken(refreshToken: Authentication.refreshToken, dataStorageRepository: DataStorageRepositoryImpl(
  //       dataStorageLocalDataSources: DataStorageLocal()
  //     ));

  //     return true;
  //   }

  //   return false;

  // //  var response = await dio.post(APIs._refreshToken,
  // //       options: Options(headers: {"Refresh-Token": "[refresh-token]" }));

  //   // // on success response, deserialize the response
  //   // if (response.statusCode == 200) {
  //   //   // LoginRequestResponse requestResponse =
  //   //   //    LoginRequestResponse.fromJson(response.data);
  //   //   // UPDATE the STORAGE with new access and refresh-tokens
  //   //   return response;
  //   // }
  // }

  // Future<bool> _saveData(String refreshToken) async {
  //   if(refreshToken.isEmpty) {
  //     return false;
  //   }

  //   final storage = DataStorageLocal();

  //   final readResult = await storage.getData();
  //   if(readResult.isCompleted) {

  //     var data = readResult.getData ?? DataStorageEntity();
  //     data = data.copyWith(refreshToken: refreshToken);

  //     final saveResult = await storage.saveData(data);
  //     if(saveResult.isCompleted) {
  //       return true;
  //     }
  //   }    
    
  //   return false;
  // }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final dio = DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl);
    requestOptions.contentType = Headers.jsonContentType;
    return await dio.fetch(requestOptions);
  }

}