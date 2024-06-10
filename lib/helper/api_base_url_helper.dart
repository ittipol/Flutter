import 'dart:io';

import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';

class ApiBaseUrlHelper {
  
  static void init() {
    ApiBaseUrl.localhostBaseUrl = getLocalhostBaseUrl();
  }

  static String getLocalhostBaseUrl({includePort = true}) {

    var host = "";

    if(Platform.isAndroid) {
      host = AppConstant.androidLocalhost;
    }else if(Platform.isIOS) {
      host = AppConstant.iosLocalhost;
    }

    if(includePort) {
      host = "$host:${AppConstant.localhostApiPort}";
    }

    return host;
  }
}