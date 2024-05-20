import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/views/common/blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/common/web_view/components/web_view_progress_bar.dart';
import 'package:flutter_demo/presentation/views/common/web_view/web_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebView extends ConsumerStatefulWidget {

  final String url;
  final void Function()? onTabBackBtn;
  final bool displayProgressBar;
  
  const WebView({  
    required this.url,
    this.displayProgressBar = true,
    this.onTabBackBtn,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebView();
}

class _WebView  extends ConsumerState<WebView> {

  WebViewController _webViewcontroller = WebViewController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {       
      if(widget.url.isNotEmpty) _webViewcontroller.loadRequest(Uri.parse(widget.url));
    });

    final controller = WebViewController()
    ..enableZoom(true)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {          
          ref.read(webViewProvider.notifier).updateLoadingPercentage(progress);

          if(progress == 100) {
            ref.read(webViewProvider.notifier).updateLoadingPercentage(100);

            Future.delayed(const Duration(milliseconds: 300)).then((value) {
              ref.read(webViewProvider.notifier).updateLoadingPercentage(0);
            });
          }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          
          if(isPdf(request.url)) {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewer(pdfUrl: request.url)));
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;          
        },
      ),
    );

    _webViewcontroller = controller;    

    super.initState();    
  }

  @override
  void dispose(){
    _webViewcontroller.clearCache();
    _webViewcontroller.clearLocalStorage();
    WebViewCookieManager().clearCookies();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlankPageWidget(
      onTabBackBtn: () async {
        if(! await _webviewBackButton()) {
          if(!context.mounted) return;

          if(widget.onTabBackBtn != null){
            widget.onTabBackBtn?.call();
          } else {
            if(Navigator.canPop(context)) Navigator.pop(context);
          }
        }       
      },
      body: Stack(
        children: [          
          _webViewWidget(),
          Visibility(
            visible: widget.displayProgressBar,
            child: const WebViewProgressBar(),
          )
        ],
      ),
    );
  }

  Future<bool> _webviewBackButton() async {
    bool canNavigate = await _webViewcontroller.canGoBack();

    if(canNavigate) {
      await _webViewcontroller.goBack();
    }

    return canNavigate;
  }

  Widget _webViewWidget() {
    
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: _webViewcontroller.platform,
          displayWithHybridComposition: true,
        ),
      );
    } else {
      return WebViewWidget(controller: _webViewcontroller);
    }
  }

  bool isPdf(String url) {
    return url.endsWith(".pdf");
  }

}