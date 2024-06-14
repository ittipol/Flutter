import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/dio_interceptor.dart';

class DioOption {

  Dio init({required String baseUrl, Map<String, dynamic>? headers, bool enableInterceptor = true}) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if(enableInterceptor) {
      dio.interceptors.add(DioInterceptor());
    }    

    return dio;
  }

}