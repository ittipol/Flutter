import 'dart:convert';
import 'dart:io';
import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Helper {

  static Future<File> getFileFromUrl(String url, {name}) async {
    
    var fileName = basename(url);
    
    if (name != null) {
      fileName = name;
    }

    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  static bool isValidEmail(String email) {
    var urlRegex = RegExp(r'''(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');
    return  urlRegex.hasMatch(email);
  }
  
  static bool isValidUrl(String url) {
    var regex = RegExp(r"^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$");
    return regex.hasMatch(url);
  }

  static R jsonDeserialize<R,T>(String source, R Function(T) callBack) {
    dynamic obj = {};

    if(source.isNotEmpty) {
      obj = jsonDecode(source);
    }

    return callBack.call(obj);
  }

  static String addBase64Padding(String base64) {
    
    if(base64.isEmpty) return "";

    var result = base64.length % 4;
    
    if (result > 0) { 
        base64 += '=' * (4 - result);
    }

    return base64;
  }  

  static Future<bool> checkUrlActive(String url) async {

    var response = await http.get(Uri.parse(url))
    .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    )
    .onError((error, stackTrace) {
      return http.Response('Error', 500);
    });

    return response.statusCode == 200;
  }  

  static String getLocalhostUrl({includePort = true}) {

    var host = "";

    if(Platform.isAndroid) {
      host = AppConstant.androidLocalhost;
    }

    if(Platform.isIOS) {
      host = AppConstant.iosLocalhost;
    }

    if(includePort) {
      host = "$host:${AppConstant.localhostApiPort}";
    }

    return host;
  }

}