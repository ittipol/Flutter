import 'package:flutter/services.dart';
import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/views/certificate/certificate_pinning/certificate_pinning_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificatePinningController extends StateNotifier<CertificatePinningState> {

  CertificatePinningController() : super(CertificatePinningState());

  Future<void> checkCert1(bool value) async {
    state = state.copyWith(isCert1Allowed: value);  
  }

  Future<void> checkCert2(bool value) async {
    state = state.copyWith(isCert2Allowed: value);  
  }

  Future<String> connectToServer1() async {
    final url = "https://${ApiBaseUrl.localhostUrl}:${AppConstant.localhostApiPort5050}/health";
    var certificate = "";

    if(state.isCert1Allowed) {
      certificate = await rootBundle.loadString(AppConstant.cert1);
    }

    var response = await Helper.httpGet(url, callback: (cert, host, port) {      

      if(cert.pem.isNotEmpty && cert.pem == certificate) {
        return true;
      }

      return false;
    });

    return response;
  }

  Future<String> connectToServer2() async {
    final url = "https://${ApiBaseUrl.localhostUrl}:${AppConstant.localhostApiPort5051}/health";
    var certificate = "";

    if(state.isCert2Allowed) {
      certificate = await rootBundle.loadString(AppConstant.cert2);
    }

    var response = await Helper.httpGet(url, callback: (cert, host, port) {      

      if(cert.pem.isNotEmpty && cert.pem == certificate) {
        return true;
      }

      return false;
    });

    return response;
  }

  Future<bool> checkServer1IsActive() async {
    final url = "https://${ApiBaseUrl.localhostUrl}:${AppConstant.localhostApiPort5050}/health";
    var certificate = "";

    if(state.isCert1Allowed) {
      certificate = await rootBundle.loadString(AppConstant.cert1);
    }

    var response = await Helper.checkUrlActive(url, callback: (cert, host, port) {      

      if(cert.pem.isNotEmpty && cert.pem == certificate) {
        return true;
      }

      return false;
    });

    return response;
  }

  Future<bool> checkServer2IsActive() async {
    final url = "https://${ApiBaseUrl.localhostUrl}:${AppConstant.localhostApiPort5051}/health";
    var certificate = "";

    if(state.isCert1Allowed) {
      certificate = await rootBundle.loadString(AppConstant.cert2);
    }

    var response = await Helper.checkUrlActive(url, callback: (cert, host, port) {      

      if(cert.pem.isNotEmpty && cert.pem == certificate) {
        return true;
      }

      return false;
    });

    return response;
  }

}