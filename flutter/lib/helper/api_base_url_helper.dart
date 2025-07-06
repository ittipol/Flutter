import 'dart:io';

import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';

class ApiBaseUrlHelper {
  
  static void init() {
    ApiBaseUrl.localhostUrl = getLocalhostUrl();
    ApiBaseUrl.localhostApiBaseUrl = getLocalhostBaseUrl(ApiBaseUrl.localhostUrl, includePort: 1);
    ApiBaseUrl.localhostWebAppBaseUrl = getLocalhostBaseUrl(ApiBaseUrl.localhostUrl, includePort: 2, useHttps: false);
  }

  static String getLocalhostUrl() {
    if(Platform.isAndroid) {
      return AppConstant.androidLocalhost;
    }else if(Platform.isIOS) {
      return AppConstant.iosLocalhost;
    }

    return "";
  }

  static String getLocalhostBaseUrl(String localhostUrl, {int includePort = 0, bool useHttps = true}) {

    var host = localhostUrl;

    var protocol = "http://";

    if(useHttps) protocol = "https://";

    switch (includePort) {
      case 1:
        host = "$protocol$host:${AppConstant.localhostApiPort5050}";
        break;
      case 2:
        host = "$protocol$host:${AppConstant.localhostWebAppPort}";
        break;
      default:
    }

    return host;
  }
}