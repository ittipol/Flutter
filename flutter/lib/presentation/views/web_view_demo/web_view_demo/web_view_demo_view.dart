import 'package:flutter_demo/presentation/common/web_view/web_view.dart';
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
  
}