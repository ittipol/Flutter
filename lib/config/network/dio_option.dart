import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/dio_interceptor.dart';

class DioOption {

  Dio init() {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: "https://pokeapi.co",
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