import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/web_view/web_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:js' as js;

class JsChannelView extends ConsumerStatefulWidget {
  const JsChannelView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JsChannelView();
}

class _JsChannelView extends ConsumerState<JsChannelView> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Future.delayed(const Duration(seconds: 1), () {
    //     context.hideLoaderOverlay();
    //   });
    // });
  }

  // @override
  // void dispose(){
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    print(ApiBaseUrl.localhostWebAppBaseUrl);

    return BlankPageWidget(
        showBackBtn: false,
        bottomNavigationBar: SafeArea(
          top: false,
          bottom: true,
          child: Container(
            padding: EdgeInsets.all(8.r),
            color: Colors.transparent,
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                elevation: 0,
              ),
              child: SizedBox(
                height: 40.r,
                child: Center(
                  child: Text("Next Page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                )
              ),
            ),
          ),
        ),
        body: WebView(
          // url: ApiBaseUrl.localhostWebAppBaseUrl,
          // url: "http://localhost:5055",
          url: "http://localhost:3000",
          onMessageReceived: {
            "Print":(message) {
              print(message.message);
            },
            "Next":(message) async {
              context.showLoaderOverlay();
              print(message.message);
              await Future.delayed(const Duration(seconds: 1), () {
                context.hideLoaderOverlay();
              });
            },
            "Back":(message) async {
              context.showLoaderOverlay();
              print(message.message);
              await Future.delayed(const Duration(seconds: 1), () {
                context.hideLoaderOverlay();
              });
            }
          },
        )
      );
  }

  // void _test() {
  //   js.context.callMethod('alertMessage', ['Flutter is calling upon JavaScript!']);
  // }
}
