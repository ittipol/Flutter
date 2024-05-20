import 'package:flutter_demo/presentation/views/common/web_view/web_view.dart';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewDemoView extends ConsumerStatefulWidget {

  const WebViewDemoView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewDemoView();
}

class _WebViewDemoView  extends ConsumerState<WebViewDemoView> {

  @override
  Widget build(BuildContext context) {    

    return const WebView(
      url: "https://riverpod.dev/",
    );
  }

  // Future<bool> _checkConection(String url) async {

  //   var response = await http.get(Uri.parse(url))
  //   .timeout(
  //     const Duration(seconds: 5),
  //     onTimeout: () {
  //       return http.Response('Error', 408);
  //     },
  //   )
  //   .onError((error, stackTrace) {
  //     return http.Response('Error', 500);
  //   });

  //   return response.statusCode == 200;
  // }

}