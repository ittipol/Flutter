import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/dio_interceptor.dart';
import 'package:flutter_demo/core/constant/app_constant.dart';

class DioOption {

  Dio init({String baseUrl = AppConstant.baseUrl}) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      headers: {
        "Content-Type": "application/json"
      }
    );

    dio.interceptors.add(DioInterceptor());

    return dio;
  }

}