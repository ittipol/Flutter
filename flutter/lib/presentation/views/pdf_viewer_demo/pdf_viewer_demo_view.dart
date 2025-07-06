import 'package:flutter/material.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/enum/modal_dialog_content_type.dart';
import 'package:flutter_demo/extension/loader_overlay_extension.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/modal_dialog/modal_dialog_content.dart';
import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer.dart';
import 'package:flutter_demo/presentation/views/pdf_viewer_demo/pdf_viewer_demo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PdfViewerView extends ConsumerStatefulWidget {

  const PdfViewerView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PdfViewerView();
}

class _PdfViewerView  extends ConsumerState<PdfViewerView> {  

  final urlPath = "${ApiBaseUrl.localhostWebAppBaseUrl}/pdf/PDF_Test.pdf";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      context.showLoaderOverlay();
      final value = await Helper.checkUrlActive(ApiBaseUrl.localhostWebAppBaseUrl);      
      ref.read(pdfViewerDemoIsActiveUrlProvider.notifier).state = value;

      await Future.delayed(const Duration(milliseconds: 1500), () {             
        context.hideLoaderOverlay();

        ref.read(pdfViewerDemoIsLoadedProvider.notifier).state = true;

        if(!value) {
          ModalDialogContent.show(context: context, type: ModalDialogContentType.howToStartServer);
        }
      });

    });    
  }

  @override
  Widget build(BuildContext context) {   

    final isActiveUrl = ref.watch(pdfViewerDemoIsActiveUrlProvider); 
    final isLoaded = ref.watch(pdfViewerDemoIsLoadedProvider); 

    return BlankPageWidget(
      body: Visibility(
        visible: isLoaded,
        child: _build(isActiveUrl ?? false)
      )
    );
  }

  Widget _build(bool isActiveUrl) {

    if(isActiveUrl) {
      return PdfViewer(
        pdfUrl: urlPath,
        renderAsChild: true,
      );
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Please start a server",
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
              fontSize: 24.spMin,
              color: Colors.black
            ),
          ),
          SizedBox(height: 8.r),
          Text(
            "This demo use PDF file from localhost",
            textAlign: TextAlign.center,
            style: const TextStyle().copyWith(
              fontSize: 16.spMin,
              color: Colors.black
            ),
          ),
          SizedBox(height: 8.r),
          const Divider(
            color: Colors.black54,
            thickness: 1,
          ),
          SizedBox(height: 8.r),
          GestureDetector(
            onTap: () {
              ModalDialogContent.show(context: context, type: ModalDialogContentType.howToStartServer);
            },
            child: Text(
              "How to start a server?",
              textAlign: TextAlign.center,
              style: const TextStyle().copyWith(
                fontSize: 16.spMin,
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          SizedBox(height: 8.r),
          GestureDetector(
            onTap: () {
              ModalDialogContent.show(context: context, type: ModalDialogContentType.androidSetProxyAddress);
            },
            child: Text(
              "How to set the Android Emulator proxy address?",
              textAlign: TextAlign.center,
              style: const TextStyle().copyWith(
                fontSize: 16.spMin,
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w700
              )
            )
          )
        ]
      ),
    );
  }

}