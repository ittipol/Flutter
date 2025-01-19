import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/core/constant/app_constant.dart';
import 'package:flutter_demo/data/app/certificate.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

// Future<SecurityContext> get globalContext async {
//   final sslCert = await rootBundle.load('assets/certificate/cert_1/server.crt');
//   SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//   return securityContext;
// }

class CertificateHelper {  

  static Future<void> init() async {
    Certificate.certificate = await rootBundle.loadString(AppConstant.cert1);
  }

  static Future<bool> checkCertificatePinning(String url, Map<String,String> headers, List<String> allowedSHAFingerprints) async {
    try{
      final secure = await HttpCertificatePinning.check(
        serverURL: url,
        headerHttp: headers,
        sha: SHA.SHA256,
        allowedSHAFingerprints:allowedSHAFingerprints,
        timeout : 50
      );

      if(secure.contains("CONNECTION_SECURE")){
        return true;
      } else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  static Future<http.Client> getSSLPinningClient() async {

    final sslCert = await rootBundle.load('assets/certificate/cert_1/server.crt');
    final sslCert2 = await rootBundle.load('assets/certificate/cert_2/server.crt');

    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    securityContext.setTrustedCertificatesBytes(sslCert2.buffer.asInt8List());

    final client = HttpClient(context: securityContext);
    // client.idleTimeout = const Duration(seconds: 15);
    // client.connectionTimeout = const Duration(seconds: 30);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;

    final ioClient = IOClient(client);
    return ioClient;
  }

  static Future<http.Client> getLocalHostSSLPinningClient({bool Function(X509Certificate, String, int)? callback}) async {
    final securityContext = SecurityContext.defaultContext;

    final client = HttpClient(context: securityContext);
    client.badCertificateCallback = callback ?? (X509Certificate cert, String host, int port) {

      if(cert.pem.isNotEmpty && cert.pem == Certificate.certificate) {
        return true;
      }

      return false;
    };

    final ioClient = IOClient(client);
    return ioClient;
  }

  static String getCertFingerPrint(String cert) {
    // var cert = await readCert(path);

    X509CertificateData data = X509Utils.x509CertificateFromPem(cert);

    return data.sha256Thumbprint ?? "";
  }

  static Future<String> readCert(String path) async {
    // final sslCert = await rootBundle.load(path);
    // final data = sslCert.buffer.asUint8List();
    // final pemString = utf8.decode(data);
    // final pemArray = pemString.split("-----END CERTIFICATE-----");
    // final cert = [pemArray[0], "-----END CERTIFICATE-----"].join("");
    // return cert;
    return await rootBundle.loadString(path);
  }
}