import 'dart:io';
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

}