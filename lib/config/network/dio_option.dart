import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_demo/config/network/dio_interceptor.dart';
import 'package:flutter_demo/data/app/certificate.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class DioOption {

  List<String> exceptUrlList = [
    "https://localhost:5050"
  ];
  
  Dio init({required String baseUrl, Map<String, dynamic>? headers, bool enableInterceptor = true, bool checkCertificatePinning = true}) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if(checkCertificatePinning && !_isExceptUrl(exceptUrlList, baseUrl)) {
      // Cannot use with self-signed certificate
      dio.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: Certificate.allowedSHAFingerprints));
    }else {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();

        // Check self-signed certificate pinning
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {

          // if (host.isNotEmpty && host == "localhost") {
          //   return true;
          // }

          if(cert.pem.isNotEmpty && cert.pem == Certificate.certificate) {
            return true;
          }     

          return false;
        };

        return client;
      };
    }

    if(enableInterceptor) {
      dio.interceptors.add(DioInterceptor());      
    }    

    return dio;
  }

  bool _isExceptUrl(List<String> exceptUrlList, String baseUrl) {

    var result = false;

    for (var url in exceptUrlList) {
      
      if(url == baseUrl) {
        result = true;
        break;
      }

    }

    return result;
  }

}