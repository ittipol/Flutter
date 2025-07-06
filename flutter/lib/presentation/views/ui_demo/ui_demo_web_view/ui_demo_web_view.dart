import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/presentation/common/web_view/web_view.dart';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UiDemoWebView extends ConsumerStatefulWidget {

  const UiDemoWebView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UiDemoWebView();
}

class _UiDemoWebView  extends ConsumerState<UiDemoWebView> {

  @override
  Widget build(BuildContext context) {    

    print(ApiBaseUrl.localhostWebAppBaseUrl);

    return WebView(
      url: ApiBaseUrl.localhostWebAppBaseUrl
    );
  }
  
}