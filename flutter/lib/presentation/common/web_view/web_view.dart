import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer.dart';
import 'package:flutter_demo/presentation/common/web_view/components/web_view_progress_bar.dart';
import 'package:flutter_demo/presentation/common/web_view/web_view_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebView extends ConsumerStatefulWidget {

  final String url;
  final void Function()? onTabBackBtn;
  final bool displayProgressBar;
  final void Function(JavaScriptMessage)? onMessageReceived;
  final void Function(JavaScriptMessage)? onMobilePagePushMessageReceived;
  final void Function(JavaScriptMessage)? onWebPageChangeMessageReceived;
  
  const WebView({  
    required this.url,
    this.displayProgressBar = true,
    this.onTabBackBtn,
    this.onMessageReceived,
    this.onMobilePagePushMessageReceived,
    this.onWebPageChangeMessageReceived,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebView();
}

class _WebView  extends ConsumerState<WebView> {

  WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {   
      if(widget.url.isNotEmpty) _webViewController.loadRequest(Uri.parse(widget.url));
    });

    final controller = WebViewController()
    ..enableZoom(true)
    ..addJavaScriptChannel(
      'Print',
      onMessageReceived: (JavaScriptMessage message) {
        context.showLoaderOverlay();
        print(message.message);
      },
    )
    ..addJavaScriptChannel(
      'Test',
      onMessageReceived: (JavaScriptMessage message) {
        if(widget.onMessageReceived != null) {
          widget.onMessageReceived?.call(message);
        }
      },
    )
    ..addJavaScriptChannel(
      'Next',
      onMessageReceived: (JavaScriptMessage message) {
        context.showLoaderOverlay();
        print(message.message);
        Future.delayed(const Duration(seconds: 1), () {
          context.hideLoaderOverlay();
        });
      },
    )
    ..addJavaScriptChannel(
      'Page',
      onMessageReceived: (JavaScriptMessage message) {
        context.showLoaderOverlay();
        Navigator.pushNamed(context, RouteName.uiDemoView).then((value) => {
          print("Call Back from page")
        });
        Future.delayed(const Duration(seconds: 1), () {
          context.hideLoaderOverlay();
        });
      },
    )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          print("start");
        },
        onPageFinished: (url) {
          print("finish");
        },
        onUrlChange: (change) {
          // context.showLoaderOverlay();

          // Future.delayed(const Duration(seconds: 1), () {
          //   context.hideLoaderOverlay();
          // });
        },
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewer(pdfUrl: request.url)));
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;          
        },
      ),
    );

    _webViewController = controller;    

    super.initState();    
  }

  @override
  void dispose(){
    _webViewController.clearCache();
    _webViewController.clearLocalStorage();
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
    bool canNavigate = await _webViewController.canGoBack();

    if(canNavigate) {
      await _webViewController.goBack();
    }

    return canNavigate;
  }

  Widget _webViewWidget() {
    
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: _webViewController.platform,
          displayWithHybridComposition: true,
        ),
      );
    } else {
      return WebViewWidget(controller: _webViewController);
    }
  }

  bool isPdf(String url) {
    return url.endsWith(".pdf");
  }

}