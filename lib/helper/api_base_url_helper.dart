import 'dart:io';

import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';

class ApiBaseUrlHelper {
  
  static void init() {
    ApiBaseUrl.localhostUrl = getLocalhostUrl();
    ApiBaseUrl.localhostApiBaseUrl = getLocalhostBaseUrl(ApiBaseUrl.localhostUrl, includePort: 1);
    ApiBaseUrl.localhostWebAppBaseUrl = getLocalhostBaseUrl(ApiBaseUrl.localhostUrl, includePort: 2);
  }

  static String getLocalhostUrl() {
    if(Platform.isAndroid) {
      return AppConstant.androidLocalhost;
    }else if(Platform.isIOS) {
      return AppConstant.iosLocalhost;
    }

    return "";
  }

  static String getLocalhostBaseUrl(String localhostUrl, {int includePort = 0}) {

    var host = localhostUrl;

    switch (includePort) {
      case 1:
        host = "$host:${AppConstant.localhostApiPort}";
        break;
      case 2:
        host = "$host:${AppConstant.localhostWebAppPort}";
        break;
      default:
    }

    return host;
  }
}