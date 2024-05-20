import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    // options.headers['Authorization'] = "Bearer ";

    debugPrint("--------------------- onRequest ======>");

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

    debugPrint(err.message);

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
    handler.next(err);

    // super.onError(err, handler);
  }

  // Future<Response<dynamic>> _refreshToken() async {
  //  var response = await dio.post(APIs._refreshToken,
  //       options: Options(headers: {"Refresh-Token": "[refresh-token]" }));

  //   // on success response, deserialize the response
  //   if (response.statusCode == 200) {
  //     // LoginRequestResponse requestResponse =
  //     //    LoginRequestResponse.fromJson(response.data);
  //     // UPDATE the STORAGE with new access and refresh-tokens
  //     return response;
  //   }
  // }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: {
  //       "Authorization": "Bearer ${token}",
  //     },
  //   );
  
  //   // Retry the request with the new `RequestOptions` object.
  //   return dio.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options
  //   );
  // }

}