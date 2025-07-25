import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/helper/certificate_helper.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Helper {

  Future<String?> getAndroidVersion() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.release;
  }
  throw UnsupportedError("Platform is not Android");
}

  static Future<Uint8List> getByteArrayFromUrl(String url, {name}) async {
    try {
      final data = await http.get(Uri.parse(url));
      return data.bodyBytes;
    } catch (e) {
      throw Exception("Error opening file from URL");
    }
  }  

  static Future<File> getFileFromUrl(String url, {name}) async {
    
    var fileName = basename(url);
    
    if (name != null) {
      fileName = name;
    }

    try {
      final data = await http.get(Uri.parse(url));
      final bytes = data.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$fileName");
      return await file.writeAsBytes(bytes, flush: true);
    } catch (e) {
      throw Exception("Error opening file from URL");
    }
  }  

  static String addBase64Padding(String base64) {
    
    if(base64.isEmpty) return "";

    var result = base64.length % 4;
    
    if (result > 0) { 
        base64 += '=' * (4 - result);
    }

    return base64;
  }    

  static Future<bool> checkUrlActive(String url, {bool Function(X509Certificate, String, int)? callback}) async {

    // var httpClient = await CertificateHelper.getSSLPinningClient();
    var httpClient = await CertificateHelper.getLocalHostSSLPinningClient(callback: callback);

    var response = await httpClient.get(Uri.parse(url))
    .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    )
    .onError((error, stackTrace) {
      return http.Response('Error', 500);
    });

    httpClient.close();

    return response.statusCode == 200;
  }

  static Future<String> httpGet(String url, {bool Function(X509Certificate, String, int)? callback}) async {
    
    var httpClient = await CertificateHelper.getLocalHostSSLPinningClient(callback: callback);

    var response = await httpClient.get(Uri.parse(url))
    .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    )
    .onError((error, stackTrace) {
      return http.Response('Error', 500);
    });

    httpClient.close();

    // if(response.statusCode == 200) {

    // }else {

    // }

    return response.body;
  }    

}