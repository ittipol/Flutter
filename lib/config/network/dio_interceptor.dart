import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DioInterceptor extends Interceptor {

  final ignoredPaths = [ApiEndPointConstant.refreshToken];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    debugPrint("--------------------- onRequest ======> [ ${options.path} ]");

    if(Authentication.isLoggedIn) {      
      if(options.path == ApiEndPointConstant.refreshToken) {
        options.headers['Authorization'] = "Bearer ${Authentication.refreshToken}";
      }else {
        options.headers['Authorization'] = "Bearer ${Authentication.accessToken}";
      }
    }      

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {

    debugPrint("--------------------- onResponse ======>");

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
        final authenticationRepository = AuthenticationRepositoryImpl(
          authenticationRemoteDataSources: AuthenticationRemote(dio: DioOption().init(baseUrl: ApiBaseUrl.localhostBaseUrl))
        );
        final dataStorageRepository = DataStorageRepositoryImpl(
          dataStorageLocalDataSources: DataStorageLocal()
        );

        int retry = 0;
        if(err.requestOptions.headers['retry'] != null) {
          retry = err.requestOptions.headers['retry'];
        }

        if(isIgnoredPath) {
          await _logout(dataStorageRepository);

          // Return to prevent the next interceptor in the chain from being executed.
          // return;
        }else if(Authentication.isLoggedIn && retry < 1) {

          // get new refresh token
          await AuthenticationHelper.getRefreshToken(
            authenticationRepository: authenticationRepository,
            dataStorageRepository: dataStorageRepository,
          );  

          try {
            err.requestOptions.headers['retry'] = ++retry;
            return handler.resolve(await _retry(err.requestOptions));
          } on DioException catch (e) {
            // If the request fails again, pass the error to the next interceptor in the chain.
            return handler.next(e);
          }       

        }else {
          await _logout(dataStorageRepository);                   
        }           

        break;
      default:
    }

    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final dio = DioOption().init(baseUrl: ApiBaseUrl.localhostBaseUrl);
    requestOptions.contentType = Headers.jsonContentType;
    return await dio.fetch(requestOptions);
  }

  Future<void> _showDialog() async {

    if(modalDialogKey.currentContext == null && baseContext.currentContext != null) {            
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

  Future<void> _logout(DataStorageRepositoryImpl dataStorageRepository) async {
    final result = await AuthenticationHelper.logout(dataStorageRepository: dataStorageRepository);

    if(result) {
      await _showDialog();
    }
  }

}